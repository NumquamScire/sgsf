#!/bin/bash


git log --follow --all --full-history --pretty=format:%H -- "$1" | while read commitHash; do
    if git checkout --force "$commitHash" -- "$1" >/dev/null 2>&1; then
        if [ "$(shasum "$1" | awk '{print $1}')" == "$2" ]; then
            branchName=$(git branch --contains "$commitHash")
            echo "Branch: $branchName"         
            echo -e "Commit: $commitHash"
            echo -e "Hash file: $2\n"
            git show --no-patch --format="%an %ad %s" "$commitHash"
        fi
    fi
done

