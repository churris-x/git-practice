#!/bin/bash
# MIT Francisco Altimari @1743081961
#         --tag-    semver
# git tag v1.0.0 -m 1.0.0


# TODO: Also allow for specific version to be added
bumpversion () {
    # Show help if missing args
    if [ $# -eq 0 ]; then 
        echo 'Usage: bumpversion <major|minor|patch>'
        return 1
    fi

    local TAGS VERSION UPDATE

    TAGS=$(git tag)

    [ $? -ne 0 ] && return 1

    VERSION=$(git tag | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+' | tail -1)

    # If no version found, use 0.1.0
    [ -z $VERSION ] && VERSION='v0.1.0'

    # Extract major, minor and patch version numbers
    IFS=. read -r MAJOR MINOR PATCH <<< "${VERSION:1}"

    case $1 in
        major ) ((MAJOR++));;
        minor ) ((MINOR++));;
        patch ) ((PATCH++));;
        *) printf "Unknown argument: $1\n\nTry -h for help\n"; return 1 ;;
    esac

    UPDATE="$MAJOR.$MINOR.$PATCH"

    printf "Bumping from $VERSION => v$UPDATE\n\n"

    git commit -v --allow-empty --edit -m "$UPDATE"

    [ $? -ne 0 ] && return 1
    git tag "v$UPDATE" -m $UPDATE
}


bumpversion minor

# git push --tags origin master


