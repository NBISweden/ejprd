set -e
apk -q --no-cache add curl jq

DIR="/data/EGAD00001008392/region_vcfs/"
OUTPATH="region_vcfs"
# Keep datasetid and uploader unchanged to match dummy visas from demo oidc
DATASETID="DATASET0001"
UPLOADER="dummy_gdi.eu"
export SDA_CLI=/sda-cli
export SDA_KEY=/shared/c4gh.pub.pem
export MQ_URL=http://rabbitmq:15672
export SDA_CONFIG=/shared/s3cfg

mkdir -p $OUTPATH
# make sure no unwanted data is uploaded
rm -rf $OUTPATH/*
cp -r $DIR/* $OUTPATH

echo "uploading files..."
./sda-admin --user $UPLOADER upload $OUTPATH

echo "ingesting files..."
./sda-admin --user $UPLOADER ingest  $OUTPATH/
sleep 5
echo "accession..."
./sda-admin --user $UPLOADER accession 'FILE_%02d' 1 $OUTPATH/
sleep 2
echo "linking to dataset..."
./sda-admin --user $UPLOADER dataset $DATASETID $OUTPATH/
sleep 2

rm -rf $OUTPATH
