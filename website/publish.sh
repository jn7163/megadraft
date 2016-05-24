#!/bin/bash

set -e

cd "$(dirname "$0")"
cd ..
npm run site
git clone --branch gh-pages --depth=50 \
        "https://$GH_TOKEN@github.com/globocom/megadraft.git"
cd megadraft
git ls-files | xargs git rm -rf
mv -f ../website/* .
mv ../bundle* .
git add -A .
if ! git diff-index --quiet HEAD --; then
  git commit -m "Update github pages"
  git push origin gh-pages
fi
