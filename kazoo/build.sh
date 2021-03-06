#!/bin/sh -e
REPO=${2:-"git@github.com:alianza-dev/alz-kazoo.git"}
#COMMIT=${1:-"$(../bin/get-commit $REPO)"}
SKIP_BUILD=${SKIP_BUILD:-""}
PROD_BUILD=${PROD_BUILD:-"1"}
UID=$(id -u)
GID=$(id -g)

if [ ! -d repo/kazoo ]
then
echo "git clone"
git clone $REPO repo/kazoo
fi

if [ -n $PROD_BUILD ]
then
echo "Production build was set"
fi

echo Using repository $REPO commit $COMMIT
echo $COMMIT > etc/commit
docker build $BUILD_FLAGS -t kazoo/kazoo \
	--build-arg REPO=$REPO \
	--build-arg SKIP_BUILD=$SKIP_BUILD \
	--build-arg PROD_BUILD=$PROD_BUILD \
	--build-arg UID=$UID \
	--build-arg GID=$GID \
	.
