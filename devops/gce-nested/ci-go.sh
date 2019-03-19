#!/bin/bash
# Wrapper script to managed GCE-based CI runs, specifically:
#
#   * create GCE host
#   * provision staging VMs within GCE host
#   * clean up GCE host
#
# We're using a wrapper script for this functionality to ensure
# that errors propagate up to the CI runner, so that any non-zero
# exit aborts the run and the CI job is marked as failing.
set -e
set -u
set -o pipefail


# Assume we're running against Xenial; Trusty also supported.
target_platform="${1:-xenial}"

./devops/gce-nested/gce-start.sh
./devops/gce-nested/gce-runner.sh "$target_platform"
./devops/gce-nested/gce-stop.sh
