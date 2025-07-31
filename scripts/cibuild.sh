#!/bin/sh

set -e

cmd_container () {
  # https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables
  tag_version="v1-$(date +%Y%m%d)-${GITHUB_RUN_NUMBER}"

  echo $QUAY_PASSWORD | docker login quay.io -u $QUAY_USERNAME --password-stdin
  full_tag="quay.io/chroot.club/proto-25:${tag_version}"
  docker build --build-arg quay_expiration="8w" -t $full_tag .

  # Also tag as "latest"
  latest_tag="quay.io/chroot.club/proto-25:latest"
  docker tag $full_tag $latest_tag

  # Push both tags
  docker push $full_tag
  docker push $latest_tag
}

if [ -z $1 ]; then
  cmd_container
fi

CMD=$1
shift
case $CMD in
  container)
    cmd_$CMD $@
    ;;
  *)
    echo "unknown command $CMD"
    exit 1
    ;;
esac
