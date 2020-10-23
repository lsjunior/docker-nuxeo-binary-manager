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

if [ "$DST" == "" ]
then
  echo "\$DST must be defined"
  ERR=1
fi

if [ ! -d $DST ]
then
  mkdir -p $DST
  if [ $? -ne 0]
  then
    echo "$DST must be a directory"
    ERR=1
  fi
fi

if [ $ERR -eq 0 ]
then
  echo "Running"
  for HASH in `cat $INPUT`
  do
    DIR1=${HASH:0:2}
    DIR2=${HASH:2:2}
    FILE=$SRC/$DIR1/$DIR2/$HASH
    TARGET=$DST/$DIR1/$DIR2
    if [ -f $FILE ]
    then
      mkdir -p $TARGET
      if [ $? -eq 0 ]
      then
        mv $FILE $TARGET
        if [ $? -eq 0 ]
        then
          echo "OK moved $FILE to $TARGET"
        else
          echo "ERROR moving $FILE to $TARGET"
        fi
      else
        echo "ERROR cannot create dir $TARGET"
      fi
    else
      echo "ERROR file not found $FILE"
    fi
  done
fi
