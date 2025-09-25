# Infrastructure Roadmap v0.1

## Zielbild

- Automations-first: CI als Gatekeeper
- Einheitliche Dev-Umgebung (WSL + Node 20)

## Nächste Schritte

- Governance-Guards (Branch/Commit) als Pflicht-Check
- Secrets/Env-Strategie definieren (später)

## Zweck
Dieses Dokument definiert Infrastruktur-Entscheidungen, Reifegrade und Handlungsempfehlungen für das Projekt *sptw-social-proof-starter*.  
Es ist Teil der Artefakt-Struktur und dient als Referenz für Tickets, Governance und Business Case Diskussionen.

---

## Reifegrad 1 – Ad-hoc / Prototyp
**Infrastruktur-Entscheidungen:**  
- Hosting: Vercel / Railway / Render  
- Datenhaltung: JSON-Files oder SQLite  
- API Doku manuell  

**Analyse:**  
- SWOT: Schnell + billig, aber keine Skalierung und keine Governance  
- 2nd/3rd Order: schneller Pivot, aber Tech-Schulden unvermeidlich  
- Blind Spots: DSGVO, Privacy by Design fehlt  
- Finance: <20€/Monat  
- Branding: MVP / Hobby-Charakter  
- Governance: kaum vorhanden  

**Empfehlung:** Nur für MVP-Testphasen geeignet. Schnell Richtung Reifegrad 2 gehen.

---

## Reifegrad 2 – Ticket-Driven (aktueller Stand)
**Infrastruktur-Entscheidungen:**  
- GitHub Repo + CI/CD (Codex, Linter, Smoke)  
- Cloud Functions (z. B. GCP, AWS Lambda)  
- JSON Schema + OpenAPI als Basis  

**Analyse:**  
- SWOT: klare Struktur, aber Artefakte noch manuell gepflegt  
- 2nd/3rd Order: erste Governance sichtbar, Finance ~50€/Monat  
- Blind Spots: Secrets Mgmt, Analytics fehlen  
- Finance: Low  
- Branding: Dev-first, Beta  
- Governance: erste Policies  

**Empfehlung:** Tickets mit stabilen Handover-Blöcken und Secrets Mgmt. Upgrade zu Reifegrad 3 in den nächsten 2 Tickets.

---

## Reifegrad 3 – Codex-Driven
**Infrastruktur-Entscheidungen:**  
- Contracts (OpenAPI, JSON Schema) als Source of Truth  
- Microservices via Functions oder GKE Autopilot  
- API Gateway + Auth Layer  

**Analyse:**  
- SWOT: Konsistenz, aber höhere Komplexität  
- 2nd/3rd Order: Dev-Kosten sinken, Finance 200–500€/Monat  
- Blind Spots: Multi-Region, Incident Response  
- Finance: Mittel  
- Branding: Tech-driven, SMB-ready  
- Governance: Policies nötig (Change Mgmt, Data Access)  

**Empfehlung:** Ziel für AT-003 bis AT-005. Fokus: Contracts als Quelle, Monitoring + Secrets Mgmt.

---

## Reifegrad 4 – Contract-First
**Infrastruktur-Entscheidungen:**  
- Contracts = zentrale Wahrheit  
- Multi-env CI/CD (Staging, Prod, Canary)  
- Audit-Logging, Monitoring (Datadog, Grafana)  
- CDP light (Segment/RudderStack)  

**Analyse:**  
- SWOT: revisionssicher, aber hoher Setup-Aufwand  
- 2nd/3rd Order: Enterprise-Sales möglich, Finance 1–3k€/Monat  
- Blind Spots: Overengineering-Risiko  
- Finance: Hoch  
- Branding: „Enterprise-grade Trust“  
- Governance: Compliance-ready (ISO, SOC2, DSGVO)  

**Empfehlung:** Ab ~5–10 Kunden + SMB-Skalierung. Schrittweise vorbereiten.

---

## Reifegrad 5 – Codex-Autonom (Ziel)
**Infrastruktur-Entscheidungen:**  
- Business-Tickets → Codex generiert + deployed autonom  
- Full Policy-as-Code  
- Self-Healing Infrastructure  
- Automated Compliance Checks  

**Analyse:**  
- SWOT: vollautomatisiert, Thought Leader-Potenzial  
- 2nd/3rd Order: Finance 5–10k€/Monat, ROI über High-Value Accounts  
- Blind Spots: Kundenvertrauen in Autonomie  
- Finance: sehr hoch  
- Branding: „AI-native Trust Infrastructure“  
- Governance: Board-/Investor-ready  

**Empfehlung:** Nur bei stabiler Customer Base und ROI sinnvoll.

---

## Zusammenfassung
- Aktueller Stand: Reifegrad 2 → Ticket-Driven  
- Kurzfristig (AT-003 bis AT-005): Ziel Reifegrad 3  
- Mittelfristig (~6–12 Monate): Vorbereitung auf Reifegrad 4  
- Langfristig: Evaluierung Reifegrad 5 für Enterprise-Szenarien
