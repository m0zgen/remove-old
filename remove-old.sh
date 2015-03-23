#!/bin/sh

# Use argument for remove old files. Example: ./remove-old.sh path howold
# ./remove-old.sh /var/log 90
# ./remove-old.sh /mnt/dta3/tmp/ 10 --delemptydir
# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz

PATH=$1
OLD=$2
TYPE=$3

# Send errors to null ) Test
#/usr/bin/find $PATH -type f -mtime +OLD -exec rm {} \; 2>/dev/null

#/usr/bin/find $PATH -type f -mtime +$OLD -exec /usr/bin/rm '{}' \;
#/usr/bin/find $PATH -type d -mtime +$OLD -exec /usr/bin/rm -rf '{}' \;

# for i in `/usr/bin/find $PATH -maxdepth 1 -type f -mtime +$OLD -print`; do 
for i in `/usr/bin/find $PATH -type f -mtime +$OLD -print`; do 
    echo -e "Deleting directory $i";
    /usr/bin/rm -rf $i; 
done

del_empty_dir(){
    `/usr/bin/find $PATH -empty -type d -delete`
    echo Empty folders removed!
}

del_empty_files(){
    `/usr/bin/find $PATH -empty -type f -delete`
    echo Empty files removed!
}

for i in "$@" ; do

    if [[ $i == "--delemptydir" ]] ; then
        del_empty_dir
        break
    fi

if [[ $i == "--delemptyfile" ]] ; then
        del_empty_files
        break
    fi

done
