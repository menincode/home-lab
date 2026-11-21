# `04-ai`

Pattern: **`04-ai-${AI_FOLDER}-<service>`** (subfolder = `AI_FOLDER`).

| Subfolder | Swarm services |
|-----------|----------------|
| `4.1-pg-redis` | `postgres-vector`, `redis` |

API router (Omniroute): **`01-infra/1.3-ai-router`**.

**Dokploy:** project **`ai`**, compose **`4.1-pg-redis`** (`kpsomOmgbvrh_id5VP8Jx`, stack `ai-41-pg-redis-asn6h0`) — **Stack**, source **GitHub** `menincode/home-lab` @ `main`, path `04-ai/4.1-pg-redis/docker-compose.yml`, `autoDeploy` on push.

(Legacy trên project **labs**: compose `04-ai` — có thể stop/xóa nếu trùng port `25432`/`26379`.)

```bash
cd 04-ai/4.1-pg-redis && cp .env.example .env
# local (manager node): docker stack deploy -c docker-compose.yml 04-ai-4.1-pg-redis
```

Volume host: `…/${AI_FOLDER}-postgres`, `…/${AI_FOLDER}-redis` (mặc định `4.1-pg-redis-*`).