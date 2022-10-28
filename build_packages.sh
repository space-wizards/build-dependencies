#!/usr/bin/env bash

set -e 

cd "$(dirname $0)"

mkdir -p packages_build

find Packages -name '*.nupkg' -delete

for proj in `ls Packages`; do 
    dotnet pack Packages/$proj/$proj.csproj &
done

wait

find Packages -name '*.nupkg' | xargs -Ifiles cp files packages_build/

echo
ls packages_build/

echo
echo `ls packages_build/ | wc -l`" packages built."
