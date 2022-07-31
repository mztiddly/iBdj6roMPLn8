#! /usr/bin/bash
BACKUPDIR="./backup/$(date -Idate)"

if [ -d "$BACKUPDIR" ]; then
    echo
    echo "Output directory \"$BACKUPDIR\" already exists."
    echo

    exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
    echo
    echo "Found uncommitted changes."
    echo

    exit 1
    echo "there are changes";
fi

mkdir -p "$BACKUPDIR"

git pull

mv ".git" "$BACKUPDIR/"
cp "index.html" "$BACKUPDIR/"

git init
git status

git config --local credential.helper ''
git config --local commit.gpgsign false
git config --local user.name "May Bee"
git config --local user.email "may.bee@123.plirp"

git add .
git add -f index.html
git status

git commit -m "new root commit"
git log

git branch -m "master" "main"
git remote add origin  https://github.com/mztiddly/iBdj6roMPLn8.git
git push --force --set-upstream origin main
