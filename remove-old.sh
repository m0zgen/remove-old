#!/bin/sh

# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz
# ./remove-old.sh /var/log 90
# v2

PATH=$1

# if day empty
if [[ -z $2 ]]; then
    OLD=""
else
    OLD="-mtime +$2"
fi

# delete empty directories
del_empty_dir(){
    /usr/bin/find $PATH -empty -type d -delete >/dev/null 2>&1
    # echo Empty folders removed!
}

# delete empty files
del_empty_files(){
    /usr/bin/find $PATH -empty -type f -delete >/dev/null 2>&1
    # echo Empty files removed!
}

# try delete all
del(){
    /usr/bin/find $PATH $OLD -exec /usr/bin/rm -rf '{}' \; >/dev/null 2>&1
}

del
del_empty_files
del_empty_dir