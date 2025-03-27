#!/bin/bash
# MIT Francisco Altimari @1743081961

# version < major | minor | patch >
# Create a commit, create a tag with the correct message
# Find previous versions and increment from them
# Also allow for specific version to be added

#         --tag-    semver
# git tag v1.0.0 -m 1.0.0

# Get latest semantic versioning tag
bumpversion () {
    # Show help if missing args
    if [ $# -eq 0 ]; then 
        echo 'Usage: bumpversion <major|minor|patch>'
        return 1
    fi

    local TAGS VERSION

    TAGS=$(git tag)

    [ $? -ne 0 ] && return 1

    VERSION=$(git tag | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+' | tail -1)

    # If no version found, use 0.1.0
    [ -z $VERSION ] && VERSION='v0.1.0'

    echo 'version' $VERSION

    IFS=. read -r MAJOR MINOR PATCH <<< "${VERSION:1}"

    echo 'MAJOR' $MAJOR
    echo 'MINOR' $MINOR
    echo 'PATCH' $PATCH

    echo ''

    case $1 in
        major ) $(($MAJOR + 1));;
        minor ) $(($MINOR + 1));;
        patch ) $(($PATCH + 1));;
        *) printf "Unknown argument: $1\n\nTry -h for help\n"; return 1 ;;
    esac


    echo "v$MAJOR.$MINOR.$PATCH"
}


bumpversion major



# git push --tags
# git push --tags origin master


