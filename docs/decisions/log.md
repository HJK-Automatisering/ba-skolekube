# Beslutningslog

Append-only. Nyeste øverst. Én linje pr. beslutning.

**Ejes af `architect`.** Dens tråd er den eneste samtale i modellen, og loggen er det eneste spor af den der overlever tråden. Hver beslutning truffet i en `architect`-tråd skrives ind, med begrundelse, før tråden lukkes.

Her hører også **afvisninger**: et fund der ikke bliver en opgave, skal have sin begrundelse her. Ellers er det et fund der forsvandt.

`Nr.` er nummeret beslutningen hører til — `task-0042`, `test-0003` — eller `—` hvis den gælder projektet som helhed.

| Dato | Nr. | Beslutning | Begrundelse | Rolle |
|---|---|---|---|---|
| 2026-11-20 | task-0001 | Afsluttet som bygget; eksporten er komplet uden ekstra indeks | Forespørgsel mod databasen viste ingen indeks ud over primærnøgler og unikke nøgler | architect |
| 2026-11-20 | task-0001 | Developers fund 2 (skolenavne og kommunens navn i procedureheadere) hører under emnet om hardcodede skole- og distriktskoder | Samme slags værdi i samme filer; tages i ét greb | architect |
| 2026-11-20 | task-0001 | Developers fund 1 (manglende `.gitattributes`) hører under emnet om `.gitignore` og `.gitattributes` | Står allerede på BOARD | architect |
| 2026-11-20 | — | Det fælles Docker-workflow sættes på som emne, tages efter task-0001 | Nuværende workflow er GitHubs standardskabelon og virker; ændring af CI i drift skal ikke presses ind før tabeldefinitionerne | architect |
| 2026-11-20 | task-0001 | Tabeldefinitionerne placeres under `sql/tables/<skema>/` og verificeres mod eksporten, ikke ved kørsel | Adskilt fra procedurerne med samme navngivning; der findes ingen tom database, og produktion røres ikke | architect |
| 2026-11-20 | task-0001 | Kilden er en eksport fra SSMS, lavet af mennesket | Præcis på nøgler og indeks, ingen ny kode at vedligeholde. Afvist: script der læser databasens katalog | architect |
| 2026-11-20 | task-0001 | Kun struktur i repoet, uden indhold | En fuld database kræver faste opslagsdata med forretningsspecifikke koder; står som eget emne. Afvist: fuld genskabelig database nu | architect |
| 2026-11-20 | — | Skemaer, tabel- og procedurenavne fra koden må nævnes i `CLAUDE.md` og `docs/` | Navnene står i hver SQL-fil; uden dem kan ETL-laget ikke beskrives. Miljøværdier og skole-/distriktskoder er ikke omfattet. Afvist: kun nøgler | kickoff |
| 2026-11-20 | — | Procedurerne lægges i databasen i hånden, fil for fil | Sådan gøres det i dag; scriptet README nævner, findes ikke. Automatisering står som emne på BOARD | kickoff |
