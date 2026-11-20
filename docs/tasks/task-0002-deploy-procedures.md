---
nummer: task-0002
titel: Procedurerne lægges i databasen ved opstart
status: afsluttet
kilde: interview
oprettet: 2026-11-20
---

# task-0002 — Procedurerne lægges i databasen ved opstart

## Hvad og hvorfor
Procedurerne i `sql/` lægges i dag i databasen i hånden, fil for fil. Det kan glemmes, og så kører et nyt image mod gamle procedurer. README lover et script der ikke findes. Containeren skal selv lægge procedurerne i databasen når den starter, så de altid passer til det image der kører.

## Færdig når
- [ ] Når programmet starter, lægges alle procedurer fra `sql/meta/` og `sql/dw/` i databasen, før den daglige kørsel planlægges eller køres straks.
- [ ] Det sker samlet: fejler én procedure, er ingen af dem ændret i databasen.
- [ ] Fejler det, står det i loggen hvilken fil der fejlede og hvorfor, og programmet stopper med en fejlkode uden at køre ETL'en.
- [ ] Lykkes det, står det i loggen hvor mange procedurer der blev lagt i databasen.
- [ ] Tabeldefinitionerne under `sql/tables/` lægges ikke i databasen.
- [ ] Der er ingen nye nøgler i `.env` og ingen nye afhængigheder.
- [ ] Opdelingen af hver procedurefil i de dele der sendes til databasen, er prøvet på alle filer uden at forbinde til databasen, og resultatet står i noterne.
- [ ] `CLAUDE.md` siger at procedurerne lægges ved opstart, og ikke længere at det gøres i hånden.

## Sådan bygger vi det
Nyt modul `utils/deploy_procedures.py` med en funktion `deploy_procedures(engine: Engine) -> int`, i samme stil som de øvrige moduler i `utils/` (docstring med `Description`, `Flow`, `Args`, `Returns`, `Raises`).

- Find filerne ud fra projektets rod, ikke den aktuelle mappe: først `sql/meta/*.sql`, så `sql/dw/*.sql`, hver i alfabetisk orden. `sql/tables/` indgår ikke.
- Læs filerne som UTF-8. Filerne har CRLF.
- Del hver fil ved linjer der kun består af `GO` (uanset store/små bogstaver og mellemrum omkring). Tomme dele springes over.
- Send hver del med `conn.exec_driver_sql(...)` — ikke `text()`, som ville tolke `:` i procedurerne som parametre.
- Alt inden for én `with engine.begin() as conn:`, så en fejl ruller det hele tilbage.
- Ved fejl: log filnavnet og fejlen med `logger.error`, og kast videre.
- Returnér antallet af filer der er lagt i databasen, og log det.

I `main.py`: under `if __name__ == '__main__':`, efter `setup_logging()` og før valget mellem `RUN_NOW` og scheduleren, opret engine og kald `deploy_procedures`. En fejl fanges ikke — den stopper processen med en fejlkode.

## Hvad vi ikke rører
- SQL-filerne i `sql/` — hverken procedurer eller tabeller.
- `utils/load_stg.py`, `utils/run_etl.py`, `utils/get_engine.py`, `constants.py`.
- `main()` selv — kun opstarten under `__main__` ændres.
- `Dockerfile`, `docker-compose.yaml` og workflowet. `restart: on-failure` står som den er.
- Databasen. Der forbindes ikke til den under udviklingen.

## Afhænger af
intet

## Beslutninger
- BESLUTTET: Procedurerne lægges i databasen ved opstart af containeren — de passer så altid til imaget. Afvist: et script der køres i hånden.
- BESLUTTET: Samme databasebruger som ETL'en, ingen nye nøgler. Har brugeren ikke lov til at ændre procedurer i `dw` og `meta`, giver mennesket den rettigheden før udrulning. Afvist: en separat bruger til at lægge procedurerne i databasen.
- BESLUTTET: Fejler det, stopper programmet med en fejlkode — ny kode må ikke køre mod gamle procedurer. Afvist: log fejlen og fortsæt.
- BESLUTTET: Alle procedurer i én transaktion — databasen står aldrig med halvdelen af de nye. Afvist: én fil ad gangen.
- BESLUTTET: Alle filer hver gang, ikke kun ændrede — `CREATE OR ALTER` kan køres igen, og der er ingen tilstand at holde styr på.
- BESLUTTET: Tabellerne lægges ikke i databasen — deres filer kan ikke køres mod en database hvor tabellen findes.
- BESLUTTET: Ingen tests i denne opgave — projektet har ingen testopsætning, og den er sit eget emne. Opdelingen prøves i stedet på alle filer uden database.

## Åbne punkter

## Indvendinger

---

## Developers noter

### Hvad er lavet

- **Nyt modul `utils/deploy_procedures.py`** med `deploy_procedures(engine: Engine) -> int` og to hjælpere, `_get_procedure_files()` og `_split_batches(path)`. Stilen følger `utils/run_etl.py`: `####`-skillelinjer, type hints, docstrings med `Description`/`Flow`/`Args`/`Returns`/`Raises`. Modulet læser ingen nøgler og kalder derfor ikke `load_dotenv()`, ligesom `run_etl.py`.
  - Filerne findes ud fra projektets rod (`Path(__file__).resolve().parent.parent`): først `sql/meta/*.sql`, så `sql/dw/*.sql`, alfabetisk i hver. `sql/tables/` indgår ikke.
  - Filen læses som UTF-8 fra bytes, så linjeskiftene sendes til databasen som de står i filen. Den deles ved linjer der kun er `GO` (store/små bogstaver ligegyldige, mellemrum og tabulator omkring tilladt, CRLF og LF). Tomme dele springes over.
  - Hver del sendes med `conn.exec_driver_sql(...)`, alt inden for én `with engine.begin() as conn:`.
  - Ved fejl, både ved læsning og kørsel: `logger.error('Failed to deploy %s: %s', <sti fra roden>, fejl)`, og fejlen kastes videre. Transaktionen rulles tilbage.
  - Ved succes logges `Deployed N procedures`, og N (antal filer) returneres. Før starten logges `Deploying N procedure files`.
- **`main.py`**: under `if __name__ == '__main__':`, efter `setup_logging()` og før valget mellem `RUN_NOW` og scheduleren: `startup_engine: Engine = get_engine()` og `deploy_procedures(startup_engine)`. Ingen `try`, så en fejl stopper processen med fejlkode 1, før ETL'en eller scheduleren startes. `main()` er ikke rørt.
- **`CLAUDE.md`**: afsnittet om at lægge procedurerne i hånden er erstattet af at de lægges ved opstart. Mappestrukturen nævner det nye modul, og de to sætninger der sagde "læg i databasen"/"som procedurerne" er rettet, så de passer.

Holdt op mod `Færdig når`:

| Punkt | Holdt | Hvordan |
|---|---|---|
| Alle procedurer i `sql/meta/` og `sql/dw/` ved start, før scheduler/straks-kørsel | ja | Kaldet står før `run_now` i `main.py` |
| Samlet; fejler én, er ingen ændret | ja | Én `engine.begin()`. Med falsk engine: fejl i fil 28 gav `begin` → `rollback`, og fejlen kom videre |
| Fejl: fil og årsag i loggen, fejlkode, ingen ETL | ja | `logger.error` med stien og så `raise`. Uncaught i `__main__` giver exit-kode 1 |
| Succes: antal i loggen | ja | `Deployed 29 procedures` (falsk engine: returnerede 29, sendte 29 dele, `begin` → `commit`) |
| `sql/tables/` lægges ikke | ja | Kun `sql/meta` og `sql/dw` globbes, ikke rekursivt |
| Ingen nye nøgler, ingen nye afhængigheder | ja | Kun `re`, `logging` og `pathlib` fra standardbiblioteket, og `sqlalchemy`, der allerede er en afhængighed |
| Opdelingen prøvet offline på alle filer | ja | Se nedenfor |
| `CLAUDE.md` opdateret | ja | Se ovenfor |

**Offline prøve af opdelingen.** Der er ikke forbundet til databasen, og `main.py` er ikke kørt. Et engangsscript i scratchpad importerede kun `utils.deploy_procedures` og kørte `_split_batches` på alle 29 filer, to gange: én gang på arbejdskopien (CRLF) og én gang på versionen i git (LF, hentet med `git show :<sti>`). Bagefter kørte det `deploy_procedures` mod en falsk engine, der kun noterer hvad der sendes.

- 29 filer, i rækkefølgen meta (4) og så dw (25). Ingen fra `sql/tables/`.
- **Alle 29 filer gav præcis 1 del i begge udgaver.** Hver del indeholder `CREATE OR ALTER PROCEDURE`, ingen del har en `GO`-linje tilbage, og hver del slutter på `END;`.
- Filer med `:` i teksten kom igennem urørt: `usp_load_dim_student_sensitive` (1), `usp_load_fact_absence_daily` (2), `usp_load_fact_absence_lesson` (2) og `usp_refresh_dim_date_school_year_label` (1).
- 15 filer er ren ASCII, 14 har andre UTF-8-tegn. Alle dekodes uden fejl. Ingen af dem har BOM.
- Ingen fil indeholder `?`, så pyodbc's pladsholder kan heller ikke blive ramt.
- Kanttilfælde: `"SELECT 1\r\n  go \r\n\r\nSELECT 2\r\nGO\r\nSELECT 'GO' AS GOAL\r\nGO\r\n\r\n"` gav tre dele: `SELECT 1`, `SELECT 2`, `SELECT 'GO' AS GOAL`.

`py_compile` af `main.py` og `utils/deploy_procedures.py` er grøn. Projektet har ingen linter (`CLAUDE.md`: "findes ikke"), og der er ingen i `.venv`.

**Til den der driver containeren.** README er ikke rørt; det her skal architect have:

- Containeren forbinder nu til databasen **ved start**, ikke først kl. `RUN_AT`. Den lægger alle 29 procedurer i databasen hver gang den starter.
- Mangler en `DB_*`-nøgle, eller kan databasen ikke nås ved start, stopper containeren med en fejl. Det gør den også hvis en procedure fejler. Med `restart: on-failure` starter den så igen og igen, indtil fejlen er rettet. Før startede scheduleren uanset hvad.
- Databasebrugeren skal have lov til at oprette og ændre procedurer i `dw` og `meta`, som besluttet i opgaven.
- Ingen nye indstillinger og ingen nye kommandoer. Man udruller en ændret procedure ved at starte containeren med det nye image.
- I loggen ved start: `Deploying 29 procedure files`, så `Deployed 29 procedures`. Ved fejl: `Failed to deploy sql/dw/<fil>.sql: <fejl>` og en traceback.

### Hvad er ikke lavet, og hvorfor

- Prøven mod en rigtig database er ikke lavet. Opgaven siger at der ikke forbindes under udviklingen. Om brugeren har rettighederne, og om alle 29 kan oprettes i én transaktion på serveren, ses først ved første start.
- Ingen tests er committet. Opgaven siger ingen tests (`BESLUTTET`). Prøvescriptet lå i scratchpad og er ikke en del af repoet.
- README er ikke rørt, efter rollen. Det der skal derind, står ovenfor.

### Uklart

- **Ingen filer fundet tæller som succes.** Mangler `sql/` i imaget, fx fordi `.dockerignore` en dag udelukker den, logges `Deployed 0 procedures`, og ETL'en kører videre mod de gamle procedurer. Det er netop det opgaven vil undgå. Opgaven siger ikke at 0 er en fejl, så jeg har ikke gjort det til en. I dag kommer `sql/` med i imaget gennem `COPY . .`, og `.dockerignore` udelukker den ikke. Skal 0 filer stoppe programmet?
- **Linjeskift.** Opgaven siger at filerne har CRLF. Det passer kun for arbejdskopien på Windows. I git, og dermed i det image GitHub Actions bygger, har de LF, fordi `core.autocrlf=true` og der ikke er nogen `.gitattributes`. Opdelingen håndterer begge og er prøvet på begge. Konsekvensen er kun kosmetisk: procedureteksten i databasen får LF når containeren lægger den, hvor den fik CRLF fra SSMS.
