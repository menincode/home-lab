# `01-infra`

Pattern: **`01-infra-${INF_FOLDER}-<service>`**

| Subfolder | Container names |
|-----------|-----------------|
| `01-services` | `01-infra-01-services-postgres`, `01-infra-01-services-minio` |
| `02-tunnel` | `01-infra-02-tunnel-cloudflared` |
| `1.3-ai-router` | `infra-13-ai-router-yviz4s_ai-router` (Swarm, port `22128`) |

**Dokploy:** project **infra**, compose **`1.3-ai-router`** (`1rtjbd_ayvNrejmw1qH17`, stack `infra-13-ai-router-yviz4s`) — **Stack**, source **GitHub** `menincode/home-lab` @ `main`, path `./01-infra/1.3-ai-router/docker-compose.yml`, `autoDeploy` on push. Swarm compose **không** dùng `env_file` (Dokploy env UI).

`DEPLOY_ENV` vẫn dùng cho **volume**, **network alias** (`postgres-dev`, `minio-dev`, …).

```bash
cd 01-infra/<folder> && cp .env.example .env && docker compose up -d
```