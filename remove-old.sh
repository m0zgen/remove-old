#!/bin/sh

# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz
# ./remove-old.sh /var/log 90
# v2

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# if day empty
if [[ -z $1 ]]; then
  echo "Error - Set destination. Example - ./remove-old.sh /var/log 90"
  exit 1
else
  DEST=$1
fi

# if day empty
if [[ -z $2 ]]; then
  echo "Error - Set oldest time in days. Example - ./remove-old.sh /var/log 90"
  exit 1
else
  OLD="$2"
fi

if [ -z $1 ] || [ -z $2 ] ; then
  echo "Please use script with example - ./remove-old.sh /var/log 90"
else
  DELETE_DAY_FILES=`/usr/bin/find $DEST -type f -mtime +$OLD`

  if [[ ! -z $DELETE_DAY_FILES ]]; then
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
	#find $DEST $OLD -exec rm -rf '{}' \; >/dev/null 2>&1
	find $DEST/* -mtime +$OLD -print0 | xargs -0 rm -rf 2>&1 >/dev/null
  }

  del
  del_empty_files
  del_empty_dir
fi

fi

exit


