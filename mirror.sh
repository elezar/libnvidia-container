#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage mirror.sh [SOURCE] [TARGET]"
    exit 1
fi

source=$1
target=$2

if [[ -e ${target} ]]; then
    echo "The specified target ${target} exists"
    exit 1
fi

if [[ ! -d ${source} ]]; then
    echo "The specified source ${source} does not exist"
    exit 1
fi


set -x
repofiles=$(find ${source} -maxdepth 1 -iname '*.repo' -o -iname '*.list')

if [[ -z ${repofiles} ]]; then
    echo "Repo definition not found"
    exit 1
fi

mkdir -p ${target}
for r in ${repofiles}; do
    repofile=$(basename ${r})
    ( cd ${target} && ln -s ../${source}/${repofile} ${repofile} )
done
