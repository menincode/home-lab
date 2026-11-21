# `04-ai`

Pattern: **`04-ai-${AI_FOLDER}-<service>`** (subfolder = `AI_FOLDER`).

| Subfolder | Containers |
|-----------|------------|
| `01-pg-redis` | `04-ai-01-pg-redis-postgres`, `04-ai-01-pg-redis-redis` |

API router (Omniroute): **`01-infra/03-ai-router`**.

```bash
cd 04-ai/01-pg-redis && cp .env.example .env && docker compose up -d
```

**Dokploy (project labs):** compose `04-ai` — file `01-pg-redis/docker-compose.dokploy.yml`.

Volume host (mặc định): `…/01-pg-redis-postgres`, `…/01-pg-redis-redis`. Nếu đang dùng `04-ai-postgres` / `02-ai-router-*`, rename hoặc symlink trên server.