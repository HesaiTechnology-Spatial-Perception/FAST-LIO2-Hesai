#!/bin/bash
set -e
source /opt/ros/noetic/setup.bash
source /ws/devel/setup.bash
exec "$@"
