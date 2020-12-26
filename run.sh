#!/bin/bash

STATION_ID=$1
MINUTE=$2
PREFIX=$3

echo "start STATION_ID:$STATION_ID, MINUTE:$MINUTE, PREFIX:$PREFIX"

# see https://github.com/uru2/radish
./radi.sh -t radiko -s $STATION_ID -d $MINUTE -o /var/out
if [ ! -s out.m4a ]; then
  echo "not exits out.m4a"
  exit 1
fi

# send to S3
if [ -z $PREFIX ]; then
  PREFIX=$STATION_ID
fi
ymd=`date +%Y%m%d`
ymdhms=`date +%Y%m%d%H%M%S`
key="$ymd/${PREFIX}_${ymdhms}.m4a"

echo "s3 key: $key"

aws s3 cp --no-progress out.m4a s3://$BucketName/$key
if [ $? -ne 0 ];then
  echo "failed to upload"
  exit 1
fi

echo "Done"

