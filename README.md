# docker-pytorch-env
 A pytorch based docker container to develop machine learning.

## Setup and Run
1. Allow Docker to access display: 
`xhost +local:docker`
2. Restart your terminal/console
3. Build the container:
`docker compose build pytorch-container`
4. Run the container with port mapping:
`docker compose run -p 8888:8888 pytorch-container`
5. Inside the container, start Jupyter Lab:
`jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root`
6. Copy the URL with token from the output and open it in your browser