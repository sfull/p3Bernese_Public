#!/bin/bash

## This script assumes the pre-isntall script has been run successfully.
## In particular, that the p3Bernese_Public repo is available in ~/temp

# Prepare for installation
b54_p3repo=p3Bernese_Public/B54/installation


# Hatanaka RINEX Tools (RNXCMP)
cd ~
mkdir TOOLS
cd TOOLS
wget https://terras.gsi.go.jp/ja/crx2rnx/RNXCMP_4.1.0_Linux_x86_64bit.tar.gz
tar -xvzf RNXCMP_4.1.0_Linux_x86_64bit.tar.gz
rm RNXCMP_4.1.0_Linux_x86_64bit.tar.gz
mv RNXCMP_4.1.0_Linux_x86_64bit RNXCMP
cd ~

# JPL Ephemeris Model (DE421.EPH)
cp ~/temp/$b54_p3repo/MODEL/DE421.EPH $C/GLOBAL/MODEL

# Install lftp so we can use FTP to update Bernese s/ware.
sudo dnf install -y lftp

# Update Bernese CONFIG folder using FTP
cd $C/GLOBAL/CONFIG
lftp ftp.aiub.unibe.ch <<EOF
set xfer:clobber true
cd BSWUSER54/CONFIG
mget *
bye
EOF

# Update Bernese $D/REF52 folder using FTP
cd $D/REF54
lftp ftp.aiub.unibe.ch <<EOF
set xfer:clobber true
cd BSWUSER54/REF
mget *
bye
EOF

# Copy the Bernese 5.4 profile script to the relevant directory
sudo cp ~/temp/${b54_p3repo}/profile.d/bern54.sh /etc/profile.d

## s3fs-fuse installation
## If you wish to use s3fs-fuse to link your instance to
## your Amazon S3 buckets then uncomment the fillowing lines.
# Packages required for s3fs-fuse ()
sudo dnf install -y fuse.x86_64
sudo dnf install -y fuse-devel.x86_64
sudo dnf install -y openssl-devel.x86_64
sudo dnf install -y libcurl-devel.x86_64
sudo dnf install -y libxml2-devel.x86_64

# Clone, configure, and build s3fs-fuse
cd ~/temp
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install
cd ~

# Note: To use s3fs-fuse you will need to cnfigure the
# AWS CLI tools. Simply type "aws configure" and enter the
# requested information.

## XWindows (Bernese GUI)
## If you wish to use the Bernese GUI via XWindows then you'll need
## to uncomment the following lines
# Packages for using XWindows via Xming
sudo dnf install -y xorg*