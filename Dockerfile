FROM ghcr.io/nagagroup/cuda-x11-docker:12.2.0

#install matplot++ dependencies
RUN sudo dnf install gnuplot qt5-qtsvg qt5-qtbase -y

#install extra tools
RUN sudo dnf install python39 librevenge-gdb git clang-tools-extra perf -y
RUN sudo dnf install ninja-build -y
RUN sudo dnf install vtk-devel openmpi-devel -y

RUN echo "source /opt/rh/gcc-toolset-12/enable" >> /home/gpu-dev/.bashrc
