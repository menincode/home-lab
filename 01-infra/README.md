# `01-infra`

Pattern: **`01-infra-${INF_FOLDER}-<service>`**

| Subfolder | Container names |
|-----------|-----------------|
| `01-services` | `01-infra-01-services-postgres`, `01-infra-01-services-minio` |
| `02-tunnel` | `01-infra-02-tunnel-cloudflared` |
| `03-ai-router` | `01-infra-03-ai-router-omniroute` |

`DEPLOY_ENV` vẫn dùng cho **volume**, **network alias** (`postgres-dev`, `minio-dev`, …).

```bash
cd 01-infra/<folder> && cp .env.example .env && docker compose up -d
```