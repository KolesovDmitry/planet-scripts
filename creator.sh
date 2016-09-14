#!/bin/sh

FILE=$1
PARENT_ID=$2
CREDENTIALS=$3
NEXTGIS_URL=$4

NAME=$(basename $FILE .tif)
SOURCE=$(curl --user "$CREDENTIALS" --upload-file "$FILE" $NEXTGIS_URL/api/component/file_upload/upload)


RAST=$(mktemp -u tmp_rast_XXXXXX)
STYLE=$(mktemp -u tmp_style_XXXXXX)

m4 -DRASTERNAME=$NAME -DRASTERSOURCE="$SOURCE" -DPARENTID=$PARENT_ID create_rast.template > $RAST

RASTER_RESULT=$(curl --user "$CREDENTIALS"  --data "@$RAST" $NEXTGIS_URL/api/resource/)
echo $RASTER_RESULT

RASTERID=$(echo $RASTER_RESULT | jq .id)
echo ID=$RASTERID

m4 -DSTYLEID="$RASTERID" -DSTYLENAME=$NAME create_style.template > $STYLE
STYLEID=$(curl --user "$CREDENTIALS"  --data "@$STYLE"  $NEXTGIS_URL/api/resource/)
echo $STYLEID

rm $RAST
rm $STYLE
