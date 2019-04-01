#!/bin/bash -e

###
### Temporary launch script for ln in production
###

PREFIX="/projects/lnforum"
mkdir -p ${PREFIX}

git_clone_or_pull() {
  if [ ! -d "${PREFIX}/$1" ] ; then
    git clone ssh://git@github.com/adarqui/"$1" "${PREFIX}/$1"
  else
    (cd "${PREFIX}/$1"; git pull origin master)
  fi
}

git pull origin master

repos="\
  lnforum-api \
  lnforum-api-ghcjs \
  lnforum-validate \
  lnforum-sanitize \
  lnforum-interop \
  lnforum-lib \
  lnforum-smf-migration \
  lnforum-types \
  lnforum-types-gen \
  lnforum-yesod \
  lnforum-ui-core \
  lnforum-ui-reactflux \
  lnforum-ui-ghcjs \
  haskell-api-helpers \
  haskell-api-helpers-ghcjs \
  haskell-api-helpers-shared \
  haskell-either-helpers \
  haskell-ebyam \
  haskell-rehtie \
  haskell-ifte \
  haskell-bbcode-parser \
  haskell-bbcode-parser-reactflux \
  haskell-media-embed \
  haskell-media-embed-reactflux \
  haskell-web-bootstrap \
  ghcjs-ajax \
  ghcjs-router \
  react-flux-router \
  web-routes"

mkdir -p "${PREFIX}"
for repo in $repos; do
  echo $repo
  git_clone_or_pull $repo
done

cd "${PREFIX}/lnforum-yesod"
make install
make exec_prod
