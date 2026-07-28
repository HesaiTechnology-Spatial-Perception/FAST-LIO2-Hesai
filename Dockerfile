# FAST_LIO_Hesai — ROS 1 (Noetic) build image
#
#   docker build -t fast_lio_hesai:ros1 .
#   docker run -it --rm --net host fast_lio_hesai:ros1 \
#       roslaunch fast_lio mapping_jt16.launch rviz:=false
#
# For RViz, run with X11 forwarding (e.g. -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix).
FROM ros:noetic-ros-base-focal

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libeigen3-dev \
        libpcl-dev \
        ros-noetic-pcl-ros \
        ros-noetic-pcl-conversions \
        ros-noetic-std-srvs \
        ros-noetic-tf \
        ros-noetic-rviz \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ws/src/FAST_LIO_Hesai
COPY . .

WORKDIR /ws
RUN . /opt/ros/noetic/setup.sh && \
    catkin_make -DCMAKE_BUILD_TYPE=Release

RUN echo 'source /ws/devel/setup.bash' >> /root/.bashrc
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
