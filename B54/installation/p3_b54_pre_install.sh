#!/bin/bash

# Prepare for installation
b54_p3repo=p3Bernese_Public/B54/installation
qt4_install_dir=/usr/lib64/qt4
qt4_patches_dir=${b54_p3repo}/qt_patches


# Perform useful / required group installations
sudo dnf groupinstall -y 'Development Tools'
sudo dnf groupinstall -y 'AWS Tools'

# Clone P3 Bernese repo for additional installation files
cd ~
mkdir temp
cd temp
git clone https://github.com/sfull/p3Bernese_Public.git
cd ~

# Packages required for Qt4 building
sudo dnf install -y libX11-devel.x86_64
sudo dnf install -y libXext-devel.x86_64

# Download, extract, update, configure, and build Qt4
cd ~/temp
wget https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
tar -xvzf qt-everywhere-opensource-src-4.8.7.tar.gz
rm qt-everywhere-opensource-src-4.8.7.tar.gz
cd qt-everywhere-opensource-src-4.8.7

cp ~/temp/${qt4_patches_dir}/qglobal.h src/corelib/global/qglobal.h
cp ~/temp/${qt4_patches_dir}/messagemodel.cpp tools/linguist/linguist/messagemodel.cpp 
cp ~/temp/${qt4_patches_dir}/qmake.conf mkspecs/linux-g++-64/qmake.conf

./configure -release -opensource -static -platform linux-g++-64 -no-openssl -qt-zlib -no-gif -qt-libpng -qt-libmng -qt-libtiff -qt-libjpeg -nomake examples -nomake demos -nomake docs -nomake translations -prefix $qt4_install_dir
make
sudo make install

## Install Bernese now
echo ">> Pre-installation tasks complete."
echo ">> Proceed with installation of the Bernese software."
echo ">> Don't forget to run the post-installation script!