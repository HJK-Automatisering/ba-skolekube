# Beslutningslog

Append-only. Nyeste øverst. Én linje pr. beslutning.

**Ejes af `architect`.** Dens tråd er den eneste samtale i modellen, og loggen er det eneste spor af den der overlever tråden. Hver beslutning truffet i en `architect`-tråd skrives ind, med begrundelse, før tråden lukkes.

Her hører også **afvisninger**: et fund der ikke bliver en opgave, skal have sin begrundelse her. Ellers er det et fund der forsvandt.

`Nr.` er nummeret beslutningen hører til — `task-0042`, `test-0003` — eller `—` hvis den gælder projektet som helhed.

| Dato | Nr. | Beslutning | Begrundelse | Rolle |
|---|---|---|---|---|
| 2026-11-20 | task-0003 | Kontaktlabelen sættes i den eksisterende compose-fil med `${CONTACT_EMAIL}`; adressen sættes af mennesket på stakken | Kontrakten fastlægger formen; intet at interviewe om. Afvist: ny compose-fil til udrulning — hører til emnet om fælles Docker-workflow | architect |
| 2026-11-20 | task-0002 | Udgivet som 1.1.0 (tag `v1.1.0`) | Ny funktion i produktionskoden: procedurerne lægges i databasen ved opstart; den daglige kørsel virker uændret. Første tag i repoet | architect |
| 2026-11-20 | task-0002 | Afsluttet som bygget; README rettet: procedurerne lægges ved opstart, og databasebrugeren skal have rettigheden | Alle punkter i Færdig når holder i prøven uden database; første rigtige prøve er næste opstart | architect |
| 2026-11-20 | task-0002 | Afvist: at stoppe når der ikke findes procedurefiler | Imaget kopierer hele projektet, så mappen kan ikke mangle uden en ændring i Dockerfile eller .dockerignore; loggen viser antallet | architect |
| 2026-11-20 | task-0002 | Developers fund om CRLF lokalt og LF i git hører under emnet om .gitattributes | Opdelingen klarer begge; intet at gøre i denne opgave | architect |
| 2026-11-20 | task-0002 | Fejl ved opstart stopper programmet med fejlkode | Ny kode må ikke køre mod gamle procedurer. Afvist: log og fortsæt | architect |
| 2026-11-20 | task-0002 | Samme databasebruger som ETL'en; rettigheder gives af mennesket før udrulning | Ingen nye hemmeligheder på stakken. Afvist: separat bruger. Mennesket vidste ikke om rettigheden findes | architect |
| 2026-11-20 | task-0002 | Procedurerne lægges i databasen ved opstart af containeren | Passer altid til imaget der kører. Afvist: script der køres i hånden. Erstatter beslutningen om manuel udrulning fra samme dag | architect |
| 2026-11-20 | task-0001 | Afsluttet som bygget; eksporten er komplet uden ekstra indeks | Forespørgsel mod databasen viste ingen indeks ud over primærnøgler og unikke nøgler | architect |
| 2026-11-20 | task-0001 | Developers fund 2 (skolenavne og kommunens navn i procedureheadere) hører under emnet om hardcodede skole- og distriktskoder | Samme slags værdi i samme filer; tages i ét greb | architect |
| 2026-11-20 | task-0001 | Developers fund 1 (manglende `.gitattributes`) hører under emnet om `.gitignore` og `.gitattributes` | Står allerede på BOARD | architect |
| 2026-11-20 | — | Det fælles Docker-workflow sættes på som emne, tages efter task-0001 | Nuværende workflow er GitHubs standardskabelon og virker; ændring af CI i drift skal ikke presses ind før tabeldefinitionerne | architect |
| 2026-11-20 | task-0001 | Tabeldefinitionerne placeres under `sql/tables/<skema>/` og verificeres mod eksporten, ikke ved kørsel | Adskilt fra procedurerne med samme navngivning; der findes ingen tom database, og produktion røres ikke | architect |
| 2026-11-20 | task-0001 | Kilden er en eksport fra SSMS, lavet af mennesket | Præcis på nøgler og indeks, ingen ny kode at vedligeholde. Afvist: script der læser databasens katalog | architect |
| 2026-11-20 | task-0001 | Kun struktur i repoet, uden indhold | En fuld database kræver faste opslagsdata med forretningsspecifikke koder; står som eget emne. Afvist: fuld genskabelig database nu | architect |
| 2026-11-20 | — | Skemaer, tabel- og procedurenavne fra koden må nævnes i `CLAUDE.md` og `docs/` | Navnene står i hver SQL-fil; uden dem kan ETL-laget ikke beskrives. Miljøværdier og skole-/distriktskoder er ikke omfattet. Afvist: kun nøgler | kickoff |
| 2026-11-20 | — | Procedurerne lægges i databasen i hånden, fil for fil | Sådan gøres det i dag; scriptet README nævner, findes ikke. Automatisering står som emne på BOARD | kickoff |
