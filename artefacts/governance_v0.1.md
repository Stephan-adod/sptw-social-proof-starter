# Governance v0.1 – SPTW Social Proof Starter

## Prinzipien

- `main` ist Single Source of Truth (SSoT).
- Änderungen ausschließlich via Pull Request (Atomic Ticket + CI grün).
- Kein Direct-Push auf `main`.

## Arbeitsweise

1. Branch vom Ticket: `feature/AT-000X-kurzer-slug`
2. Code/Docs ändern, **Smoke** aus Ticket lokal grün
3. PR gegen `main`, CI grün, mergen (Squash)

## Artefakte & Tickets

- Alle Projektartefakte liegen unter `artefacts/`.
- Alle Tickets liegen unter `tickets/` (inkl. **Smoke** und **DoD**).
