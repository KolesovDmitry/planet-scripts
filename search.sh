#!/bin/sh

USER_KEY=$1
AOI_ID=$2
BEGIN_DATE=$3
END_DATE=$4
CLOUD_COVER=$5
NADIR=$6

planet -k $USER_KEY search \
--aoi_id $AOI_ID \
-s ortho \
--where image_statistics_image_quality gte target \
--where acquired gte "$BEGIN_DATE" \
--where acquired lte "$END_DATE" \
--where cloud_cover.estimated lte $CLOUD_COVER \
--where image_statistics.gsd gte 1 \
--where image_statistics.gsd lte 30 \
--where sat.off_nadir lte $NADIR
