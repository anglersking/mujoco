docker rm -f mujoco
docker build -t mujoco . 
docker run -dit --privileged  --ipc=host --net=host -v  $(pwd):/home  --group-add video \
--volume=/tmp/.X11-unix:/tmp/.X11-unix  --env="DISPLAY=$DISPLAY" \
--env="QT_X11_NO_MITSHM=1"  --device=/dev/dri:/dev/dri \
--env="XDG_RUNTIME_DIR=/tmp/runtime-root" \
--name mujoco mujoco

