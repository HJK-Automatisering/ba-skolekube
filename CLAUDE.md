# ba-skolekube

Daglig ETL-pipeline der henter fire udtræk fra Tabulex (IST Skole360) — elevdata, skolehistorik, fravær og karakterer — fra et filshare, lægger dem i staging-tabeller i SQL Server og kører derefter en samleprocedure, der bygger datavarehusets dimensioner og fakta.
Kører i en Docker-container med en indbygget scheduler, én gang i døgnet.
Python-delen er tynd (indlæsning og kald); forretningslogikken ligger i T-SQL under `sql/`.

Procesregler står i `AGENTS.md`. Skema-, tabel- og procedurenavne må nævnes; miljøværdier må ikke (se afvigelsen nederst i `AGENTS.md`).

## Stak

| Del | Version |
|---|---|
| Python i containeren | 3.12 (`python:3.12-slim-bookworm`) |
| Python i lokal `.venv` | 3.13 — afviger fra containeren |
| pandas | 3.0.1 |
| SQLAlchemy | 2.0.48 (Core), driver `pyodbc` 5.3.0 |
| ODBC-driver | Microsoft ODBC Driver 18 for SQL Server |
| Scheduler | `schedule` 1.2.2 |
| Konfiguration | `python-dotenv` 1.2.2 |
| Database | SQL Server, T-SQL stored procedures |
| Byg og udrulning | GitHub Actions bygger og publicerer image til GHCR ved push til `main` og ved `v*.*.*`-tags; driften kører det via Portainer med `stack.env` |

Afhængigheder står i `requirements.txt` (gemt som UTF-16).

## Miljø

Der bruges `.venv` i projektroden. Kald fortolkeren direkte — aktivér ikke.

## Kommandoer

Indstillingerne står i `.env`. Nøglerne står i `.env.example`; kopiér den til `.env` og udfyld.

Installér afhængigheder:

```powershell
.venv\Scripts\python.exe -m pip install -r requirements.txt
```

Kør én gang lokalt, uden at vente på scheduleren — sæt `RUN_NOW=true` i `.env` og kør:

```powershell
.venv\Scripts\python.exe main.py
```

Med `RUN_NOW` sat til andet end `true` starter scheduleren og kører dagligt kl. `RUN_AT`.

Byg og kør containeren lokalt (kræver det eksterne volume med filsharet, se `README.md`):

```powershell
docker compose up --build
docker compose stop
```

Læg procedurerne i databasen: **i hånden, fil for fil**, fx ved at åbne filen i SSMS mod `$DB_SERVER` / `$DB_NAME` og køre den. Alle filer er `CREATE OR ALTER ... GO`, så de kan køres igen. Kør den ændrede procedure — og `dw/usp_master.sql`, hvis et trin er tilføjet eller fjernet. Der findes intet deploy-script (README nævner et, men det er aldrig committet).

Tests, linter og formatter: **findes ikke.**

## Mappestruktur

```
main.py                 Indgang: scheduler eller straks-kørsel (RUN_NOW), kalder load og ETL
constants.py            Filnavne -> stg-tabeller, kolonneomdøbning, kolonner der droppes
utils/
  get_engine.py         SQLAlchemy-engine fra DB_*-nøglerne
  load_stg.py           Læser filerne, parser multitype-filer, DELETE + to_sql i stg
  run_etl.py            EXEC dw.usp_master på rå pyodbc-forbindelse med autocommit
  setup_logging.py      logging til stdout
sql/
  meta/                 Kørselslog: start/afslut kørsel og trin
  dw/                   usp_master + én procedure pr. dimension/fakta + oprydning
  tables/               Tabeldefinitioner: schemas.sql + én fil pr. tabel under stg/, dw/, meta/
Dockerfile, docker-compose.yaml, .github/workflows/docker-publish.yml
```

**Tabeldefinitionerne (`CREATE TABLE`) for `stg`, `dw` og `meta` ligger i `sql/tables/`** — én fil pr. tabel i `sql/tables/<skema>/<tabel>.sql`, og skemaerne i `sql/tables/schemas.sql`. De er renset fra en SSMS-eksport og rummer kun struktur: kolonner, nøgler, indeks, standardværdier og kontroller. Rækkefølgen de skal oprettes i (fremmednøgler), står ikke nogen steder. Ændres en tabel, rettes dens fil og køres i hånden mod databasen, som procedurerne.

**Indholdet** af de dimensioner procedurerne læser men ikke fylder, ligger ikke i repoet: `dw.dim_date`, `dim_subject`, `dim_discipline`, `dim_exam_type`, `dim_class_type`, `dim_action_type`, `dim_referral_reason`, `dim_event_type`, `dim_absence_reason` (krævet af fremmednøglerne på de to fraværsfakta) og `dim_school_district` (statisk, lagt ind ved et migreringsscript der heller ikke er her).

## Dataflow

1. `load_all_stg_tables` læser de fire filer fra `FILE_PATH` (windows-1252, semikolon), omdøber kolonner efter `STG_RENAME` og tømmer og genindlæser hver stg-tabel. Alle rækker får samme `stg_load_date`.

   | Fil | stg-tabel |
   |---|---|
   | `elev_basis.csv` | `stg.student_basis` |
   | `elev_historik.csv` | `stg.student_history` |
   | `elev_fravaer.csv` | `stg.student_absence` |
   | `elev_karakterer.csv` | `stg.student_grades` |

2. `run_etl` kører `dw.usp_master`, som starter en kørsel i `meta.meta_run` og kalder trinene i fast rækkefølge: oprydning, udfyldning af fraværshuller, skoleårsetiketter, dimensioner, fakta, øjebliksbillede. Fejler et trin, markeres kørslen `failed`, og fejlen kastes videre.
3. Hvert trin tager `@run_id`, logger sig selv i `meta.meta_run_step` med antal læste, indsatte, opdaterede og slettede rækker, og kaster videre ved fejl.

Nyt trin: ny procedure i `sql/dw/` efter samme skabelon (`meta.usp_meta_start_step` / `finish_step` i `TRY`/`CATCH`), tilføj den i `usp_master` i den rigtige rækkefølge, og læg begge i databasen.

### Indlæsningsmønstre

| Mønster | Tabeller |
|---|---|
| `MERGE` (insert + update) | de fleste dimensioner, `fact_enrollment`, `fact_grade`, `fact_student_field`, `fact_absence_daily`, `fact_absence_lesson` |
| `MERGE` med sletning af det der ikke er i kilden | `dim_student` |
| Kun indsæt nyt | `dim_school_type`, `dim_student_type`, `dim_field_name`, `fact_student_event`, `fact_student_relocation` |
| Tøm og genindlæs | alle stg-tabeller, `fact_student_action`, `fact_student_snapshot` |

## Domænebegreber

- **Multitype-fil.** Historik, fravær og karakterer har flere sektioner i én fil. Linje 1 er metadata; en linje der starter med `2` er en sektionsheader; `3` er en sumlinje og springes over; øvrige linjer er data, og deres første felt bliver `row_type`. Har data flere kolonner end headeren, får de navnene `_extra_N`.
- **`row_type` i `stg.student_history`:** 4 indskrivning (`fact_enrollment`), 5 tiltag (`fact_student_action`), 6 hændelse (`fact_student_event`), 7 felt/værdi (`fact_student_field`, `dim_field_name`), 8 fraflytning til anden kommune (`fact_student_relocation`).
- **`row_type` i `stg.student_absence`:** 5 heldagsfravær, 7 halvdagsfravær, 6 fravær pr. lektion.
- **Elevnøglen.** `dw.dim_student_sensitive` rummer CPR, navne, adresse, forældres CPR og forældremyndighed, og den er der `student_id` opstår. Alle andre tabeller slår op via `cpr_nr` -> `student_id` og bærer kun `student_id`. `dw.dim_student` er den ikke-følsomme del (klasse, skole, tiltag, alder).
- **Sentinel `-1`.** Ukendt eller manglende opslag peger på `-1` i alle dimensioner; `student_id = -1` udelukkes overalt.
- **Skoleår** starter 1. august. `last_seen` i `dim_student_sensitive` er skoleåret som tekst, `ÅÅÅÅ/ÅÅÅÅ`, og opdateres i hver kørsel.
- **Oprydning (`usp_cleanup`).** Elever der ikke er set i de seneste fem skoleår, slettes fra alle fakta og begge elevdimensioner.
- **`school_year_label`** i `dim_date`: `Indeværende`, `Indeværende-1` … `Indeværende-4`; ældre datoer får `NULL`.
- **`date_id`** er datoen som heltal `yyyyMMdd`. `dim_date` har `is_weekend` og `is_vacation_day`, der afgør hvad der er en skoledag.
- **Hovedskole (`dim_main_school`).** En skole hører til en hovedskole; `include_absence` på hovedskolen afgør om dens elever får fraværsfakta. `previous_main_school_code` på `dim_student` er forrige hovedskole for elever på en bestemt skole, med skoledistrikt som reserve.
- **Fravær pr. dag (`fact_absence_daily`).** Én række pr. elev, dag og skole. Årsagskoder `S`, `L`, `U`, `F` med prioritet U > S > L > F. Heldag vinder over halvdag; to halvdage giver en hel dag; for klassetrin 0–6 tæller halvdag som hel dag. Værdien er højst 1.0. `IF` er en kunstig række med værdi 0.0 for elever uden registrering den dag. Registreringer der forsvinder fra kilden, nulstilles til `IF` inden for indeværende skoleår. Fremtidige datoer filtreres fra.
- **Fraværshuller (`usp_fill_absence_gaps`).** Ser ti skoledage tilbage; mangler en dag helt, kopieres elevsættet fra seneste dag med data og indsættes som `IF`.
- **Fravær pr. lektion (`fact_absence_lesson`)** er markeret *afventer udrulning* i proceduren, men kaldes af `usp_master`.
- **Øjebliksbillede (`fact_student_snapshot`)** er dagens elevbestand; tømmes og genindlæses hver kørsel.
- **Karakterer:** `sp1`/`sp2`/`sps` standpunkt, `arb1`/`arb2`/`arbs` arbejde, `prv` prøve; `fs10` markerer 10. klasse.

## Værdier i koden

Der står forretningsspecifikke koder i procedurerne i forvejen: skolekoder i `usp_load_dim_school` og `usp_load_dim_student`, distriktskoder i `usp_load_dim_student`. Gentag dem ikke i dokumenter, og tilføj ikke flere — de står som emne på `docs/BOARD.md`.

## Kodestil

- Python: type hints på alle variable, enkelte anførselstegn, `####`-skillelinjer, docstrings med `Description`, `Flow`, `Args`, `Returns`, `Raises`. Moduler kalder `load_dotenv()` selv.
- SQL: én procedure pr. fil, filnavn = procedurenavn, header-kommentar der beskriver mønstret, `CREATE OR ALTER`, `SET NOCOUNT ON`, trinlogging via `meta`.
- `usp_master` kører med `SET ANSI_WARNINGS OFF`, fordi advarsler ellers kommer op som fejl gennem pyodbc. `run_etl` bruger derfor en rå forbindelse med autocommit — proceduren styrer selv sine transaktioner.
