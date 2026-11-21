#!/bin/sh
set -e

apk add --no-cache git >/dev/null
npm install -g decap-server@3.11.6 >/dev/null 2>&1

HOST="${DECAP_PUBLIC_HOST:-127.0.0.1}"
HTTP_PORT="${DECAP_HTTP_PORT:-8790}"
PROXY_PORT="${DECAP_PROXY_PORT:-8081}"

if [ ! -f /repo/admin/config.yml ]; then
  mkdir -p /repo/admin /repo/content/posts /repo/static/images
  cat > /repo/admin/config.yml <<EOF
local_backend:
  url: http://${HOST}:${PROXY_PORT}/api/v1
  allowed_hosts: ["localhost", "127.0.0.1", "${HOST}"]
backend:
  name: git-gateway
  branch: main
publish_mode: editorial_workflow
media_folder: static/images
public_folder: /static/images
collections:
  - name: blog
    label: Blog
    folder: content/posts
    create: true
    fields:
      - { label: Title, name: title, widget: string }
      - { label: Body, name: body, widget: markdown }
EOF
  printf '%s\n' '---' 'title: Welcome' '---' '' 'First post.' > /repo/content/posts/welcome.md
fi

sed -i "s|^\(  url: \)http://[^ ]*|\1http://${HOST}:${PROXY_PORT}/api/v1|" /repo/admin/config.yml
sed -i "s|allowed_hosts:.*|allowed_hosts: [\"localhost\", \"127.0.0.1\", \"${HOST}\"]|" /repo/admin/config.yml

if [ ! -d /repo/.git ]; then
  cd /repo
  git init -b main
  git config user.email "decap@home-lab.local"
  git config user.name "Decap CMS"
  git add -A
  git commit -m "chore: initial content" || true
fi

exec decap-server