# `2.1-decap-cms`

Decap CMS với **local git backend** (`decap-server`), content trong `./repo`.

| Service | Port (default) | Role |
|---------|----------------|------|
| `cms` | `8790` | UI `/admin/` |
| `decap-server` | `8791` | Git proxy `/api/v1` |

```bash
cp .env.example .env
docker compose up -d
open "http://127.0.0.1:8790/admin/"
```

Trên server: `DECAP_PUBLIC_HOST=travis-server`, `DECAP_BIND=0.0.0.0` (xem `.env.dokploy.generated`).

**Dokploy:** project **labs**, compose `2.1-decap-cms` — sau này GitHub path `./02-lab/2.1-decap-cms/docker-compose.yml`, `createEnvFile: false`, env từ tab Environment.