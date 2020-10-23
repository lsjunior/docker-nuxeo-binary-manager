#!/bin/bash

#!/bin/bash

ERR=0

if [ "$SRC" == "" ]
then
  echo "\$SRC must be defined"
  ERR=1
fi

if [ ! -d $SRC ]
then
  echo "$SRC must be a directory"
  ERR=1
fi

if [ "$DST" == "" ]
then
  echo "\$DST must be defined"
  ERR=1
fi

if [ ! -d $DST ]
then
  echo "$DST must be a directory"
  ERR=1
fi

ls $SRC > /tmp/tar-file.list
tar -C $SRC -czvf $DST -T /tmp/tar-file.list
