FROM jackm97/cuda-x11-docker:latest

#install matplot++ dependencies
RUN dnf install gnuplot qt5-qtsvg qt5-qtbase -y

#install extra tools
RUN dnf install python39 librevenge-gdb git clang-tools-extra perf -y
