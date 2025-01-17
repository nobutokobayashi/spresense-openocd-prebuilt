#!/bin/sh

which docker >/dev/null || {
    echo "Please install docker first!";
    exit 1;
}

if [ "`uname -s`" = "Darwin" ]; then
    # Build MacOS package
    ./build.sh
fi

# Make sure want to be build container exists

docker build -t buildenv .

# Linux 64 bit and other supported architectures

docker run -it --rm --mount "type=bind,source=$(pwd),destination=/work" --name build buildenv ./build.sh
docker run -it --rm --mount "type=bind,source=$(pwd),destination=/work" --name build buildenv ./build.sh win32
docker run -it --rm --mount "type=bind,source=$(pwd),destination=/work" --name build buildenv ./build.sh win64
