#!/bin/sh

set -e

err_handler() {
    echo "An error occurred"
}
trap err_handler ERR

while IFS= read -r package || [ -n "$package" ]; do
    branch=$(echo "$package" | sed 's/^discord-*//')

    if [ -z "$branch" ]; then
        branch="stable"
    fi

    echo "Installing Equicord for $branch branch..."
    equicord-installer -install -branch "$branch" || {
        echo "Falling back to auto branch..."
        equicord-installer -install -branch auto
    }
done

