# NAGA-docker-dev
This is an extension of [cuda-x11-docker](https://github.com/cuGAL/cuda-x11-docker) with some extra packages for NAGA development.

## Key Features

### EGL Support
This image, along with its base image, now supports EGL rendering if using the `nvidia-container-runtime`. This means headless rendering is now supported! 

### TurboVNC + i3wm
TurboVNC and i3 are both installed by default, allowing for remote desktop from within the container, without any monitors.

### VirtualGL
With the added EGL support, it's only natural to include VirtualGL as well, allowing one to run 3D apps on the GPU when connected to a remote desktop session. Just ensure that `vglrun` is launched with an `egl` device so that the EGL backend is used for rendering.

### ParaView
A full paraview installation is included as well, an essential tool for NAGA developers and users alike. Although ParaView supports a server-client model for remote rendering, I found that I got better performance when just running the ParaView GUI on the remote server and interacted with it via TurboVNC.

## Prerequisites

- `docker` or `podman`
- [`nvidia-container-runtime`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installation-guide). Note, if using Fedora, the CentOS/RHEL repos work just fine.

## Usage
By default, any container spun up with this image launches an ssh server on port 2222. The following guide assumes a user is running it with this default and `podman` as the container runtime. If you're using `docker`, you can't simply replace `podman` with `docker`, unfortunately. There are some extra arguments required by the `nvidia-container-runtime`, so check their documentation for more info. Aside from those extra arguments, it's mostly the same.

Launching a container:
```bash
podman run --rm --security-opt=label=disable -d -p 2222:2222 -p 5901:5901 ghcr.io/nagagroup/naga-docker-dev:latest
```

The port arguments allow for SSH and remote desktop access.

### Accessing via SSH
```bash
ssh gpu-dev@localhost -p 2222
```

The password is: `naga_is_awesome`

### Launching Remote Desktop
Once you've ssh'd into the container, you can launch a remote desktop session with the following command:
```bash
/opt/TurboVNC/bin/vncserver -xstartup i3
```

This will start a VNC server on port 5901. You can connect to it with any VNC client. I recommend [TigerVNC](https://tigervnc.org/).

### Running 3D Apps on the GPU
Once connected the VNC server using a viewer, any 3D app can be run on the GPU using:
```bash
/opt/VirtualGL/bin/vglrun -d egl0 <app>
```

### EGL with Multiple GPUs
If using multiple GPUs, you can select the GPU you want an app to run on by passing in a different EGL device to the `-d` option above. 

You can use the `eglinfo` command to get a list of devices and to get info for each device like its vendor:
```bash
/opt/VirtualGL/bin/eglinfo -e  #  Lists all devices
/opt/VirtualGL/bin/eflinfo -d egl0  | grep - vendor  # Get vendor for device egl0
```
