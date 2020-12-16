#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to Github...\033[0m\n"

# Build the project
hugo -t beautifulhugo

# Go to public directory
cd public

# Add changes to git
git add .

# Commit changes
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -S -m "$msg"

# push source and build repos
git push origin main
