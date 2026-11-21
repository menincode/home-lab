# Decap CMS (`02-lab/03-decap-cms`)

| Service | Image |
|---------|--------|
| `cms` | `itsmejoeeey/docker-decap-cms-standalone:latest` |
| `decap-server` | `node:22-alpine` + `decap-server@3.11.6` |

Config: `repo/admin/config.yml` (local backend). URLs được patch theo `DECAP_PUBLIC_HOST` khi start proxy.

```bash
cp .env.example .env && docker compose up -d
# CMS http://127.0.0.1:8790/  — API port 8791
```

Dokploy: `docker-compose.dokploy.yml` + `.env.dokploy.generated`.