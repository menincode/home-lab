#!/usr/bin/env bash
# Entrypoint for official ghcr.io/actions/actions-runner
# Registers against an org (or repo) using a GitHub PAT in ACCESS_TOKEN.
set -euo pipefail

cd /home/runner

ORG_NAME="${ORG_NAME:?ORG_NAME is required}"
ACCESS_TOKEN="${ACCESS_TOKEN:?ACCESS_TOKEN is required (GitHub PAT with manage runners)}"
RUNNER_SCOPE="${RUNNER_SCOPE:-org}"
REPO_NAME="${REPO_NAME:-}"
RUNNER_NAME="${RUNNER_NAME:-$(hostname)}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,Linux,X64,docker}"
RUNNER_WORKDIR="${RUNNER_WORKDIR:-_work}"
PERSIST_DIR="${RUNNER_PERSIST_DIR:-/home/runner/persist}"
DISABLE_AUTOMATIC_DEREGISTRATION="${DISABLE_AUTOMATIC_DEREGISTRATION:-true}"

if [[ "${RUNNER_SCOPE}" == "repo" ]]; then
  REPO_NAME="${REPO_NAME:?REPO_NAME is required when RUNNER_SCOPE=repo}"
  GITHUB_URL="https://github.com/${ORG_NAME}/${REPO_NAME}"
  TOKEN_API="https://api.github.com/repos/${ORG_NAME}/${REPO_NAME}/actions/runners/registration-token"
else
  GITHUB_URL="https://github.com/${ORG_NAME}"
  TOKEN_API="https://api.github.com/orgs/${ORG_NAME}/actions/runners/registration-token"
fi

mkdir -p "${PERSIST_DIR}/${RUNNER_WORKDIR}"
# Keep job workspace on the persist volume (avoid filling the container layer)
if [[ -e "${RUNNER_WORKDIR}" && ! -L "${RUNNER_WORKDIR}" ]]; then
  rm -rf "${RUNNER_WORKDIR}"
fi
ln -sfn "${PERSIST_DIR}/${RUNNER_WORKDIR}" "${RUNNER_WORKDIR}"

if [[ -f "${PERSIST_DIR}/.runner" ]]; then
  cp -a "${PERSIST_DIR}/.runner" "${PERSIST_DIR}/.credentials"* ./ 2>/dev/null || true
fi

fetch_registration_token() {
  local response token
  response="$(curl -fsSL -X POST \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "${TOKEN_API}")"
  token="$(printf '%s' "${response}" | jq -r '.token // empty')"
  if [[ -z "${token}" ]]; then
    echo "Failed to obtain registration token from ${TOKEN_API}" >&2
    echo "${response}" >&2
    exit 1
  fi
  printf '%s' "${token}"
}

persist_state() {
  cp -a .runner .credentials* "${PERSIST_DIR}/" 2>/dev/null || true
}

remove_runner() {
  if [[ "${DISABLE_AUTOMATIC_DEREGISTRATION}" == "true" ]]; then
    return 0
  fi
  local token
  token="$(fetch_registration_token || true)"
  if [[ -n "${token}" && -f .runner ]]; then
    ./config.sh remove --token "${token}" || true
  fi
}

trap remove_runner EXIT

if [[ ! -f .runner ]]; then
  echo "Configuring GitHub Actions runner: ${RUNNER_NAME} (${RUNNER_LABELS}) → ${GITHUB_URL}"
  REG_TOKEN="$(fetch_registration_token)"
  ./config.sh \
    --url "${GITHUB_URL}" \
    --token "${REG_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --labels "${RUNNER_LABELS}" \
    --work "${RUNNER_WORKDIR}" \
    --unattended \
    --replace
  persist_state
else
  echo "Using existing runner config for ${RUNNER_NAME} (persist volume)"
fi

exec ./run.sh
