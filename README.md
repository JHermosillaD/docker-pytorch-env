# PyTorch Docker Development Environment

![Docker Image Size](https://img.shields.io/badge/Image%20Size-8.31GB-blue?)
![Ubuntu Version](https://img.shields.io/badge/Ubuntu-22.04.5%20LTS-orange?)
![CUDA Version](https://img.shields.io/badge/CUDA-11.8-76B900?)

> A PyTorch-based Docker container for machine learning development with GPU support and GUI capabilities.

This Docker image is based on **Ubuntu 22.04.5 LTS (Jammy Jellyfish)** with a pre-configured NVIDIA environment optimized for PyTorch development. The built image is approximately **8.31GB**.

## Features
- PyTorch with CUDA 11.8 and cuDNN 9 support
- Jupyter Lab for interactive development
- OpenCV with GUI support (X11 forwarding)
- Named pipe (FIFO) for real-time data streaming
- Docker Compose for easy management

## Host Requirements
- [x] NVIDIA drivers (compatible with CUDA 11.8)
- [x] NVIDIA Container Toolkit
- [x] Docker and Docker Compose
- [x] X11 server (for GUI applications)
- [x] FFmpeg

## Quick Start

### 1. Setup
```bash
# Enable X11 forwarding for GUI applications
xhost +local:docker
```
Restart your terminal to ensure X11 permissions take effect.

```bash
# Create named pipe inside the repository folder for data streaming
mkfifo image_stream

# Build the container
docker compose build pytorch-container
```

### 2. Run the Container
```bash
# Run with Jupyter Lab port mapping
docker compose run -p 8888:8888 pytorch-container
```

## Usage

### Jupyter Lab Development
Inside the container, launch:
```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```
Copy the URL with token from the output and open it in your browser.

### OpenCV GUI Applications
For Python scripts using OpenCV's `imshow()` or other GUI functions:
```bash
# Inside the container
python your_script.py
```

### Real-time Data Streaming
Use the FIFO pipe for streaming data between host and container:
```bash
# Inside the container (consumer)
python your_script.py < /tmp/image_stream
```
In a separate terminal inside the repository folder (while keeping the container script):
```bash
ffmpeg -f v4l2 -i /dev/video0 -s 640x480 -f rawvideo -pix_fmt rgb24 - > image_stream
```

## Project Structure
```
docker-pytorch-env/
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
├── image_stream         
├── pytorch-env/       
└── README.md
```

### Permission issues
- The container runs as root by default
- Files created in mounted volumes will have root ownership
