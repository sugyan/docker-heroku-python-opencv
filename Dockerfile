# Inherit from Heroku's python stack
FROM heroku/python

# Install OpenCV by https://github.com/jayrambhia/Install-OpenCV
RUN mkdir -p /app/.heroku/opencv /tmp/opencv
WORKDIR /tmp/opencv
RUN git clone https://github.com/jayrambhia/Install-OpenCV
WORKDIR Install-OpenCV/Ubuntu
# Modify install scripts...
RUN sed -i 's/sudo //g' *.sh
RUN sed -i 's/BUILD_NEW_PYTHON_SUPPORT=ON/BUILD_opencv_python2=ON -D PYTHON_INCLUDE_DIR=\/app\/.heroku\/python\/include\/python2.7/' opencv_install.sh
RUN sed -i 's/make install/make DESTDIR=\/app\/.heroku\/opencv install/' opencv_install.sh
# Install
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list
RUN apt-get update
RUN ./opencv_latest.sh
RUN echo "/app/.heroku/opencv/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf
RUN ldconfig
RUN ln /dev/null /dev/raw1394
