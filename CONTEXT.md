# home-lab — agent context

Repo: **menincode/home-lab** (`main`). Deploy target: **Dokploy** on **travis-server** (`https://dokploy.wmamedia.qzz.io/`). MCP: `project-0-01-home-lab-dokploy`, `project-0-01-home-lab-lab-ssh`.

Cập nhật bảng dưới sau mỗi lần tạo/xóa Compose trên Dokploy (hoặc chạy `project-all` + `compose-search` qua MCP).

## GitHub → Dokploy (home-lab stacks)

| Repo path | Dokploy project | Compose name | composeId | appName (stack) | Type | createEnvFile |
|-----------|-----------------|--------------|-----------|-----------------|------|---------------|
| `./04-ai/4.1-pg-redis/docker-compose.yml` | **ai** | `4.1-pg-redis` | `kpsomOmgbvrh_id5VP8Jx` | `ai-41-pg-redis-asn6h0` | stack | false |
| `./01-infra/1.3-ai-router/docker-compose.yml` | **infra** | `1.3-ai-router` | `1rtjbd_ayvNrejmw1qH17` | `infra-13-ai-router-yviz4s` | stack | false |
| `./01-infra/1.4-9router/docker-compose.yml` | **infra** | `1.4-9router` | `h-iUnscnpZapoHdzMfo3l` | `infra-14-9router-noskxg` | stack | false |
| `./01-infra/1.2-tunnel/docker-compose.yml` | **infra** | `01-infra-tunnel` | `IV-EeQBK4GnXEsvQyNHRS` | `infra-01infratunnel-msnhnn` | stack | true |
| `./01-infra/1.1-services/docker-compose.yml` | **infra** | `01-infras-service` | `7ULeUmOtYiAP74VujfjS9` | `infra-service-9ktrcn` | docker-compose | true |
| `./02-lab/2.1-decap-cms/docker-compose.yml` | **labs** | `2.1-decap-cms` | `FHc79zEoeVYfPW4DaYfyC` | `labs-21-decap-cms-vms5mr` | docker-compose | true |
| `./03-gh-runner/docker-compose.yml` | **runner** | `03-gh-runner` | `FzxrlAyMrZZauIPBDAv-6` | `runner-03-gh-runner-kyiqya` | docker-compose | true |
| `./05-security/5.1-artex-llm/docker-compose.yml` | **security** | `5.1-artex-llm` | `7xzg9drtTMhxnVGkh7eQ_` | `security-51-artex-llm-kmt5km` | stack | false |

Env repo: stack thường dùng `.env.dokploy.generated` + `compose-saveEnvironment` (`createEnvFile: false` cho Swarm).

**githubId** (provider): `2VTvQwkrMtr6SDllSLGal` — `menincode/home-lab` @ `main`, `composePath` prefix `./`.

> **Lệch path Dokploy UI:** compose `01-infra-tunnel` / `01-infras-service` có thể vẫn trỏ `./01-infra/docker-compose.tunnel.yml` hoặc `./01-infra/docker-compose.yml` trên UI; repo chuẩn là `1.2-tunnel` / `1.1-services`. Nên `compose-update` về path trong bảng khi sửa.

## Dokploy projects (environmentId mặc định)

| Project | projectId | environmentId (production) |
|---------|-----------|----------------------------|
| **infra** | `KkmA-02rhTN8IUbfP4Pl_` | `U76qM6mMSh2z50w_s6fkZ` |
| **ai** | `ITVadb6vnE7g8JTtp6WFT` | `uzVSvfMzQzWhKQLGKY5ap` |
| **labs** | `hz2-EoX2j4Us0Dc3ibNcZ` | `2QppJte_7yJ7_ZTtsChjS` |
| **security** | `_6nXIROi5RpaPVbvsMKAO` | `A4uu16A-um9tusod2PM05` |
| **runner** | `Fwic2LFqY1NbO4_vfyZzm` | `wg30dObdqVhvE1sV498Lg` |
| clipfetch-dev | `9_sDvtIW5CQjIS3mUxR5J` | `zW7481lq4yXZrx2dvzI-e` |
| ycm-dev | `uFAhrbbddIJlQyqWhhe4F` | `hWRKnL54s1q2y5dosrQc-` |
| gifit-dev | `MUzOhJHU2utaIX6YUZzwE` | `ByNSuyfjC6lxhvxpmClBE` |

## Cloudflare Tunnel (home-lab)

| Hostname | Origin (Swarm service trên `dokploy-network`) |
|----------|-----------------------------------------------|
| `dokploy.wmamedia.qzz.io` | `http://dokploy:3000` |
| `router.wmamedia.qzz.io` | `http://infra-13-ai-router-yviz4s_ai-router:20128` |
| `router2.wmamedia.qzz.io` | `http://infra-14-9router-noskxg_nine-router:20128` |

Tunnel ID: `435b0ec2-4b1d-42fa-83fb-a09b91271053` (stack `01-infra-tunnel`).

## Host / DATA_DIR

- Manager: **travis-server**
- `DATA_DIR`: `/home/travis/10-docker-data` (xem `.cursor/rules/docker-data-dir.mdc`)