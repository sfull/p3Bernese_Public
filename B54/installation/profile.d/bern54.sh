## Setup Bernese 5.2 Environment

 # Setup QT path variables
 export QTDIR="/usr/lib64/qt4/"
 export QMAKESPEC="linux-g++-64"

 # Load Bernese 5.4 Environment variables ($X, $P, etc.)
 . /home/ec2-user/BERN54/LOADGPS.setvar
 
 # Adjust PATH to include various Bernese tools
 PATH=$PATH:/home/ec2-user/TOOLS/RNXCMP/bin

## Mount the various drives required by Bernese and setup NFS
 
# # Mount the temp drive from ephemeral storage
# sudo mount /dev/xvdb /media/eph0
# if [ ! -d /media/eph0/GPSTEMP ]; then 
#   sudo mkdir -p /media/eph0/GPSTEMP
# fi 
# sudo chown ec2-user /media/eph0/GPSTEMP

 # Mount the EBS volume that has the BERN52 GPSDATA and GPSUSER52 folders
 #sudo mount /dev/nvme1n1 /media/ebs0

 # Mount the p3-clients S3 Bucket (acts as SAVEDISK)
 s3fs p3-clients /home/ec2-user/s3-p3-clients -o nonempty

 # Mount the igs-data S3 Bucket to the DATAPOOL 
 #s3fs igs-data /home/ec2-user/GPSDATA/DATAPOOL/IGS/DATA -o nonempty
