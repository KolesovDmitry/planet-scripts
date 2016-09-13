# planet-scripts
Some scripts to search, download and import Planet.com data

## Workflow

1. Register in Planet.com, get user key, install `planet` package.
2. Define AOI region, import it in planet.com, get ID of the AOI region.
3. Find scenes: `search.sh USER_KEY AOI_ID BEGIN_DATE END_DATE CLOUDCOVER NADIR`
```
search.sh XXX  XXX 2016-05-31T21:00:00.000Z 2016-09-01T21:00:00.000Z 1 2 > scenes.geojson
```
4. Download scenes: `downloader.sh USER_KEY  METADATA_FILE PRODUCT RESULT_DIR`
```
downloader.sh XXX  scenes.geojson visual VIS
downloader.sh XXX  scenes.geojson analytic AN
```

## Scripts

### Search.sh
A simple wrapper around `planet` script. It allows searching of planet scenes.

## downloader.sh
This script downloads selected scenes from planet.com.


