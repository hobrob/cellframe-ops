#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: ./build_and_run.sh <name> [-d] (for daemonizing) [<major version number> <minor version number>] (for specifying a version, specify both major and minor or no effect)"
    exit 1    
elif [ $# -eq 2 ] || [ $# -eq 4 ]; then
    if [ "$2" != "-d" ]; then
            echo "Unsupported argument: $2, exiting..."
            exit 1
    else
            DAEMON="d"
                if [ $# -eq 4 ]; then
                        VMAJOR=$3
                        VMINOR=$4
                else
                        source latest_version
                fi
    fi
elif [ $# -eq 3 ]; then
        VMAJOR=$2
        VMINOR=$3
else
        source latest_version
fi
docker build -t "$1" --build-arg VMAJOR="$VMAJOR" --build-arg VMINOR="$VMINOR" .
docker volume create "$1"
docker run -v "$1":/opt/cellframe-node --name="$1" --privileged --net=host -it"$DAEMON" "$1"
