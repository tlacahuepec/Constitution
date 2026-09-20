# Security Annex: OWASP Top 10 Engineering Standards

This document establishes mandatory engineering standards to mitigate the **OWASP Top 10 Web Application Security Risks** across all repositories.

All repositories handling network requests, user inputs, authentication, or sensitive data must enforce these mitigations.

---

## A01: Broken Access Control

Access control enforces policy such that users cannot act outside of their intended permissions.

### Mandatory Mitigations

1. **Deny by Default**: Any endpoint, route, or resource not explicitly marked public must require authentication and authorization.
2. **Principle of Least Privilege**: Users, services, and tokens must possess only the minimum permissions necessary to perform their role.
3. **Server-Side Enforcement**: Never rely on client-side checks (UI hiding, disabled buttons) for authorization. Every API endpoint must validate permissions on the server.
4. **IDOR Prevention**: Insecure Direct Object References (e.g., `/api/users/123/profile`) must verify that the authenticated subject owns or has explicit permission to access the requested ID. Use UUIDs or tenant-scoped queries instead of predictable sequential IDs.
5. **CORS Configuration**: Never use `Access-Control-Allow-Origin: *` for authenticated endpoints. Whitelist specific, trusted domains.

---

## A02: Cryptographic Failures

Protection of sensitive data in transit and at rest.

### Mandatory Mitigations

1. **Transport Encryption**: Enforce TLS 1.3 (minimum TLS 1.2) on all network communications. Unencrypted HTTP must automatically redirect to HTTPS with HSTS (`Strict-Transport-Security`).
2. **Password Hashing**: Passwords must be hashed using **Argon2id** (preferred) or **bcrypt** with a minimum work factor of 12. Never use MD5, SHA-1, or unsalted SHA-256 for passwords.
3. **Encryption at Rest**: Sensitive data at rest (tokens, PII, financial data) must use authenticated encryption: **AES-256-GCM** or **ChaCha20-Poly1305**.
4. **Key Management**: Encryption keys must be injected via secure secret managers (e.g., AWS Secrets Manager, Vault, GitHub Secrets), never hardcoded or stored in Git.
5. **Randomness**: Use cryptographically secure pseudorandom number generators (CSPRNG, e.g., `crypto.randomBytes()`, `secrets.token_hex()`, `SecureRandom`).

---

## A03: Injection (SQL, Command, Path Traversal)

Injection flaws occur when untrusted data is sent to an interpreter as part of a command or query.

### Mandatory Mitigations

1. **SQL Injection**:
   - Always use parameterized queries, prepared statements, or reputable ORMs (Room, SQLAlchemy, Hibernate, Prisma).
   - Never concatenate or interpolate user input directly into SQL strings.
2. **Command Injection**:
   - Avoid executing system shell commands. If unavoidable, use safe process APIs that accept argument arrays (e.g., `execFile(['ls', path])`) rather than shell string execution (`exec("ls " + path)`).
3. **Path Traversal**:
   - Never use user-supplied strings directly in filesystem paths.
   - Resolve paths canonicalizing them (e.g., `os.path.realpath`, `Path.normalize()`) and verify that the target starts within the allowed base directory.

---

## A04: Insecure Design

Flaws related to missing or ineffective design and architecture.

### Mandatory Mitigations

1. **Rate Limiting**: Apply rate limiting to all public-facing endpoints, especially authentication, password reset, and resource-heavy operations.
2. **Account Lockout & Backoff**: Enforce progressive delays or lockouts after repeated failed authentication attempts.
3. **Defense in Depth**: Do not rely on a single layer of security. Combine input validation, business logic checks, database constraints, and network boundaries.

---

## A05: Security Misconfiguration

Insecure default configurations, open cloud storage, misconfigured HTTP headers, and overly verbose error messages.

### Mandatory Mitigations

1. **Security Headers**: All web services must set the following HTTP headers:
   - `Content-Security-Policy: default-src 'self'`
   - `X-Content-Type-Options: nosniff`
   - `X-Frame-Options: DENY`
   - `Strict-Transport-Security: max-age=31536000; includeSubDomains`
   - `Referrer-Policy: strict-origin-when-cross-origin`
2. **Disable Debug Features**: Framework debug modes (e.g., Django `DEBUG=True`, Express stack traces) must be disabled in production environments.
3. **Error Leakage**: Never expose stack traces, database schema details, or environment variables in client-facing error responses.

---

## A06: Vulnerable and Outdated Components

Using dependencies with known vulnerabilities.

### Mandatory Mitigations

1. **Automated Scanning**: Dependabot or equivalent dependency scanner must be active.
2. **Dependency Pinning**: All dependencies must be pinned using lockfiles (`uv.lock`, `package-lock.json`, `pnpm-lock.yaml`, `gradle.lockfile`).
3. **Remediation SLA**:
   - **Critical Vulnerabilities**: Remediated and deployed within 48 hours.
   - **High Vulnerabilities**: Remediated within 14 calendar days.

---

## A07: Identification and Authentication Failures

Weaknesses in user identity verification, session management, or authentication mechanisms.

### Mandatory Mitigations

1. **Session Management**: Session tokens must be high-entropy CSPRNG strings.
2. **Cookie Security**: Authentication cookies must carry the `HttpOnly`, `Secure`, and `SameSite=Strict` (or `Lax`) attributes.
3. **Token Expiry**: Stateless tokens (e.g., JWT) must have short lifetimes (≤ 15 minutes for access tokens) and employ secure refresh token rotation.
4. **Invalidation**: User logout must invalidate both server-side session state and refresh tokens.

---

## A08: Software and Data Integrity Failures

Code and infrastructure that does not protect against integrity violations (supply chain attacks, unverified plugins).

### Mandatory Mitigations

1. **CI Pipeline Integrity**: CI workflows must pin external actions to specific commit SHAs or verified major versions.
2. **Package Integrity**: Package managers must verify cryptographic checksums against lockfiles.
3. **Signed Releases**: Official releases and version tags must be cryptographically signed.

---

## A09: Security Logging and Monitoring Failures

Failure to log security-relevant events, enabling attackers to persist undetected.

### Mandatory Mitigations

1. **Audit Logging**: Log all authentication successes and failures, access control failures, password resets, privilege changes, and critical data modifications.
2. **Correlation IDs**: Log entries must include a unique correlation ID per request to trace operations across microservices.
3. **PII and Secret Redaction**: Never log passwords, payment details, session tokens, API keys, or personally identifiable information (PII).
4. **Log Tampering Protection**: Ship logs to centralized, append-only log aggregators.

---

## A10: Server-Side Request Forgery (SSRF)

SSRF flaws occur whenever a web application fetches a remote resource without validating the user-supplied URL.

### Mandatory Mitigations

1. **URL Whitelisting**: Restrict outbound HTTP calls to an explicit whitelist of allowed domains and protocols (`https` only).
2. **Private Network Blocking**: Reject or block requests directed to internal network addresses, including:
   - Loopback: `127.0.0.0/8`, `::1`
   - Private networks: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`
   - Cloud metadata services: `169.254.169.254`
3. **Disable Redirects**: Disable HTTP redirect following on backend HTTP clients that fetch user-supplied URLs.

---

## Data Privacy & PII Handling Standards

Repositories storing or processing user data must enforce strict privacy controls:

### 1. Data Classification Tiers

- **Public**: Non-sensitive data intended for public consumption.
- **Internal**: Internal organizational documentation, non-sensitive telemetry.
- **Confidential**: Business-sensitive metrics, internal architectural documentation.
- **Restricted (PII & Secrets)**: Personally Identifiable Information (names, emails, phone numbers, IP addresses, physical addresses, payment cards, national IDs) and credentials.

### 2. Encryption & Storage Rules

- **Field-Level Encryption**: Sensitive PII fields must be encrypted at rest in the database using **AES-256-GCM** before persistence.
- **Data Masking in Lower Environments**: Development, staging, and local environments must **never** load raw production databases containing user PII. Data must be scrubbed, anonymized, or synthesized using test data generators.

### 3. Data Retention & Deletion (GDPR / CCPA)

- Applications must support automated "Right to be Forgotten" workflows that hard-delete or irreversibly anonymize user records upon verified request.
- Establish automated data retention policies: purge transient logs, temporary uploads, and expired tokens on a scheduled basis (e.g. 30–90 days).

---

## Authentication & Authorization Patterns

### 1. Identity & Authentication Protocols

- Use industry-standard identity protocols: **OAuth 2.0** and **OpenID Connect (OIDC)**. Never implement custom, home-grown authentication handshakes.
- Authentication tokens (JWT) must use cryptographically signed algorithms (`EdDSA`, `ES256`, or `RS256`). Symmetric `HS256` is discouraged across distributed systems.
- Always validate token signatures, expiration (`exp`), issuer (`iss`), and audience (`aud`) on the server.

### 2. Authorization Enforcement

- Implement **Role-Based Access Control (RBAC)** or **Attribute-Based Access Control (ABAC)** at the API gateway and service controller level.
- Enforce the **Principle of Least Privilege**: API clients and service tokens must only have permissions for specific scopes required for their tasks.
- Never rely on client-side state for privilege checks. Re-evaluate permissions on every incoming request.
