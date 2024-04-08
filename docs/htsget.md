> [!NOTE]
> to be updated when
> - htsget rust bug fix
> - starter-kit htsget repo updated?


1. Copy `config/docker-compose-demo.yml` of this repo to the root folder of
   `storage-and-interfaces` . Take down the containers  of that repo `docker
   compose -f docker-compose-demo.yml down -v --remove-orphans` if they were
   already running. (This step is to be removed when all branches, images etc
   are synced.)
1. Make sure you have the services in [storage-and-interfaces running](/docs/storage-and-interfaces.md).

1. Clone the repo https://github.com/GenomicDataInfrastructure/starter-kit-htsget.
1. Check out the branch `feature/rust-htsget`
1. Copy `config/download-config.toml` of this repo to the folder `config-htsget-rs` in `starter-kit-htsget`.
1. Run `docker compose up -d`



## Testing
Get the token from the auth service using
 ```sh
 token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')
 ```
Now you should be able  make the requests to the htsget server. To request the (byte range of) chromosome 11 of the file `htsnexus_test_NA12878.bam` run:
 ```sh
 curl -v -H "Authorization: Bearer $token" -H -k http://localhost:8088/reads/DATASET0001/htsnexus_test_NA12878?referenceName=11
 ```

 The request will return a ticket of how to download the requested partial file:
 ```
 {
  "htsget": {
    "format": "BAM",
    "urls": [
        {
        "url": "http://localhost:8443/s3/DATASET0001/htsnexus_test_NA12878.bam",
        "headers": {
            "Range": "bytes=2596771-2596798",
            "authorization": "Bearer ..."
        ...
        }
    ]
  }
 }
```

This should allow you to compose the following request to `sda-download` (from `storage-and-interfaces`) that gets you chromosome 11 of the file:
```
curl http://localhost:8443/s3/DATASET0001/htsnexus_test_NA12878.bam -H "Authorization: Bearer $token" -H "Range: bytes=2596771-2596798" -o part11.bam
```

Check that samtools can open the new file: `samtools view part11.bam`
