#!/bin/bash

# Example of .env file
# export BUILD_DIR="/opt/deploy/tmp"
# export TARGET_DIR="/opt/www/blog"
# export BLOG_REPO="https://github.com/darlanalves/darlanalves.git"

source .env
set -e

echo 'Starting deploy... '

if [ -d "$BUILD_DIR" ]; then
    cd "$BUILD_DIR"
    git reset --hard HEAD
    git checkout master
    git fetch
    git rebase
else
    git clone -b master $BLOG_REPO $BUILD_DIR
fi

if [ -d "$BUILD_DIR" ]; then
    cd $BUILD_DIR
    npm update && hexo clean && hexo generate;
    rm -rf $TARGET_DIR &&
    mv $BUILD_DIR/public $TARGET_DIR
    echo OK
else
    echo 'Failed!';
    exit 1;
fi
