# Dockerfile for building your own Cellframe Node Docker image

With this Dockerfile you can build and run your own Cellframe node docker image on any flavour of Linux using the provided shell script or manually.


## Build and run the image using the shell script

1. Start the docker service if it is not already running

    ```sh
    systemctl start docker
    ```
    
2. Run the shell script with the following parameters
    - **name** - (mandatory) the name you want to assign to the container
    - **-d** - (optional) flag to run the service as a daemon
    - **major version number** - (optional) integer major version number, if omitted it will pull from a file nominally containing the latest version, if supplied you must also supply...
    - **minor version number** - (optional) integer minor version number
    
    examples
    ```sh
    ./build_and_run.sh cellframe
    ```
    ```sh
    ./build_and_run.sh cellframe -d
    ```
    ```sh
    ./build_and_run.sh cellframe -d 5 3
    ```
    ```sh
    ./build_and_run.sh cellframe 5 3
    ```


## Build and run the image yourself

1. Start the docker service if it is not already running

    ```sh
    systemctl start docker
    ```

2. First, create an image by executing the following command from the current directory:

    ```sh
    docker build -t  <name> --build-arg VMAJOR=<major version> --build-arg VMAJOR=<minor version> .
    ```

3. Then create a volume with:

    ```sh
    docker volume create cellframe
    ```

4. And start the node by running:

    ```sh
    docker run -v cellframe:/opt/cellframe-node --name=cellframe-node --privileged --net=host -it <name>
    ```

5. Or as daemon:

    ```sh
    docker run -v cellframe:/opt/cellframe-node --name=cellframe-node --privileged --net=host -itd <name>
    ```

## Check logs if running as daemon

   ```sh
   docker logs -f <name>
   ```

## Stop the container

   ```sh
   docker stop <name>
   ```
