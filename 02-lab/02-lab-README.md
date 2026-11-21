# `02-lab` ↔ Dokploy (project **labs**)

| Folder | Dokploy compose `name` | Container prefix |
|--------|------------------------|------------------|
| `01-artex-llm` | `01-artex-llm` | `lab-01-artex-llm-*` |
| `02-ai-router` | `02-ai-router` | `lab-02-ai-router-postgres`, `lab-02-ai-router-redis` |
| `01-infra/03-ai-router` | (project infra) | `infra-03-ai-router-omniroute-<env>` |
| `03-decap-cms` | `03-decap-cms` | `lab-03-decap-cms-*` |

Compose project Docker: `lab-<folder>` (vd. `lab-03-decap-cms`).

Các stack khác trên Dokploy (`anythingllm`, `n8n-runner-…`, `9router` legacy) không map folder `02-lab`.