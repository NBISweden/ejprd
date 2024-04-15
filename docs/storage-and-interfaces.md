> [!NOTE]
> In large parts copied from [the storage-and-interfaces repo](https://github.com/GenomicDataInfrastructure/starter-kit-storage-and-interfaces/blob/86d971294eb371189331c4898befe6dca8604b4b/README.md)
To be updated and specialized for the ejprd use case.
# Set up starter-kit-storage-and-interfaces in demo mode

1. Download the repo https://github.com/GenomicDataInfrastructure/starter-kit-storage-and-interfaces/
1. Go into the repo's root folder `cd starter-kit-storage-and-interfaces`.
1. Check out branch `feat/htsget-crypt4gh`.

1. To start the stack:
```shell
docker compose -f docker-compose-demo.yml up -d
```

The services will run in demo mode, with a mock-oidc in place of LS-AAI.
Test data is loaded, loaded from here  https://github.com/ga4gh/htsget-refserver/tree/main/data/gcp/gatk-test-data/wgs_bam.

After deployment is done, follow the instructions below to test that the demo worked as expected.
In order to restart the services, first take everything down and remove the volumes using
```
docker compose -f docker-compose-demo.yml down -v --remove-orphans
```
### **Download unencrypted files directly**

#### Get token for downloading data

For the purpose of the demo stack, tokens can be issued by the included `oidc`
service and be used to authorize calls to the `download` service's API. The
`oidc` is a simple Python implementation that mimics the basic OIDC
functionality of LS-AAI. It does not require user authentication and serves a
valid token through its `/token` endpoint:

```shell
token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')
```

#### List datasets

```shell
curl -s -H "Authorization: Bearer $token" http://localhost:8443/metadata/datasets | jq .
```

#### List files in a dataset

```shell
datasetID=$(curl -s -H "Authorization: Bearer $token" http://localhost:8443/metadata/datasets | jq -r .'[0]')
curl -s -H "Authorization: Bearer $token" "http://localhost:8443/metadata/datasets/$datasetID/files" | jq .
```

#### Download a specific file

```shell
fileID=$(curl -s -H "Authorization: Bearer $token" "http://localhost:8443/metadata/datasets/$datasetID/files" | jq -r '.[0].fileId')
filename=$(curl -s -H "Authorization: Bearer $token" "http://localhost:8443/metadata/datasets/$datasetID/files" | jq -r '.[0].displayFileName' | cut -d '.' -f 1,2 )
curl -s -H "Authorization: Bearer $token" http://localhost:8443/files/$fileID -o "$filename"
```
Check that the file `$filename` (`htsnexus_test_NA12878.bam`) has been created, and that it contains (binary) data.
