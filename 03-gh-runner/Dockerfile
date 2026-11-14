# FFShop org runners: Node 24 + Yarn 4.1.1 on PATH for setup-node (cache: yarn) before workflow Corepack step.
# Base: https://github.com/myoung34/docker-github-actions-runner
FROM myoung34/github-runner:latest

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG NODE_MAJOR=24
ARG YARN_VERSION=4.1.1

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
    > /etc/apt/sources.list.d/nodesource.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && rm -rf /var/lib/apt/lists/* \
  && corepack enable \
  && corepack prepare "yarn@${YARN_VERSION}" --activate \
  && node --version \
  && yarn --version

# setup-node and job steps expect yarn on PATH (GitHub-hosted images ship similarly).
ENV PATH="/usr/bin:/usr/local/bin:${PATH}"
