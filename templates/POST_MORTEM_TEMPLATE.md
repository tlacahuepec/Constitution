# Incident Post-Mortem: [Incident Short Title]

**Incident Date**: YYYY-MM-DD  
**Authors**: [Author Names]  
**Severity Level**: SEV1 (Critical Outage) | SEV2 (Major Degradation) | SEV3 (Minor Issue)  
**Status**: Draft | In Review | Final  

---

## 1. Executive Summary

Provide a concise 2–3 paragraph summary describing what happened, the user and business impact, the root cause, and how the incident was mitigated and resolved.

- **Impact**: e.g., 15% of checkout requests failed between 14:00 and 14:45 UTC; estimated 1,200 users impacted.
- **Root Cause**: e.g., A database migration added a lock on the `orders` table during peak traffic hours.
- **Resolution**: e.g., Rolled back application deployment and terminated blocking database transaction.

---

## 2. Incident Metrics

| Metric | Timestamp (UTC) / Duration |
|---|---|
| Incident Start | YYYY-MM-DD HH:MM |
| Detection Time | YYYY-MM-DD HH:MM |
| Escalation Time | YYYY-MM-DD HH:MM |
| Mitigation Time | YYYY-MM-DD HH:MM |
| Full Resolution Time | YYYY-MM-DD HH:MM |
| **Time to Detect (TTD)** | XX minutes |
| **Time to Mitigate (TTM)** | XX minutes |
| **Time to Resolve (TTR)** | XX minutes |

---

## 3. Incident Timeline (UTC)

Chronological breakdown of events from inception to resolution:

- **HH:MM** — Pull request #123 merged and deployed to production.
- **HH:MM** — Alert `Http5xxRateSpike` triggered in Prometheus / Datadog.
- **HH:MM** — On-call engineer acknowledged alert and opened incident bridge.
- **HH:MM** — Incident escalated to SEV1; status page updated.
- **HH:MM** — Root cause identified as blocking table lock.
- **HH:MM** — Canary deployment rolled back to previous stable release.
- **HH:MM** — Error rates returned to normal baseline; incident resolved.

---

## 4. Root Cause Analysis (The 5 Whys)

1. **Why did the service return 500 errors?**
   - Because checkout requests timed out waiting for a database connection.
2. **Why were database connections exhausted?**
   - Because queries on the `orders` table were waiting for an exclusive table lock.
3. **Why was an exclusive table lock acquired?**
   - Because migration `0042_add_discount.sql` executed an un-indexed `ALTER TABLE` with a non-nullable column and default value.
4. **Why was this migration executed during peak hours?**
   - Because our CI/CD pipeline immediately applies migrations upon merge to `main`.
5. **Why was the expand-and-contract pattern not followed?**
   - Because the PR review checklist did not include a specific database migration review step.

---

## 5. Lessons Learned

### What Went Well
- Monitoring alerts triggered within 2 minutes of error rate spikes.
- Rollback procedure succeeded quickly without data corruption.

### What Went Wrong
- Destructive migration bypassed staging load testing.
- Health checks did not detect database lock contention immediately.

### Where We Got Lucky
- The issue occurred on a Tuesday afternoon rather than during high-volume weekend traffic.

---

## 6. Preventative Action Items

Every action item must have an assigned owner and a tracked issue reference:

| # | Action Item | Type | Owner | Issue Link |
|---|---|---|---|---|
| 1 | Mandate Expand-and-Contract review for all migration PRs | Process | @owner | #XX |
| 2 | Add automated CI check for locking DDL statements | Prevention | @owner | #XX |
| 3 | Add database lock wait time alert in Prometheus | Detection | @owner | #XX |
| 4 | Conduct database migration load testing in Staging | Mitigation | @owner | #XX |
