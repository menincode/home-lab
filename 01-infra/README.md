# `01-infra`

Pattern: **`01-infra-${INF_FOLDER}-<service>`**

| Subfolder | Container names |
|-----------|-----------------|
| `01-services` | `01-infra-01-services-postgres`, `01-infra-01-services-minio` |
| `02-tunnel` | `01-infra-02-tunnel-cloudflared` |
| `1.3-ai-router` | `infra-13-ai-router-yviz4s_ai-router` (Swarm; host `22128`, tunnel **https://router.wmamedia.qzz.io** → `…_ai-router:20128`) |
| `1.2-tunnel` | `infra-01infratunnel-msnhnn_cloudflared` — ingress trên tunnel **home-lab** (`435b0ec2-…`) |

`DEPLOY_ENV` vẫn dùng cho **volume**, **network alias** (`postgres-dev`, `minio-dev`, …).

```bash
cd 01-infra/<folder> && cp .env.example .env && docker compose up -d
```