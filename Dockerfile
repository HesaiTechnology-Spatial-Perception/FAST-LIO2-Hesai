# FAST_LIO_Hesai — ROS 2 (Humble) build image
#
#   docker build -t fast_lio_hesai:ros2 .
#   docker run -it --rm --net host fast_lio_hesai:ros2 \
#       ros2 launch fast_lio mapping_jt16.launch.py rviz:=false
#
# For RViz, run with X11 forwarding (e.g. -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix).
FROM ros:humble-ros-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libeigen3-dev \
        libpcl-dev \
        ros-humble-pcl-ros \
        ros-humble-pcl-conversions \
        ros-humble-rviz2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ws/src/FAST_LIO_Hesai
COPY . .

WORKDIR /ws
RUN . /opt/ros/humble/setup.sh && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN echo 'source /ws/install/setup.bash' >> /root/.bashrc
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
