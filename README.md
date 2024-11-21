🌍 Couch Explorers: Serverless Arkitektur og Bildegenerering

Velkommen til prosjektet for Couch Explorers! Dette prosjektet demonstrerer hvordan serverless arkitektur kan benyttes til å implementere en løsning for generering av AI-baserte bilder, med fokus på skalerbarhet, automatisering og kostnadseffektivitet.

Denne README inneholder en kortversjon av drøftelsen om serverless arkitektur versus mikrotjenestearkitektur. Hvis du ønsker å lese hele drøftelsen, finner du den i en separat fil som er linket her: 👉 Full drøftelse av Oppgave 5 (lenken må legges inn her).

🚀 Leveranser

Oppgave 1A: SAM Lambda

Endepunkt:https://0kafqwa92m.execute-api.eu-west-1.amazonaws.com/Prod/generate-image

Eksempel CURL-kommando:

curl --request POST \
--url https://0kafqwa92m.execute-api.eu-west-1.amazonaws.com/Prod/generate-image \
--header "Content-Type: application/json" \
--data '{"prompt": "Skriv in prompt her😊"}'

Postman:Metode: POSTHeaders: Content-Type: application/jsonBody:

{ "prompt": "Skriv in prompt her😊" }

Oppgave 1B: SAM Lambda Workflow

Lenke til kjørt workflow: https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11822404640/job/32939376160

Oppgave 2A: Infrastruktur med SQS

Nyeste funksjon: image-generator-sqs-kn3-v2SQS URL: https://sqs.eu-west-1.amazonaws.com/244530008913/image-requests-queue

Oppgave 2B: GitHub Actions for Terraform

Push til main: https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11858442160/job/33049069715Push til andre branches: https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11858396224/job/33048919496

Oppgave 3A og 3B: Docker Image og SQS-klient

Taggestrategi:Jeg har valgt Semantisk versjonering (SemVer): vMAJOR.MINOR.PATCH. Denne strategien sikrer forutsigbarhet og gjør det enkelt for teamet å forstå hvilke oppdateringer som er gjort. Nyeste image er alltid tagget som latest.

Container Image: noha019/sqs-client-kn3SQS URL: https://sqs.eu-west-1.amazonaws.com/244530008913/image-requests-queueDocker Hub: https://hub.docker.com/r/noha019/sqs-client-kn3

Eksempel på kommando for å kjøre imaget:

docker run -e AWS_ACCESS_KEY_ID=xxx -e AWS_SECRET_ACCESS_KEY=yyy \
-e SQS_QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/244530008913/image-requests-queue \
noha019/sqs-client-kn3 "Me getting an A in this course"

Oppgave 5: Drøftelse – Serverless vs. Container-teknologi

Serverless og container-teknologi representerer to distinkte tilnærminger til moderne applikasjonsutvikling, hver med sine egne fordeler og utfordringer. Nedenfor følger en drøftelse av deres implikasjoner basert på sentrale DevOps-prinsipper:

⚡ Automatisering og Kontinuerlig Levering (CI/CD)

Serverless:

En serverless arkitektur krever ofte mer dynamiske CI/CD-pipelines som distribuerer mange små, selvstendige funksjoner. Dette kan komplisere automatiseringen, men også gjøre prosessen mer granulær.

Eksempler som AWS SAM og Serverless Framework forenkler oppgaven, men hvert funksjonelt endepunkt krever nøye versjonskontroll og testing.

Container-teknologi:

Containerbaserte applikasjoner gir bedre kontroll over miljøer og avhengigheter. Pipelines kan være mer rett frem, men krever ofte større initialt arbeid for oppsett av infrastrukturen.

Verktøy som Kubernetes og Docker Compose bidrar til enklere administrasjon og deploy av mikrotjenester.

🔍 Observability (Overvåkning)

Serverless:

Overvåkning av serverless applikasjoner er utfordrende på grunn av deres kortvarige natur (stateless) og potensielt høye antall komponenter.

Verktøy som AWS X-Ray og CloudWatch gir innsikt, men komplekse transaksjoner kan kreve avanserte metoder som distributed tracing med OpenTelemetry.

Container-teknologi:

Mikrotjenester tilbyr mer direkte tilgang til logger og metrikker, noe som forenkler feilsøking.

Prometheus og Grafana er vanlige valg for observability i container-miljøer.

📈 Skalerbarhet og Kostnadskontroll

Serverless:

Skalerer automatisk basert på etterspørsel, noe som gjør det ideelt for applikasjoner med varierende trafikk. Kostnadene er basert på faktisk bruk, noe som kan redusere TCO (Total Cost of Ownership) ved lav trafikk.

Kan bli dyrt ved hyppig eller konstant bruk, og utfordringer som "cold starts" kan påvirke ytelsen.

Container-teknologi:

Containerbaserte løsninger gir utviklerne mer kontroll over skaleringsstrategier, noe som kan gi bedre ytelse ved høy og konstant belastning.

Kostnadene er mer forutsigbare, men infrastrukturen krever mer manuell administrasjon.

🛠️ Eierskap og Ansvar

Serverless:

CSP (Cloud Service Provider) tar ansvar for infrastrukturen, noe som frigjør utviklerne til å fokusere på forretningslogikken. Dette kan føre til mindre kontroll, men raskere iterasjoner.

Krever imidlertid dyp forståelse av skyens verktøy for kostnadsstyring og optimalisering.

Container-teknologi:

Gir teamet full kontroll over infrastrukturen, men også større ansvar for vedlikehold og pålitelighet.

Egnet for organisasjoner med erfaring og ressurser til å administrere container-miljøer effektivt.

📊 Sammenligningstabell

Prinsipp

Serverless

Container-teknologi

CI/CD

Dynamiske pipelines for mange funksjoner

Enklere pipelines for hele tjenester

Observability

Distribuert tracing, utfordrende logging

Direkte tilgang, enklere feilsøking

Skalerbarhet

Automatisk, kostnadseffektivt ved lav bruk

Mer kontroll, egnet for konstant last

Eierskap

Lavere ansvar, mer avhengig av CSP

Full kontroll, men større ansvar

💡 Konklusjon:

Valget mellom serverless og container-teknologi avhenger av prosjektets behov og organisasjonens ressurser. Serverless gir fleksibilitet og lav inngangsterskel, mens container-teknologi gir mer kontroll og egner seg for komplekse, kontinuerlige tjenester.

👉 For mer detaljer, les den fullstendige drøftelsen her: Full drøftelse av Oppgave 5 (lenken må legges inn her).

📈 Oppsummeringstabell for Leveranser

Oppgave

Leveranse

1A

Endepunkt: https://0kafqwa92m.execute-api.eu-west-1.amazonaws.com/Prod/generate-image

1B

Workflow: https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11822404640/job/32939376160

2A

SQS URL: https://sqs.eu-west-1.amazonaws.com/244530008913/image-requests-queue

2B

Workflows: https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11858442160/job/33049069715 / https://github.com/noah-isayas/Dev-CouchExplorer-Ops/actions/runs/11858396224/job/33048919496

3

Docker Image: https://hub.docker.com/r/noha019/sqs-client-kn3

5

Kort drøftelse i README / Full drøftelse av Oppgave 5 (lenken må legges inn her)

💡 Tips for sensor: Denne README-en gir en rask oversikt over prosjektet. For dybdeanalyser, detaljerte drøftelser og implementasjonsvurderinger, se den fullstendige drøftelsen i lenken ovenfor.