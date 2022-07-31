#! /usr/bin/bash
BACKUPDIR="./backup/$(date -Idate)"

if [ -n "$(git status --porcelain)" ]; then
    echo
    echo "Found uncommitted changes."
    echo

    exit 1
fi

if [ -d "$BACKUPDIR" ]; then
    echo
    echo "Output directory \"$BACKUPDIR\" already exists."
    echo

    exit 1
else
    mkdir -p "$BACKUPDIR"
fi

# get latest changes from remote repository
if ! git pull; then
    echo
    echo "Git pull returned a non-zero exit code."
    echo

    exit 1
fi

# backup local repository
mv ".git" "$BACKUPDIR/"
cp "index.html" "$BACKUPDIR/"

# create new local repository
git init
git status

git config --local credential.helper ''
git config --local commit.gpgsign false
git config --local user.name "May Bee"
git config --local user.email "may.bee@123.plirp"

# add relevant files
git add .
git add -f index.html
git status

# create single commit from current data
git commit -m "new root commit"
git log

# upload to remote repository
git branch -m "master" "main"
git remote add origin  https://github.com/mztiddly/iBdj6roMPLn8.git
git push --force --set-upstream origin main
