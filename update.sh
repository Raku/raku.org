#!/bin/bash

# this script is used by www.p6c.org to update the
# installation at www.perl6.org
date
set -e
git fetch -q
BEFORE=$(git rev-parse HEAD)
git checkout -q -f origin/master
./fetch-recent-blog-posts.pl
if [ "$BEFORE" != "$(git rev-parse HEAD)" ]
then
        if git diff --quiet $BEFORE HEAD includes
        then mowyw --make
        else mowyw
        fi
fi

# remove features [Now it's actually not]

#cd ~/features
#git fetch -q
#BEFORE=$(git rev-parse HEAD)
#git checkout -q -f origin/master
#if [ "$BEFORE" != "$(git rev-parse HEAD)" ]
#then perl process.pl > ~/perl6.org/online/compilers/features.html
#fi
