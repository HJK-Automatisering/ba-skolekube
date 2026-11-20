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
### Hvad er ikke lavet, og hvorfor
### Uklart
