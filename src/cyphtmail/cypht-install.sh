#!/bin/bash

# this is where Cypht will be installed
DESTINATION="/usr/local/share/cypht"

# validate the destination directory
sudo test -r $DESTINATION -a -x $DESTINATION
if [ $? -ne 0 ]; then
    sudo mkdir $DESTINATION
fi

# create working directory
mkdir cypht-temp
cd cypht-temp

# grab latest code
wget https://github.com/jasonmunro/cypht/archive/master.zip

# unpack the archive
unzip master.zip

# run composer
cd cypht-master && composer install && cd ..

# create a vanilla ini file
cp cypht-master/hm3.sample.ini cypht-master/hm3.ini

# fix permissions and ownership
find cypht-master -type d -print | xargs chmod 755
find cypht-master -type f -print | xargs chmod 644
sudo chown -R root:root cypht-master

# copy to destination folder
sudo mv cypht-master/* $DESTINATION

# remove working directory
cd ..
sudo rm -rf cypht-temp