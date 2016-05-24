#!/bin/sh

# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz
# ./remove-old.sh /var/log/* 90
# v2

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# ------------------------------------------ LOGS
LOGFILE="/var/log/remove-old.log"

# check log file
if [[ ! -e $LOGFILE ]]; then
  touch $LOGFILE
elif [[ ! -d $LOGFILE ]]; then
  echo "$(date +%Y%m%d+%H:%M:%S) : Start remove" >> $LOGFILE
fi
# ------------------------------------------ LOGS

# arguments is empty
if [ -z $1 ] || [ -z $2 ] ; then
  echo "Please use script with example - ./remove-old.sh /var/log/* 90"
else

  DEST=$1
  OLD=$2
  DELETE_DAY_FILES=`/usr/bin/find $DEST -type f -mtime +$OLD`

  if [[ ! -z $DELETE_DAY_FILES ]]; then
    echo "$DELETE_DAY_FILES" >> $LOGFILE

    # delete empty and hidden directories
    del_empty_dir(){
      find $DEST -empty -type d -delete >/dev/null 2>&1
      find $DEST -type d -name ".*" -exec rm -rf '{}' \; >/dev/null 2>&1
    # echo Empty folders removed!
    }

    # delete empty and hidden files
    del_empty_files(){
      find $DEST -empty -type f -delete >/dev/null 2>&1
      find $DEST -type f -name ".*" -exec rm -rf '{}' \; >/dev/null 2>&1
    # echo Empty files removed!
    }

    # try delete all
    del(){
    # find $DEST $OLD -exec rm -rf '{}' \; >/dev/null 2>&1
    # find $DEST/* -mtime +$OLD -print0 | xargs -0 rm -rf 2>&1 >/dev/null
    find $DEST -mtime +$OLD -print0 | xargs -0 rm -rf 2>&1 >/dev/null
    }

    del
    del_empty_files
    del_empty_dir

  fi

fi

echo "$(date +%Y%m%d+%H:%M:%S) : Finished" >> $LOGFILE
exit

