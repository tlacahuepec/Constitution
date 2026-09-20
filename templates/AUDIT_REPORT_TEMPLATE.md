# Audit Report: [Repository Name]

**Auditor**: [Agent name or human reviewer]  
**Date**: YYYY-MM-DD  
**Constitution Version**: 1.3  
**Repository**: [github.com/org/repo-name]  
**Repository Type**: Executable Software | Artifact / Workflow / Documentation  

---

## 1. Executive Summary

Provide a concise 2–3 paragraph summary of the repository's health, constitutional alignment, key strengths, and highest-risk gaps.

---

## 2. Compliance Scorecard

| # | Audit Category | Pass | Partial | Fail | N/A | Score |
|---|---|:---:|:---:|:---:|:---:|:---:|
| 1 | Repository Structure & Config | [ ] | [ ] | [ ] | [ ] | /10 |
| 2 | Branch Protection & Gitflow | [ ] | [ ] | [ ] | [ ] | /10 |
| 3 | CI/CD Pipeline & Checks | [ ] | [ ] | [ ] | [ ] | /10 |
| 4 | Verification-First (TDD / VDD) | [ ] | [ ] | [ ] | [ ] | /10 |
| 5 | Code Quality & SOLID | [ ] | [ ] | [ ] | [ ] | /10 |
| 6 | Security & Secret Protection | [ ] | [ ] | [ ] | [ ] | /10 |
| 7 | Error Handling & Logging | [ ] | [ ] | [ ] | [ ] | /10 |
| 8 | Documentation & ADRs | [ ] | [ ] | [ ] | [ ] | /10 |
| 9 | Technology Extensions | [ ] | [ ] | [ ] | [ ] | /10 |
| 10 | Agent Instructions Quality | [ ] | [ ] | [ ] | [ ] | /10 |
| **TOTAL** | | | | | | **/100** |

---

## 3. Critical Findings (🔴 CRITICAL)
*Must be resolved before next merge. Violations of Immutable Rules or direct security vulnerabilities.*

1. **[Finding Title]**
   - **File / Location**: `path/to/file:L10-L25`
   - **Violation**: Description of the rule violated
   - **Remediation**: Exact steps to fix the issue

---

## 4. High Priority Findings (🟠 HIGH)
*Key architectural or quality standards missing.*

1. **[Finding Title]**
   - **File / Location**: `path/to/file`
   - **Violation**: Description
   - **Remediation**: Recommended fix

---

## 5. Medium Priority Findings (🟡 MEDIUM)
*Best practice gaps that weaken quality, testing, or maintainability.*

1. **[Finding Title]**
   - **File / Location**: `path/to/file`
   - **Violation**: Description
   - **Remediation**: Recommended fix

---

## 6. Low Priority Findings (🔵 LOW)
*Minor inconsistencies, formatting, or optional improvements.*

1. **[Finding Title]**
   - **File / Location**: `path/to/file`
   - **Violation**: Description
   - **Remediation**: Recommended fix

---

## 7. Recommended Action Plan

Prioritized backlog of tasks to bring the repository into full compliance:

- [ ] Task 1 (Critical)
- [ ] Task 2 (High)
- [ ] Task 3 (Medium)
- [ ] Task 4 (Low)
