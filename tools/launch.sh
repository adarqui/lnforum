#!/bin/bash

###
### Temporary launch script for ln in production
###

PREFIX="/root/projects/leuronet"

git_clone_or_pull() {
    if [ ! -d "${PREFIX}/$1" ] ; then
        git clone ssh://git@github.com/adarqui/"$1" "${PREFIX}/$1"
    else
        (cd "${PREFIX}/$1"; git pull origin master)
    fi
}

for repo in ln-api ln-interop ln-lib ln-smf-migration ln-types ln-ui ln-yesod purescript-ln haskell-api-helpers; do
    git_clone_or_pull $repo
done

cd "${PREFIX}/ln-yesod"
make install
make exec_prod
