#!/bin/bash

sudo apt install subversion \
     autoconf2.13 \
     autotools-dev \
     bison \
     flex \
     graphviz \
     libblas-dev \
     libbz2-dev \
     libcairo2-dev \
     libfftw3-dev \
     libfreetype6-dev \
     libgdal-dev \
     libgeos-dev \
     libglu1-mesa-dev \
     libjpeg-dev \
     liblapack-dev \
     libmotif-dev \
     libmysqlclient-dev \
     libncurses5-dev \
     libnetcdf-dev \
     libpng-dev \
     libpq-dev \
     libproj-dev \
     libreadline-dev \
     libsqlite3-dev \
     libtiff-dev \
     libwxgtk3.0-dev \
     libxmu-dev \
     netcdf-bin \
     python-dev \
     unixodbc-dev \
     zlib1g-dev \

function configure_grass {
    ./configure \
        --prefix=/usr/local \
        --enable-largefile \
        --enable-socket \
        --enable-shared \
        --with-blas \
        --with-bzlib \
        --with-cairo \
        --with-cxx \
        --with-freetype \
        --with-freetype-includes=/usr/include/freetype2 \
        --with-gdal \
        --with-geos \
        --with-lapack \
        --with-motif \
        --with-mysql \
        --with-mysql-includes=$(mysql_config --include | sed -e 's/-I//') \
        --with-netcdf \
        --with-nls \
        --with-odbc \
        --with-postgres \
        --with-postgres-includes=$(pg_config --includedir) \
        --with-proj-share=/usr/share/proj \
        --with-python \
        --with-readline \
        --with-sqlite \
        --with-wxwidgets=/usr/bin/wx-config \
        --with-x \
        --with-liblas \
        --with-openmp
}

# GRASS 7.4
mkdir /opt/src -p
cd /opt/src

if [  ! -f grass-7.4.1.tar.gz ] ; then
	 wget https://grass.osgeo.org/grass74/source/grass-7.4.1.tar.gz
fi
tar xvzf grass-7.4.1.tar.gz
cd grass-7.4.1
make distclean
configure_grass
make
sudo make install
cd ..
rm -rf grass-7.4.1

exit 0