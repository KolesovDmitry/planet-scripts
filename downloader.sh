#!/bin/sh

USER_KEY=$1
JSON_FILE=$2
PRODUCT=$3
RES_DIR=$4

URLS=$(mktemp -u tmp_cert_XXXXXX)
NAMES_FILE=$(mktemp -u tmp_names_XXXXXX)
CURL_TMP_FILE=$(mktemp -u tmp_culr1_XXXXXX)
CURL_FILE=$(mktemp -u tmp_culr2_XXXXXX)


cat $JSON_FILE | jq .features[].properties.data.products.${PRODUCT}[] | sort > $URLS
cat $URLS | cut -d"/" -f7 > $NAMES_FILE
paste -d">" $URLS $NAMES_FILE > $CURL_TMP_FILE


cat $CURL_TMP_FILE | sed -e "s/^/curl -L -u \"${USER_KEY}:\" /g" -e 's/$/.tif/g' > $CURL_FILE
sh $CURL_FILE

mkdir $RES_DIR
mv *tif $RES_DIR/

rm $URLS
rm $NAMES_FILE
rm $CURL_TMP_FILE
rm $CURL_FILE
