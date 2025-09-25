# sptw-social-proof-starter

**Operating Contract (v0.1)**  
- `main` ist Single Source of Truth. **Keine** Direkt-Commits.  
- Jede Änderung erfolgt **via Atomic Ticket (tickets/AT-xxx.md) + PR**.  
- Tickets enthalten: Ziel, Scope, *How-To*, **Smoke** (```bash ... ```), **DoD**, Workflow.  
- CI führt `lint` und **ticket-smoke** aus. Ein PR ist *grün*, wenn Smoke der betroffenen Tickets grün ist.

Siehe `artefacts/Artefact_Index_v0.1.md`.
