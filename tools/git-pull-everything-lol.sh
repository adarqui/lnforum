#!/bin/bash

export PREFIX="/Users/x/code/src/github.com/adarqui/lnforum"

for repo in `ls -d ${PREFIX}/*/`; do
  echo "${repo}"
  cd "${repo}"
  git pull origin master
done
