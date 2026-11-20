# Beslutningslog

Append-only. Nyeste øverst. Én linje pr. beslutning.

**Ejes af `architect`.** Dens tråd er den eneste samtale i modellen, og loggen er det eneste spor af den der overlever tråden. Hver beslutning truffet i en `architect`-tråd skrives ind, med begrundelse, før tråden lukkes.

Her hører også **afvisninger**: et fund der ikke bliver en opgave, skal have sin begrundelse her. Ellers er det et fund der forsvandt.

`Nr.` er nummeret beslutningen hører til — `task-0042`, `test-0003` — eller `—` hvis den gælder projektet som helhed.

| Dato | Nr. | Beslutning | Begrundelse | Rolle |
|---|---|---|---|---|
| 2026-11-20 | — | Skemaer, tabel- og procedurenavne fra koden må nævnes i `CLAUDE.md` og `docs/` | Navnene står i hver SQL-fil; uden dem kan ETL-laget ikke beskrives. Miljøværdier og skole-/distriktskoder er ikke omfattet. Afvist: kun nøgler | kickoff |
| 2026-11-20 | — | Procedurerne lægges i databasen i hånden, fil for fil | Sådan gøres det i dag; scriptet README nævner, findes ikke. Automatisering står som emne på BOARD | kickoff |
