#!/bin/sh

# Use argument for remove old files. Example: ./remove-old.sh path howold
# ./remove-old.sh /var/log 90
# ./remove-old.sh /mnt/dta3/tmp/ 10 --delemptydir
# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz
# v2

PATH=$1

if [[ -z $2 ]]; then
    OLD=""
else
    OLD="-mtime +$2"
fi

#TYPE=$3

# Send errors to null ) Test
#/usr/bin/find $PATH -type f -mtime +OLD -exec rm {} \; 2>/dev/null

#/usr/bin/find $PATH -type f -mtime +$OLD -exec /usr/bin/rm '{}' \;
#/usr/bin/find $PATH -type d -mtime +$OLD -exec /usr/bin/rm -rf '{}' \;

# for i in `/usr/bin/find $PATH -maxdepth 1 -type f -mtime +$OLD -print`; do

# find /mnt/dta4/tmp/* -mtime +60 -print0 | xargs -0 rm -f

#for i in `/usr/bin/find $PATH -type f -mtime +$OLD -print`; do
#    echo -e "Deleting directory $i";
#    /usr/bin/rm -rf $i;
#done

del_empty_dir(){
    /usr/bin/find $PATH -empty -type d -delete >/dev/null 2>&1
    # echo Empty folders removed!
}

del_empty_files(){
    /usr/bin/find $PATH -empty -type f -delete >/dev/null 2>&1
    # echo Empty files removed!
}

# for i in "$@" ; do

#     if [[ $i == "--delemptydir" ]] ; then
#         del_empty_dir
#         break
#     fi

# if [[ $i == "--delemptyfile" ]] ; then
#         del_empty_files
#         break
#     fi

# done

/usr/bin/find $PATH $OLD -exec /usr/bin/rm -rf '{}' \; >/dev/null 2>&1

del_empty_files
del_empty_dir