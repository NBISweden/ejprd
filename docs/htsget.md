> [!NOTE]
> to be updated when
> - branches are merged, images have final names

## Setting up
1. Make sure you have the services in [storage-and-interfaces running](/docs/storage-and-interfaces.md). You might have 
   restart all services.
1. Clone the repo https://github.com/GenomicDataInfrastructure/starter-kit-htsget.
1. Check out the branch `feature/rust-htsget`
1. Run `docker compose up -d`



## Testing
Get the token from the auth service using
 ```sh
 token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')
 ```

Read your public key. This will be used for (re-)encrypting the file before it's sent to you.
```
pubkey=$(base64 -w0 keys/c4gh.pub.pem)
```

Now you should be able  make the requests to the htsget server. To request the (byte range of) chromosome 11 of the file `htsnexus_test_NA12878.bam` run:
 ```sh
 curl -v -H "Client-Public-Key: $pubkey" -H "Authorization: Bearer $token" -H -k http://localhost:8088/reads/DATASET0001/htsnexus_test_NA12878?referenceName=11
 ```

 The request will return a ticket of how to download the requested partial file:
 ```sh
{
  "htsget": {
    "format": "BAM",
    "urls": [
      {
        "url": "data:;base64,Y3J5cHQ0Z2gBAAAAAgAAAA=="
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam.c4gh",
        "headers": {
          "Range": "bytes=16-123",
          ...
        }
      },
      {
        "url": "data:;base64,ZAAAAAAAAACxHxjMhagEVY+4bVEZYuqYGK5Ph3jrffrMhXpc3wYWenp2ofohEUwSBOuZF3kH6TEiQsjSPGaE1bvdMQ2uUuuHLWicplUneE77G079sTW8rJIJJ1VgZecPi9cTfQ=="
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam.c4gh",
        "headers": {
          "Range": "bytes=124-1049147",
          ...
        }
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam.c4gh",
        "headers": {
          "Range": "bytes=2557120-2598042",
          "accept": "*/*",
          ...
      }
    ]
  }
}
```

This repsonse contains byte ranges (eg. `"Range": "bytes=124-1049147"`) as parts of url requests.
This should point you to doing requests to `http://localhost:8443/s3-encrypted` (`sda-download`, from `storage-and-interfaces`) that gets you data for chromosome 11 of the file:
```sh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam' -H "Authorization: Bearer $token"  -H "Server-Public-Key: $pubkey" -H "Range: bytes=16-123" -o p11-00.bam.c4gh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam' -H "Authorization: Bearer $token"  -H "Server-Public-Key: $pubkey" -H "Range: bytes=124-1049147" -o p11-01.bam.c4gh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/htsnexus_test_NA12878.bam' -H "Authorization: Bearer $token"  -H "Server-Public-Key: $pubkey" -H "Range: bytes=2557120-2598042" -o p11-02.bam.c4gh
```

The response from hstget also lists two data sections:
```sh
"url": "data:;base64,Y3J5cHQ0Z2gBAAAAAgAAAA=="
```
and
```sh
"url": "data:;base64,ZAAAAAAAAACxHxjMhagEVY+4bVEZYuqYGK5Ph3jrffrMhXpc3wYWenp2ofohEUwSBOuZF3kH6TEiQsjSPGaE1bvdMQ2uUuuHLWicplUneE77G079sTW8rJIJJ1VgZecPi9cTfQ==
```
These segments are part of the requested data. Save the data (eg. `Y3J5cHQ0Z2gBAAAAAgAAAA==`) to files, `start.b64` and `mid.64`, respectively. Then concatenate all segments:
```sh
{ <start.b64 base64 --decode  && cat p11-00.bam.c4gh && <mid.b64 base64 --decode && cat p11-01.bam.c4gh && cat p11-02.bam.c4gh ;} > htsnexus_11.bam.c4gh 
```
Make sure that the file can be decrypted with your private key:
```sh
crypt4gh decrypt --sk keys/c4gh.sec.pem < htsnexus_11.bam.c4gh > htsnexus_11.bam
```

Finally, check that samtools can open the new file:
```sh
samtools view htsnexus11.bam
```
