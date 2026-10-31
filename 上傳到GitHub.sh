#!/bin/bash
# 把這個資料夾的三款小遊戲放上 GitHub Pages（公開網站）。
# 網址會是 https://tri90035156-debug.github.io/mini-games-27/
set -e
cd "$(dirname "$0")"
REPO=mini-games-27
OWNER=tri90035156-debug
if [ ! -d .git ]; then
  git init -q -b main
  git config user.name "$OWNER"
  git config user.email "tri90035156@gmail.com"
fi
git add -A
git commit -q -m "Update mini-game demos" || true
if ! gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  gh repo create "$REPO" --public --source . --push --description "Mini game demos"
  gh api -X POST "repos/$OWNER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null
else
  git push -q origin main
fi
echo "完成。約 1 分鐘後可以打開： https://$OWNER.github.io/$REPO/"
