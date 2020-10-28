#!/bin/bash

ERR=0

if [ "$INPUT" == "" ]
then
  echo "\$INPUT must be defined"
  ERR=1
fi

INPUT_TO_USE="$INPUT"

if [ ! -f $INPUT ]
then
  if [ ${INPUT:0:4} == "http" ]
  then
    curl $INPUT --output /tmp/input.txt
    if [ $? -eq 0 ]
    then
      INPUT_TO_USE="/tmp/input.txt"
    else
      echo "$INPUT cannot be downloaded"
      ERR=1
    fi
  else
    echo "$INPUT must a file or URL"
    ERR=1
  fi
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
  for HASH in `cat $INPUT_TO_USE`
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
