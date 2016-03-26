#!/bin/sh

# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz
# ./remove-old.sh /var/log 90
# v2

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

DEST=$1

# if day empty
if [[ -z $2 ]]; then
    OLD=""
else
    OLD="-mtime +$2"
fi

# delete empty directories
del_empty_dir(){
    find $DEST -empty -type d -delete >/dev/null 2>&1
    # echo Empty folders removed!
}

# delete empty files
del_empty_files(){
    find $DEST -empty -type f -delete >/dev/null 2>&1
    # echo Empty files removed!
}

# try delete all
del(){
    find $DEST $OLD -exec rm -rf '{}' \; >/dev/null 2>&1
}

del
del_empty_files
del_empty_dir