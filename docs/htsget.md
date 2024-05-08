## Setting up from GDI Starter kit source
1. Make sure you have the services in [storage-and-interfaces running](/docs/storage-and-interfaces.md). You might have 
   restart all services.
1. Clone the repo https://github.com/GenomicDataInfrastructure/starter-kit-htsget.
1. Check out the hash `5b79a7cb6b1d33e3644089b90c62e161a8afc35a` (`git checkout 5b79a7cb6b1d33e3644089b90c62e161a8afc35a`)
1. Run `docker compose up -d`

## Setting up using git submodules of this repository
1. Update submodules (`git submodule update`)
1. To start the stack:
   ```sh
   docker compose --project-directory config/gdi-starter-kit up -d
   ```

## Testing
Get the token from the auth service using
 ```sh
 token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')
 ```

Read your public key. This will be used for (re-)encrypting the file before it's sent to you.
```
pubkey=$(base64 -w0 keys/c4gh.pub.pem)
# macOS: pubkey=$(base64 -i keys/c4gh.pub.pem)
```

Now you should be able  make the requests to the htsget server. To request the (byte range of) chromosome 19 of the file `Case7_IC.reg.vcf` run:
 ```sh
 curl -v -H "Client-Public-Key: $pubkey" -H "Authorization: Bearer $token" -H -k "http://localhost:8088/variants/DATASET0001/region_vcfs/Case7_IC.reg?referenceName=19&start=39955351"
 ```


 The request will return a ticket of how to download the requested partial file:
 ```sh
 {
  "htsget": {
    "format": "VCF",
    "urls": [
      {
        "url": "data:;base64,Y3J5cHQ0Z2gBAAAAAgAAAA=="
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh",
        "headers": {
          "Range": "bytes=16-123",
          ...
        }
      },
      {
        "url": "data:;base64,bAAAAAAAAAAOeAPEBUbfTcA0rho6fMu3D47GsC31V7Vd88JS4Wr2cvHhRpFHyQ20CE1+iIuMog/y8CtkrMLdEGIvzjUtuBj7K+/ZUcZS9FkSLYeMGQLUnqCmNL9DYXGUW7SGvbVSd/YU0V16"
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh",
        "headers": {
          "Range": "bytes=124-65687",
          ...
        }
      },
      {
        "url": "http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh",
        "headers": {
          "Range": "bytes=131252-151945",
          ...
          }
       }
    ]
  }
}
```

This repsonse contains byte ranges (eg. `"Range": "bytes=124-65687"`) as parts of url requests.
This should point you to doing requests to `http://localhost:8443/s3-encrypted` (`sda-download`, from `storage-and-interfaces`) that gets you data for chromosome 19 of the file:
```sh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh' -H "Authorization: Bearer $token"  -H "Client-Public-Key: $pubkey" -H "Range: bytes=16-123" -o p19-00.vcf.gz.c4gh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh' -H "Authorization: Bearer $token"  -H "Client-Public-Key: $pubkey" -H "Range: bytes=124-bytes=124-65687" -o p19-01.vcf.gz.c4gh
curl 'http://localhost:8443/s3-encrypted/DATASET0001/region_vcfs/Case7_IC.reg.vcf.gz.c4gh' -H "Authorization: Bearer $token"  -H "Client-Public-Key: $pubkey" -H "Range: bytes=131252-151945" -o p19-02.vcf.gz.c4gh
```

The response from hstget also lists two data sections:
```sh
"url": "data:;base64,Y3J5cHQ0Z2gBAAAAAgAAAA=="
```
and
```sh
"url": "data:;base64,bAAAAAAAAAAOeAPEBUbfTcA0rho6fMu3D47GsC31V7Vd88JS4Wr2cvHhRpFHyQ20CE1+iIuMog/y8CtkrMLdEGIvzjUtuBj7K+/ZUcZS9FkSLYeMGQLUnqCmNL9DYXGUW7SGvbVSd/YU0V16"
```
These segments are part of the requested data. Save the data (eg. `Y3J5cHQ0Z2gBAAAAAgAAAA==`) to files, `start.b64` and `mid.b64`, respectively. Then concatenate all segments:
```sh
{ <start.b64 base64 --decode  && cat p19-00.vcf.gz.c4gh && <mid.b64 base64 --decode  && cat p19-01.vcf.gz.c4gh && cat p19-02.vcf.gz.c4gh  ;} > case7.vcf.gz.c4gh
```
Make sure that the file can be decrypted with your private key:
```sh
crypt4gh decrypt -s keys/c4gh.sec.pem -f case7.vcf.gz.c4gh
```
TODO: interesting/good way to verify that the vcf file is ok?
