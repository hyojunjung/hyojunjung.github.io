#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

MESSAGE="${1:-Update website}"

hugo --destination /tmp/myblog-deploy-check --cleanDestinationDir

if [[ -z "$(git status --short --ignore-submodules)" ]]; then
  echo "No website changes to deploy."
  exit 0
fi

git add -A . ':!themes/PaperMod'
git commit -m "$MESSAGE"
git push origin main

echo "Pushed to main. GitHub Actions will deploy the site to GitHub Pages."
