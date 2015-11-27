# Inherit from Heroku's python stack
FROM heroku/python

# Install OpenCV by https://github.com/jayrambhia/Install-OpenCV
ENV DESTDIR /app/.heroku/opencv
RUN mkdir -p $DESTDIR /tmp/opencv
WORKDIR /tmp/opencv
RUN git clone https://github.com/jayrambhia/Install-OpenCV
WORKDIR Install-OpenCV/Ubuntu
# Modify install scripts...
RUN sed -i 's/sudo //g' *.sh
RUN sed -i 's/BUILD_NEW_PYTHON_SUPPORT/BUILD_opencv_python2/' opencv_install.sh
RUN sed -i 's/make install/make DESTDIR=$DESTDIR install/' opencv_install.sh
# Install
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list
RUN apt-get update
RUN ./opencv_latest.sh
