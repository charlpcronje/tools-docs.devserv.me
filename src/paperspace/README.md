# Paper{s}pace

## Install Using Docker Command

```sh
sudo docker run --gpus all -d -p 8888:8888 paperspace/fastai:2.0-CUDA9.2-base-3.0-v0.0.11-jupyterlab
```

- The Docker container should contain all dependencies
- I use `NginX Proxy Manager` to point a `sub-domain` to port `8888`



