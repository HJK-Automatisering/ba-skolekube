---
nummer: task-0002
titel: Procedurerne lægges i databasen ved opstart
status: i-gang
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
### Hvad er ikke lavet, og hvorfor
### Uklart
