# `01-infra`

Pattern: **`01-infra-${INF_FOLDER}-<service>`**

| Subfolder | Container names |
|-----------|-----------------|
| `1.1-services` | `01-infra-01-services-postgres`, `01-infra-01-services-minio` |
| `1.2-tunnel` | `infra-01infratunnel-msnhnn_cloudflared` — ingress trên tunnel **home-lab** (`435b0ec2-…`) |
| `1.3-ai-router` | `infra-13-ai-router-yviz4s_ai-router` (Swarm; host `22128`, tunnel **https://router.wmamedia.qzz.io** → `…_ai-router:20128`) |
| `1.4-9router` | Swarm **`nine-router`**; host **20128**; tunnel **https://router2.wmamedia.qzz.io** → `infra-14-9router-noskxg_nine-router:20128`; data `${DATA_DIR}/9router-data` |

`DEPLOY_ENV` vẫn dùng cho **volume**, **network alias** (`postgres-dev`, `minio-dev`, …).

```bash
cd 01-infra/<folder> && cp .env.example .env && docker compose up -d
```

**Dokploy:** project **infra**, compose type **stack**, GitHub `./01-infra/1.4-9router/docker-compose.yml`, `createEnvFile: false`, env từ `.env.dokploy.generated` (điền `NINER_ADMIN_PASSWORD`, `NINER_JWT_SECRET` — có thể tái dùng file trong volume `9router-data` cũ).