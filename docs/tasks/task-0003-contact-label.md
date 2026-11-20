---
nummer: task-0003
titel: Stakken har en kontaktperson
status: planlagt
kilde: interview
oprettet: 2026-11-20
---

# task-0003 — Stakken har en kontaktperson

## Hvad og hvorfor
Overvågningen af Docker-værten sender en morgenmail om containere der er gået ned, og en ugentlig rapport om sårbarheder — men kun til stakke der har en kontaktperson. Denne stak har ingen. Siden version 1.1.0 stopper containeren med vilje, hvis procedurerne ikke kan lægges i databasen, og så skal nogen høre om det.

## Færdig når
- [ ] Compose-filen giver containeren labelen `hjk.kontakt` med værdien `${CONTACT_EMAIL}` — variablen, ikke en adresse.
- [ ] `.env.example` har nøglen `CONTACT_EMAIL` uden værdi.
- [ ] Ingen mailadresse står nogen steder i repoet som følge af opgaven.
- [ ] Compose-filen kan stadig læses af Docker Compose lokalt (`docker compose config`), også uden at `CONTACT_EMAIL` er sat.
- [ ] Menneskets trin står i noterne: sæt `CONTACT_EMAIL` på stakken i Portainer, og læg labelen ind i stakkens compose-definition dér, hvis den ikke hentes fra repoet.

## Sådan bygger vi det
- I `docker-compose.yaml`, under tjenesten `ba-skolekube`: tilføj `labels:` med `hjk.kontakt: ${CONTACT_EMAIL}`. Samme indrykning og stil som resten af filen. Kommentarerne om Portainer står uændret.
- I `.env.example`: en ny sektion `# Drift` nederst med `CONTACT_EMAIL=''`, i samme stil som de øvrige nøgler (CRLF som resten af filen).
- Reglerne står i `AGENTS.md`, `## En stak og dens kontaktperson`.

## Hvad vi ikke rører
- Programmets kode, SQL-filerne, `Dockerfile` og workflowet.
- Resten af compose-filen: volume, `env_file`, `restart`, `TZ`.
- `README.md` — den retter architect.

## Afhænger af
intet

## Beslutninger
- BESLUTTET: Labelen sættes på den ene tjeneste i den compose-fil der findes — der er ingen separat compose-fil til udrulning, og én tjeneste er nok. Afvist: en ny `deploy/docker-compose.yml`; den hører til emnet om det fælles Docker-workflow.
- BESLUTTET: Værdien er `${CONTACT_EMAIL}` uden standardværdi — kontrakten kræver netop den, og en standardværdi ville være en adresse skrevet ned.
- BESLUTTET: Adressen vælges og sættes af mennesket på stakken — den er en persons data og hører ikke i repoet.

## Åbne punkter

## Indvendinger

---

## Developers noter

### Hvad er lavet
### Hvad er ikke lavet, og hvorfor
### Uklart
