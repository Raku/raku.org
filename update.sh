#!/bin/bash

# this script is used by www.p6c.org to update the
# installation at www.perl6.org
date
source ~/perl5/perlbrew/etc/bashrc
set -e
cd ~/perl6.org
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

# The ~/features dir contains a checkout of
# the https://github.com/perl6/features repo
cd ~/features
git fetch -q
BEFORE=$(git rev-parse HEAD)
git checkout -q -f origin/master
if [ "$BEFORE" != "$(git rev-parse HEAD)" ]
then perl process.pl > ~/perl6.org/online/compilers/features.html
fi
