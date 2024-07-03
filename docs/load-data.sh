# Loading new data into the SDA archive

To load new data into the SDA archive, one can upload it (as a user) with eg `sda-cli upload`,
and then start the ingestion on the server using eg `sda-admin`. Alternatively, one can work only
on the server, using the `data_loader` container. The second approach is described in this document.

Run the following steps:
- upload the data to the server, somewhere under `~/ejprd/data`. Eg `~/ejprd/data/additionalbams`.
- open `~/ejprd/config/gdi-starter-kit/config/load_data.sh` and modify:
  - `DIR` at line 4. This should be set to where data is located. The folder `~/ejprd/data` wil
     be located under `/data` in the container. For the given example path above, use `/data/additionalbams`.
    Everything in the specified folder will be uploaded to the archive.
  - `OUTPATH` at line 5. This will work as a prefix / parent folder for the files in the archive.
  - `DATASETID` at line 7 may also be updated. If it is, remember to also add a corresponding resource in REMS.
  - the accession ID at line 26 should be updated, so that the IDs for the files will not overlap with previously used ones.
    Eg. `NEwBAM_%02d`. This will create the IDs `NEWBAM00`, `NEWBAM01`...
- Run `docker compose up data_loader`.
- Verify that the data is available by querying SDA download API:
```
# list datasets
curl -s -H "Authorization: Bearer $token" https://download.ejprd.nbis.se/metadata/datasets | jq .
# list files in a dataset
curl -s -H "Authorization: Bearer $token" "https://download.ejprd.nbis.se/metadata/datasets/<datasetID>/files" | jq .
```
