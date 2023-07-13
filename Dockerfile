FROM ghcr.io/nagagroup/cuda-x11-docker:12.2.0

#install matplot++ dependencies
RUN sudo dnf install gnuplot qt5-qtsvg qt5-qtbase -y

#install extra tools
RUN sudo dnf install python39 librevenge-gdb git clang-tools-extra perf -y
RUN sudo dnf install ninja-build -y
RUN sudo dnf install vtk-devel openmpi-devel -y

RUN echo "source /opt/rh/gcc-toolset-12/enable" >> /home/gpu-dev/.bashrc

# install i3 window manager and remote desktop tools
RUN sudo dnf install i3 -y
RUN sudo dnf install wget -y
RUN wget "https://sourceforge.net/projects/virtualgl/files/3.1/VirtualGL-3.1.x86_64.rpm/download"  -O /tmp/VirtualGL-3.1.x86_64.rpm
RUN sudo dnf install /tmp/VirtualGL-3.1.x86_64.rpm -y
RUN wget "https://sourceforge.net/projects/turbovnc/files/3.0.3/turbovnc-3.0.3.x86_64.rpm/download" -O /tmp/turbovnc-3.0.3.x86_64.rpm
RUN sudo dnf install /tmp/turbovnc-3.0.3.x86_64.rpm -y

# install paraview for data visualization
RUN wget "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.1-MPI-Linux-Python3.9-x86_64.tar.gz" -O /tmp/paraview.tar.gz
RUN sudo tar -xvzf /tmp/paraview.tar.gz -C /opt
RUN sudo ln -s /opt/ParaView-5.11.1-MPI-Linux-Python3.9-x86_64/bin/paraview /usr/bin/paraview
