#!/usr/bin/env bash
set -euo pipefail

cd /home/runner

PERSIST_DIR="/home/runner/persist"

RUNNER_URL="${RUNNER_URL:?RUNNER_URL is required (e.g. https://github.com/FFShopGaming)}"
RUNNER_TOKEN="${RUNNER_TOKEN:?RUNNER_TOKEN is required — use a fresh org registration token}"
RUNNER_NAME="${RUNNER_NAME:?RUNNER_NAME is required}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,ubuntu,docker}"
RUNNER_WORKDIR="${RUNNER_WORKDIR:-_work}"

ensure_persist_writable() {
  if [[ -w "${PERSIST_DIR}" ]]; then
    return 0
  fi

  echo "Persist volume ${PERSIST_DIR} is not writable (common with Dokploy/host bind mounts)."
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Install sudo or fix host ownership, e.g. chown -R 1001:1001 <RUNNER_DATA_ROOT>/runner-N" >&2
    exit 1
  fi

  sudo mkdir -p "${PERSIST_DIR}"
  sudo chown -R "$(id -u):$(id -g)" "${PERSIST_DIR}"
}

ensure_persist_writable
mkdir -p "${PERSIST_DIR}/${RUNNER_WORKDIR}"

if [[ -e _work ]] && [[ ! -L _work ]]; then
  rm -rf _work
fi
ln -sfn "${PERSIST_DIR}/${RUNNER_WORKDIR}" _work

if [[ -f "${PERSIST_DIR}/.runner" ]]; then
  cp -a "${PERSIST_DIR}/.runner" "${PERSIST_DIR}/.credentials"* /home/runner/ 2>/dev/null || true
fi

persist_runner_state() {
  cp -a .runner .credentials* "${PERSIST_DIR}/" 2>/dev/null || true
}

if [[ ! -f .runner ]]; then
  echo "Configuring GitHub Actions runner: ${RUNNER_NAME} (${RUNNER_LABELS})"
  ./config.sh \
    --url "${RUNNER_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --labels "${RUNNER_LABELS}" \
    --work "${RUNNER_WORKDIR}" \
    --unattended \
    --replace
  persist_runner_state
else
  echo "Using existing runner config for ${RUNNER_NAME} (persist volume)"
fi

exec ./run.sh
