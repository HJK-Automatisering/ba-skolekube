---
nummer: task-0003
titel: Stakken har en kontaktperson
status: afsluttet
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
- `docker-compose.yaml`: tjenesten `ba-skolekube` har fået `labels:` med `hjk.kontakt: ${CONTACT_EMAIL}`, lagt sidst i tjenesten efter `environment:`, med samme indrykning. Ingen standardværdi. Kommentarerne om Portainer og resten af filen er uændret. CRLF bevaret. Holder *labelen med variablen, ikke en adresse*.
- `.env.example`: ny sektion `# Drift` nederst med `CONTACT_EMAIL=''`, adskilt af en tom linje som `# System`. CRLF bevaret, og filen slutter som før uden afsluttende linjeskift. Holder *nøglen uden værdi*.
- Ingen adresse: søgning efter `@` i de to filer giver intet. Holder *ingen mailadresse i repoet*.
- `docker compose config` (Compose v5.1.3) kørt på en kopi af compose-filen i en midlertidig mappe med en tom `.env` og `--env-file` til den samme tomme fil, så projektets `.env` hverken blev læst eller udskrevet, og med `CONTACT_EMAIL` usat i skallen. Resultat: exit 0, labelen bliver `hjk.kontakt: ""`, og Compose giver kun advarslen *The "CONTACT_EMAIL" variable is not set. Defaulting to a blank string.* Med variablen sat til en pladsholder (ikke en adresse) blev den sat ind i labelen. Den midlertidige mappe er slettet bagefter. Ingen containere startet. Holder *kan læses også uden at `CONTACT_EMAIL` er sat*.
- Commit `85204bc` på `task-0003-contact-label`. Ikke pushet.
- Ny indstilling til README: `CONTACT_EMAIL` — adressen på stakkens kontaktperson, som overvågningen af Docker-værten sender morgenmail og ugentlig sårbarhedsrapport til. Sættes på stakken i Portainer, ikke i repoet.

### Hvad er ikke lavet, og hvorfor
- **Menneskets trin, ikke noget der mangler:**
  1. Sæt `CONTACT_EMAIL` på stakken i Portainer, som stakkens miljøvariabel, til en adresse der ligner en mailadresse. Uden den bliver labelen tom, og overvågningen tæller den som manglende — Compose stopper ikke, den advarer kun.
  2. Hentes stakkens compose-definition i Portainer ikke fra repoet, så læg de to linjer ind under tjenesten `ba-skolekube` dér:
     ```yaml
         labels:
           hjk.kontakt: ${CONTACT_EMAIL}
     ```
  3. Genudrul stakken, så containeren får labelen. En label på en kørende container ændres ikke uden at containeren oprettes igen.
- Ingen tests skrevet eller kørt ud over `docker compose config`: opgaven ændrer ingen kode, og `Færdig når` beder ikke om mere.
- Uden for opgaven, fundet undervejs: repoet har ingen `.gitattributes`. Kontrakten (`## Versionering`) kræver `* text=auto eol=lf`. I dag styres linjeskift af den lokale `core.autocrlf=true`: filerne ligger med LF i git og CRLF i arbejdstræet. Ikke rørt.

### Uklart
intet
