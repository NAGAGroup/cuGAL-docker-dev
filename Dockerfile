FROM ghcr.io/nagagroup/cuda-x11-docker:latest

# Copy pixi project for devenv
RUN rm -rf /home/gpu-dev/.local/share/devenv
COPY devenv /home/gpu-dev/.local/share/devenv
RUN cd /home/gpu-dev/.local/share/devenv
RUN sudo chown -R gpu-dev:gpu-dev /home/gpu-dev/.local/share/devenv
RUN echo "export LD_LIBRARY_PATH=\$PIXI_PROJECT_ROOT/.pixi/envs/default/lib:\$LD_LIBRARY_PATH" >> /home/gpu-dev/.bashrc

# install paraview for data visualization
RUN sudo dnf install paraview -y

ENTRYPOINT ["/bin/bash", "-c", "bash -c \"sudo /sbin/sshd -D -p 2222&\"; /bin/bash", "-c"]
EXPOSE 2222

