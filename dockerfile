FROM ubuntu:22.04
RUN apt update && apt -y  upgrade
RUN apt install -y wget 
RUN wget https://www.roboti.us/download/mujoco200_linux.zip
# RUN wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz
RUN apt install -y unzip tar
RUN mkdir ~/.mujoco
RUN cp mujoco200_linux.zip ~/.mujoco && cd ~/.mujoco && unzip mujoco200_linux.zip
# RUN cp mujoco210-linux-x86_64.tar.gz ~/.mujoco && cd ~/.mujoco && tar -zxvf mujoco210-linux-x86_64.tar.gz
COPY ./mjkey.txt /
RUN cp mjkey.txt ~/.mujoco && cp mjkey.txt ~/.mujoco/mujoco200_linux/bin
RUN mv  ~/.mujoco/mujoco200_linux  ~/.mujoco/mujoco200
ENV LD_LIBRARY_PATH=~/.mujoco/mujoco200/bin${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
ENV MUJOCO_KEY_PATH=~/.mujoco${MUJOCO_KEY_PATH}
RUN apt-get update && apt-get install -y libgl1 libxrandr-dev libxinerama-dev libxcursor-dev
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh
RUN chmod a+x Anaconda3-2023.03-1-Linux-x86_64.sh && ./Anaconda3-2023.03-1-Linux-x86_64.sh -b -p /usr/local/anaconda
# RUN apt-get install -y  python2 python-pip python3
# RUN pip install mujoco_py==2.0.2.8
# RUN cd /usr/local/anaconda/bin   && ./conda init bash
ENV PATH="/usr/local/anaconda/bin:$PATH"

RUN conda init bash
RUN echo 'export LD_LIBRARY_PATH=~/.mujoco/mujoco200/bin' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
# RUN python --version
RUN pip install mujoco_py==2.0.2.8
RUN apt-get install -y gcc libosmesa6-dev
# RUN apt-get update && \
#     apt-get install -y software-properties-common && \
#     add-apt-repository -y ppa:ubuntu-toolchain-r/test
# RUN apt-get update && \
#     apt-get upgrade -y libstdc++6
# RUN conda create --name py36 python=3.6 --yes

# RUN conda activate py36 && conda install libgcc
RUN cd /usr/local/anaconda/bin/../lib/ && rm libstdc++.so && rm libstdc++.so.6 && \ 
ln -d /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.30 libstdc++.so \
&& ln -d /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.30 libstdc++.so.6
RUN pip install  simple_pid termcolor
RUN apt-get update && apt-get install -y libqt5x11extras5 libxcb-xinerama0