---
nummer: task-0001
titel: Tabeldefinitionerne ind i repoet
status: i-gang
kilde: interview
oprettet: 2026-11-20
---

# task-0001 — Tabeldefinitionerne ind i repoet

## Hvad og hvorfor
Procedurerne i `sql/` skriver til tabeller i `stg`, `dw` og `meta`, men tabellernes opbygning findes kun i databasen. Ingen kan se kolonner, nøgler eller indeks uden at åbne databasen, og en ændring i en procedure kan ikke holdes op mod den tabel den rammer. Strukturen skal ligge i repoet, så den kan læses og versionsstyres sammen med procedurerne.

## Færdig når
- [ ] Hver tabel i de tre skemaer har sin egen fil i repoet, og skemaerne selv står i én fil.
- [ ] Filerne beskriver strukturen alene: kolonner, nøgler, indeks, standardværdier og kontroller — intet indhold.
- [ ] Ingen fil nævner databasenavn, servernavn, ejer eller rettigheder.
- [ ] Hver fil afviger kun fra eksporten ved de linjer der er fjernet efter reglerne nedenfor, og ved en kort header.
- [ ] Hver tabel som procedurerne eller Python-koden læser eller skriver, har en fil. Mangler en, står det i noterne.
- [ ] Tabeller i eksporten som intet i repoet bruger, er nævnt i noterne.
- [ ] `CLAUDE.md` siger hvor definitionerne ligger, og ikke længere at de mangler.

## Sådan bygger vi det
Kilden er en eksport fra SSMS (*Generate Scripts*, én fil pr. objekt, kun skema), som mennesket har lavet. Stien til mappen gives ved afsendelsen. Mappen ligger uden for repoet og må ikke committes.

Placering:

```
sql/tables/schemas.sql              CREATE SCHEMA for stg, dw, meta
sql/tables/stg/<tabel>.sql
sql/tables/dw/<tabel>.sql
sql/tables/meta/<tabel>.sql
```

Filnavnet er tabelnavnet uden skema, som procedurerne i `sql/dw/` er navngivet.

Oprydning pr. fil:

- Konvertér fra UTF-16 til UTF-8 uden BOM, LF-linjeskift.
- Fjern `USE [...]`, SSMS' `/****** Object: ... ******/`-headere og alt der nævner database eller server.
- Fjern `AUTHORIZATION`, `GRANT`/`DENY` og ejerangivelser, hvis de er kommet med.
- Behold `SET ANSI_NULLS` og `SET QUOTED_IDENTIFIER` — de påvirker hvordan tabellen oprettes.
- Behold `GO`-separatorerne.
- Læg en header øverst i samme form som procedurernes: navnet og én linje om hvad tabellen er, og hvilken procedure der fylder den, hvis nogen.

Rækkefølgen tabellerne skal oprettes i (fremmednøgler), skrives ikke ned — det hører til emnet om en fuld database fra bunden.

## Hvad vi ikke rører
- Databasen. Der køres ingen DDL mod den.
- Procedurerne i `sql/dw/` og `sql/meta/`.
- Python-koden, `constants.py`, Docker-filerne og workflowet.
- `README.md`.

## Afhænger af
intet. Forudsætter at eksporten fra SSMS ligger klar — menneskets skridt.

## Beslutninger
- BESLUTTET: Kun struktur, uden indhold — en fuld database fra bunden kræver faste opslagsdata, hvoraf nogle er forretningsspecifikke koder. Den er sit eget emne. Afvist: fuld genskabelig database nu.
- BESLUTTET: Kilden er en eksport fra SSMS, lavet af mennesket — den kender alle nøgler og indeks præcist og giver ingen ny kode at vedligeholde. Afvist: et script der læser databasens katalog.
- BESLUTTET: Placering under `sql/tables/<skema>/` — adskilt fra procedurerne, samme navngivning. Afvist: tabellerne side om side med procedurerne i `sql/dw/`.
- BESLUTTET: Verifikation er en sammenligning med eksporten, ikke en kørsel — der findes ingen tom database at køre mod, og produktion røres ikke.
- BESLUTTET: Ændringer i en tabel skrives i dens fil og køres i hånden mod databasen, som procedurerne — samme fremgangsmåde som besluttet 2026-11-20.

## Åbne punkter

## Indvendinger

---

## Developers noter

### Hvad er lavet

Kriterierne fra `Færdig når`, punkt for punkt:

1. **Én fil pr. tabel, og skemaerne i én fil.** 36 tabelfiler og `sql/tables/schemas.sql`:
   - `sql/tables/stg/`: 4 filer (`student_basis`, `student_history`, `student_absence`, `student_grades`).
   - `sql/tables/dw/`: 30 filer (21 `dim_*` og 9 `fact_*`).
   - `sql/tables/meta/`: 2 filer (`meta_run`, `meta_run_step`).
   - `sql/tables/schemas.sql`: de tre `CREATE SCHEMA` i rækkefølgen `stg`, `dw`, `meta`, hver med sin `GO`.
2. **Kun struktur.** Eksporten havde ingen data. Filerne rummer `CREATE TABLE`, primærnøgler, én unik nøgle (`uq_dim_student_sensitive_cprnr`), fremmednøgler, `DEFAULT`er og `CHECK`-kontroller, som de stod i eksporten.
3. **Ingen database, server, ejer eller rettigheder.** `USE [...]` er fjernet fra alle 39 filer. Der var ingen `AUTHORIZATION`, `GRANT`, `DENY` eller ejerangivelser i eksporten. Genereringen stoppede ved den slags linjer, og en søgning i `sql/tables/` bagefter fandt intet. To ting står med vilje stadig:
   - `meta.meta_run` har kolonnerne `server_name` og `database_name` med standardværdierne `@@servername` og `db_name()`. Det er funktioner der kaldes ved kørsel, ikke navne, og de er en del af tabellens struktur.
   - `ON [PRIMARY]` er standardfilgruppen, ikke et navn fra miljøet. Den er beholdt som i eksporten.
4. **Afviger kun ved de fjernede linjer og headeren.** Hver fil er sammenlignet linje for linje med sin eksportfil med et engangsscript uden for repoet. Pr. fil er præcis tre linjer fjernet: `USE [...]`, den `GO` der følger efter den, og SSMS' `/****** Object: ... ******/`. Der er ingen andre forskelle. Mellemrum er bevaret, også mellemrum sidst på linjen. Filerne er UTF-8 uden BOM og har LF; i indekset står de som `i/lf`. `SET ANSI_NULLS`, `SET QUOTED_IDENTIFIER` og alle `GO` er beholdt. Headeren har samme form som procedurernes og er på engelsk som dem: navnet, hvad tabellen er, og hvilken procedure der fylder den. Står der ingen, er tabellen markeret som statisk.
5. **Alle tabeller der bruges, har en fil.** Procedurerne i `sql/dw/` og `sql/meta/` bruger 35 tabeller ved navn: 20 dimensioner, 9 fakta, 2 meta- og 4 stg-tabeller. Python-koden skriver til de fire stg-tabeller (`STG_FILES` i `constants.py`). Alle 35 har en fil. Der mangler ingen.
6. **Tabeller i eksporten som intet i repoet bruger:** kun `dw.dim_absence_reason`. Den nævnes ikke ved navn i nogen procedure eller i Python-koden. **Den bruges dog indirekte:** fremmednøglerne `fk_fact_absence_daily_reason` og `fk_fact_absence_lesson_reason` peger på den. Hver `absence_reason_code` som `usp_load_fact_absence_daily`, `usp_fill_absence_gaps` og `usp_load_fact_absence_lesson` skriver (`S`, `L`, `U`, `F` og `IF`), skal derfor stå i den, ellers fejler indsættelsen. Filen er lagt ind som de andre, og headeren siger at den ikke fyldes af nogen procedure.
7. **`CLAUDE.md`.** Under `## Mappestruktur` står nu `sql/tables/`. Afsnittet om at definitionerne mangler, er skrevet om: det siger nu hvor de ligger, at de kun er struktur, at oprettelsesrækkefølgen ikke står nogen steder, og at en ændring rettes i filen og køres i hånden. Listen over dimensioner hvis **indhold** ikke ligger i repoet, er bevaret og har fået `dim_absence_reason` med.

Der er ingen nye kommandoer eller indstillinger. Der er heller intet at skrive i README.

Commits på `task-0001-table-definitions`: `a360b9c` (status), `d17621d` (tabeller og skemaer), `2b94b36` (`CLAUDE.md`) og den med disse noter.

### Hvad er ikke lavet, og hvorfor
- Rækkefølgen tabellerne skal oprettes i, er ikke skrevet ned. Opgaven siger at den hører til emnet om en fuld database fra bunden.
- Der er ikke kørt SQL mod nogen database. Det følger af opgaven.
- Scriptene der lavede og sammenlignede filerne, er ikke lagt i repoet. Opgaven beder ikke om dem, og et script der læser katalogen, er fravalgt i `Beslutninger`.

### Uklart
- **Indeks.** `Færdig når` nævner indeks, men eksporten rummer ingen indeks ud over primærnøglerne og den ene unikke nøgle. Ingen af faktatabellerne har et indeks på fx `student_id` eller `date_id`. Jeg kan ikke afgøre om databasen ikke har flere indeks, eller om eksporten er lavet uden SSMS-indstillingen *Script Indexes*. Filerne gengiver eksporten som den er. Har databasen flere indeks, skal eksporten tages om med den indstilling slået til.
- **Headernes sprog.** Opgaven siger *samme form som procedurernes*, og procedurernes headere er på engelsk. Derfor er tabelheaderne også på engelsk. Den øverste linje i `schemas.sql` er `stg, dw, meta`, fordi filen ikke beskriver ét objekt.

### Fund uden for opgaven
1. **Der er ingen `.gitattributes` i repoet**, selv om `AGENTS.md` (`## Versionering`) kræver `* text=auto eol=lf`. På denne maskine er `core.autocrlf=true`. Git gemmer derfor LF, men skriver CRLF i arbejdskopien næste gang filerne tjekkes ud. Det gælder også de nye filer.
2. **Procedurernes headere nævner skolenavne og kommunens navn**, ud over de koder `CLAUDE.md` allerede nævner under `## Værdier i koden`. Det gælder `usp_load_dim_school.sql` og `usp_load_dim_school_district.sql`. De er ikke rørt og ikke gentaget her.
