FROM ubuntu:20.04
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y && apt upgrade -y
RUN apt install -y cmake clang bison flex libfuse-dev libudev-dev pkg-config libc6-dev-i386 \
gcc-multilib libcairo2-dev libgl1-mesa-dev libglu1-mesa-dev libtiff5-dev \
libfreetype6-dev git git-lfs libelf-dev libxml2-dev libegl1-mesa-dev libfontconfig1-dev \
libbsd-dev libxrandr-dev libxcursor-dev libgif-dev libavutil-dev libpulse-dev \
libavformat-dev libavcodec-dev libswresample-dev libdbus-1-dev libxkbfile-dev \
libssl-dev python2 git
RUN git clone --recursive https://github.com/darlinghq/darling.git && cd darling
RUN mkdir build && cd build
RUN cmake .. 
RUN bash -c "make -j`nproc`"
RUN make install
RUN cd ../.. && rm -rf darling
ENTRYPOINT ["/usr/local/bin/darling shell"]
