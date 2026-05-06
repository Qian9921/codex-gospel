# Google-Practice Reliability

Use this reference for services, pipelines, data jobs, alerts, dashboards, and operational claims.

## User-Visible Reliability First

Define what users experience before optimizing internals:

- SLI: the measured signal, such as latency, error rate, freshness, durability, or availability.
- SLO: the target value or range for that signal.
- SLA: a user-facing agreement with consequences when applicable.

If there is no user-visible SLI, reliability discussion is usually guesswork.

## Alerting

Prefer symptom-based alerts:

- user requests failing
- latency above the SLO
- stale data beyond tolerance
- dropped or duplicated critical events
- quota exhaustion that will soon affect users

Cause-based alerts can help diagnosis, but they should not be the only signal.

## Error Budget Thinking

- A system that misses its SLO needs reliability work before more risk.
- A system far below its error budget may be too conservative, expensive, or slow to improve.
- Reliability targets should be explicit enough to guide tradeoffs.

## Codex Application

When making or reviewing reliability changes:

1. Identify the user-visible behavior.
2. Identify the SLI and SLO, or say they are missing.
3. Check the measurement path.
4. Verify rollback and failure behavior.
5. Prefer simple operational fixes over broad rewrites.

Sources: Google SRE Book, Service Level Objectives, and public SRE reliability practice.
