#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "Initial commit"
git push -f https://github.com/richwell44/rick-and-morty-task.git master:gh-pages

cd -