set -e
apk -q --no-cache add curl jq

FILES="/data/EGAD00001008392/region_vcfs/*"
OUTPATH="region_vcfs"
# Keep datasetid and uploader unchanged to match dummy visas from demo oidc
DATASETID="DATASET0001"
UPLOADER="dummy_gdi.eu"
export SDA_CLI=/sda-cli
export SDA_KEY=/shared/c4gh.pub.pem
export MQ_URL=http://rabbitmq:15672
export SDA_CONFIG=/shared/s3cfg

echo "uploading files..."
for file in ${FILES}; do
    echo "upload $file"
    ./sda-admin --user $UPLOADER upload -t $OUTPATH $file
done

echo "ingesting files..."
./sda-admin --user $UPLOADER ingest  $OUTPATH/
sleep 5
echo "accession..."
./sda-admin --user $UPLOADER accession 'FILE_%02d' 1 $OUTPATH/
sleep 2
echo "linking to dataset..."
./sda-admin --user $UPLOADER dataset $DATASETID $OUTPATH/
sleep 2
