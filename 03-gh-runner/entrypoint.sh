#!/usr/bin/env bash
# Wrapper around myoung34/github-runner /entrypoint.sh
# Fixes bind-mount ownership, then hands off to the image entrypoint.
set -euo pipefail

PERSIST_DIR="${CONFIGURED_ACTIONS_RUNNER_FILES_DIR:-/tmp/github-runner}"
DIAG_DIR="${RUNNER_DIAG_DIR:-/actions-runner/_diag}"

ensure_writable() {
  local dir="$1"
  mkdir -p "${dir}"
  if [[ -w "${dir}" ]]; then
    return 0
  fi
  echo "Volume ${dir} is not writable (common with Swarm/host bind mounts)."
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Install sudo in the image or chown on the host: chown -R 1001:1001 ${dir}" >&2
    exit 1
  fi
  sudo chown -R "$(id -u):$(id -g)" "${dir}"
}

ensure_writable "${PERSIST_DIR}"
ensure_writable "${DIAG_DIR}"
mkdir -p "${PERSIST_DIR}/_work"

# myoung34 image entrypoint — uses REPO_URL, ACCESS_TOKEN, LABELS, etc.
exec /entrypoint.sh "$@"
