#!/bin/sh

# Use argument for remove old files. Example: ./remove-old.sh path howold
# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz

PATH=$1
OLD=$2

#/usr/bin/find $PATH -type f -mtime +OLD -exec rm {} \; 2>/dev/null
/usr/bin/find $PATH -type f -mtime +$OLD -exec /usr/bin/rm '{}' \;
echo $PATH
#/usr/bin/find /mnt/dta3/tmp -type f -mtime +91 -exec /usr/bin/rm -rf '{}' \;
