# `05-security`

Pattern: **`05-security-${SEC_FOLDER}-<service>`** (subfolder = `SEC_FOLDER`).

| Subfolder | Containers |
|-----------|------------|
| `5.1-artex-llm` | Swarm **`postgres`** + **`artex`** (PG nội bộ stack `@postgres:5432`) |

**Dokploy:** tạo project **security** (hoặc **infra**), stack GitHub `./05-security/5.1-artex-llm/docker-compose.yml` — compose **labs/01-artex-llm** đã xóa.

Volume host: `…/${SEC_FOLDER}_postgres`, `…/${SEC_FOLDER}_data`.

```bash
cd 05-security/5.1-artex-llm && cp .env.example .env
# manager:
mkdir -p /home/travis/10-docker-data/5.1-artex-llm_postgres /home/travis/10-docker-data/5.1-artex-llm_data
docker stack deploy -c docker-compose.yml 05-security-5.1-artex-llm
```

**Dokploy:** compose type **stack**, GitHub `./05-security/5.1-artex-llm/docker-compose.yml`, `createEnvFile: false`.