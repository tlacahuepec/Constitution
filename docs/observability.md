# Observability & Monitoring Standards

This guide establishes mandatory observability, health checking, metrics, and tracing standards for all software services.

---

## 1. Health Check Architecture

Every HTTP service must expose two distinct health check endpoints to enable orchestrators (Kubernetes, Docker, Nomad) and load balancers to manage container lifecycles safely:

### A. Liveness Endpoint: `/healthz`

- **Purpose**: Verifies that the application process is running and its event loop or thread pool is unblocked.
- **Behavior**:
  - Returns `200 OK` with `{ "status": "alive" }`.
  - **Must NOT check external dependencies** (databases, caches, third-party APIs). If a database is down, the service should NOT be killed by the orchestrator.
  - Must respond in < 10 milliseconds.

### B. Readiness Endpoint: `/readyz`

- **Purpose**: Verifies that the application is fully initialized and capable of successfully servicing incoming user traffic.
- **Behavior**:
  - Checks reachability of critical internal dependencies: database connection pool initialized, cache accessible, required configuration loaded.
  - Returns `200 OK` with `{ "status": "ready" }` if all dependencies are healthy.
  - Returns `503 Service Unavailable` with details if any critical dependency is down.
  - Load balancers use this endpoint to route traffic only to ready instances.

---

## 2. The Four Golden Signals

All production services must collect and export metrics covering the **Four Golden Signals** (Google SRE standard):

### 1. Latency

The time it takes to service a request.

- Measure both successful requests and failed requests separately.
- Track percentiles: **p50** (median), **p95**, and **p99** (tail latency). Averages hide critical degradation.

### 2. Traffic

A measure of how much demand is being placed on your system.

- HTTP services: Requests per second (RPS) broken down by route and HTTP method.
- Event-driven / Queue services: Messages processed per second, queue depth / consumer lag.

### 3. Errors

The rate of requests that fail.

- Differentiate between **Client Errors (4xx)** (validation failures, auth issues) and **Server Errors (5xx)** (unhandled exceptions, database timeouts).
- Track error ratio: `(5xx requests) / (total requests)`. An error ratio > 1% should trigger engineering alerts.

### 4. Saturation

A measure of system capacity utilization.

- CPU and Memory utilization percentages.
- Database connection pool utilization (active vs idle connections).
- Thread pool queue depth and garbage collection pause times.

---

## 3. Metrics Format & Collection

- **Format**: All metrics must be exported in the standard **Prometheus / OpenMetrics text format** at the `/metrics` endpoint (protected or internal network only).
- **Metric Types**:
  - `Counter`: Monotonically increasing values (e.g. `http_requests_total`).
  - `Gauge`: Values that fluctuate up and down (e.g. `active_db_connections`).
  - `Histogram`: Distribution of values into buckets (e.g. `http_request_duration_seconds`).
- **Cardinality Rules**: Never use high-cardinality values (user IDs, emails, full URLs with query parameters, timestamps) as metric labels. Use bounded labels (`method="GET"`, `status="200"`, `route="/api/v1/orders"`).

---

## 4. Distributed Tracing (OpenTelemetry)

In distributed architectures, requests span multiple services. To trace request flow:

1. **W3C Trace Context**: Services must parse and propagate the standard W3C `traceparent` and `tracestate` HTTP headers.
2. **Correlation IDs**: If OpenTelemetry is not yet fully adopted, every service must extract or generate an `X-Correlation-ID` header and attach it to:
   - Inbound HTTP request context
   - Outbound HTTP / gRPC client calls
   - Every structured JSON log entry
   - Client-facing error responses (RFC 7807)
3. **Span Boundaries**: Create spans for significant boundaries:
   - Inbound HTTP request handler
   - Database queries
   - External HTTP client calls
   - Cache reads and writes
