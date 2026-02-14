#!/bin/sh

set -e

cmd_container () {
  # Create a calendar-sortable string as a container version number
  tag_version="v1-$(date +%Y%m%d)-${GITHUB_RUN_NUMBER}"

  # Only login to quay.io if we're going to push (on main or dev branch)
  if [ "$GITHUB_REF_NAME" = "main" ] || [ "$GITHUB_REF_NAME" = "dev" ]; then
    echo $QUAY_PASSWORD | docker login quay.io -u $QUAY_USERNAME --password-stdin
  fi

  # The "full tag" is a calendar-sortable version
  full_tag="quay.io/chroot.club/raku-org-website:${tag_version}"
  docker build --build-arg quay_expiration="24w" -t $full_tag .

  # Also tag this build as "latest"
  latest_tag="quay.io/chroot.club/raku-org-website:latest"
  docker tag $full_tag $latest_tag

  # Only push if on main or dev branch
  if [ "$GITHUB_REF_NAME" = "main" ]; then
    echo "Pushing container images (branch: $GITHUB_REF_NAME)"
    # Push both full tag and latest
    docker push $full_tag
    docker push $latest_tag
  elif [ "$GITHUB_REF_NAME" = "dev" ]; then
    echo "Pushing dev container images (branch: $GITHUB_REF_NAME)"
    # Only push and overwrite the "dev" tag in this case
    dev_tag="quay.io/chroot.club/raku-org-website:dev"
    docker tag $full_tag $dev_tag
    docker push $dev_tag
  else
    echo "Skipping push (branch: $GITHUB_REF_NAME, only pushing from main or dev)"
  fi
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

