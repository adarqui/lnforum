#!/bin/bash -e

###
### Temporary launch script for ln in production
###

if [ $# -ne 1 ]; then
  echo 'usage: ./launch.sh <app:ln-yesod,lnotes-yesod>' && exit 1
fi

APP="$1"

PREFIX="/projects/leuronet"

git_clone_or_pull() {
  if [ ! -d "${PREFIX}/$1" ] ; then
    git clone ssh://git@github.com/adarqui/"$1" "${PREFIX}/$1"
  else
    (cd "${PREFIX}/$1"; git pull origin master)
  fi
}

git pull origin master

repos="ln-api \
  ln-validate \
  ln-sanitize \
  ln-interop \
  ln-lib \
  ln-smf-migration \
  ln-types \
  ln-ui \
  ln-yesod \
  ln-ui-core \
  ln-ui-ghcjs \
  haskell-api-helpers \
  haskell-api-helpers-shared \
  haskell-ln-types \
  haskell-either-helpers \
  haskell-ebyam \
  haskell-rehtie \
  haskell-ifte \
  haskell-bbcode-parser \
  lnotes-api \
  lnotes-sanitize \
  lnotes-ui-core \
  lnotes-ui-purescript \
  lnotes-validate \
  lnotes-yesod \
  haskell-lnotes-types \
  purescript-lnotes-api \
  purescript-lnotes-types \
  stm-lifted \
  yesod-auth-oauth2 \
  purescript-api-helpers \
  purescript-date-helpers \
  purescript-foreign \
  "

for repo in $repos; do
  git_clone_or_pull $repo
done

cd "${PREFIX}/${APP}"
make install
make exec_prod
