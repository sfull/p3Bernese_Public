## Setup Bernese 5.2 Environment

# Setup QT path variables
export QTDIR="/etc/lib64/qt4"
export QMAKESPEC="linux-g++-64"

# Load Bernese 5.2 Environment variables ($X, $P, etc.)
. /home/ec2-user/BERN52/GPS/EXE/LOADGPS.setvar

# Adjust PATH to include various Bernese tools
PATH=$PATH:/home/ec2-user/BERN52/GPS/EXE/RNXCMP

