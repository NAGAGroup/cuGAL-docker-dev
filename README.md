# NAGA-docker-dev
This is an extension of [cuda-x11-docker](https://github.com/cuGAL/cuda-x11-docker) with some extra packages for NAGA development. For usage see the `README.md` in the [cuda-x11-docker](https://github.com/cuGAL/cuda-x11-docker) repo.

Usage:

Launch container as daemon
```shell
podman run --rm --security-opt=label=disable -d -p 2222:2222 ghcr.io/nagagroup/naga-docker-dev:12.0.1
```

SSH into it:
```
ssh -X gpu-dev@localhost -p 2222
```

Password is: `naga_is_awesome`
