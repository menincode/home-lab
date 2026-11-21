# `01-infra`

| Subfolder | Stack | Chạy |
|-----------|--------|------|
| `01-postgres-minio` | TimescaleDB + MinIO | `cd 01-postgres-minio && cp .env.example .env && docker compose up -d` |
| `02-tunnel` | Cloudflare tunnel | `cd 02-tunnel && cp .env.example .env` (token) |
| `03-ai-router` | Omniroute | `cd 03-ai-router && cp .env.example .env` |

Biến chung: `INF_FOLDER` = tên thư mục. Compose project: `infra-<folder>`.

**Dokploy:** cập nhật `composePath` trỏ tới `01-infra/<folder>/docker-compose.yml` sau khi push repo.