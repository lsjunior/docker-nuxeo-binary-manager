#!/bin/bash

ERR=0

if [ "$INPUT" == "" ]
then
  echo "\$INPUT must be defined"
  ERR=1
fi

if [ ! -f $INPUT ]
then
  echo "$INPUT must a file"
  ERR=1
fi

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

if [ $ERR -eq 0 ]
then
  echo "Running"
  for HASH in `cat $INPUT`
  do
    DIR1=${HASH:0:2}
    DIR2=${HASH:2:2}
    FILE=$SRC/$DIR1/$DIR2/$HASH
    if [ -f $FILE ]
    then
      rm -f $FILE
      if [ $? -eq 0 ]
      then
        echo "OK removing $FILE"
      else
        echo "ERROR cannot remove file $FILE"
      fi
    else
      echo "OK not found $FILE"
    fi
  done
fi
