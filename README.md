# EJP-RD - NBIS demo setup

## Running using docker-compose
### Common preparation
Create persistent docker networks that can be used to connect services:

```{sh}
docker network create ejprd-oidc
docker network create ejprd-public
docker network create ejprd-secure
```

### GDI Starter Kit services:
See documentation for [htsget](docs/htsget.md) and [storage and interfaces](docs/storage-and-interfaces.md).

### EJP-RD Services
See documentation for [FAIR Data Point and EJP-RD Beacon](docs/fair-in-a-box.md).

### Utilities
See documentation for [Jupyter Lab](docs/notebook.md).

## Status
This repo will contain
- Test data, created by the EJP-RD NBIS team
  - [ ] Variant data (VCF/BCF)
- Instructions on how to set up and test the different GDI components
  - [x] htsget
  - [ ] lsaai-mock
  - [ ] rems
  - [x] storage-and-interfaces
  - [ ] beacon-v2
  - [ ] containerized-computations
- and the (EJP-RD) components
  - [x] FDP (metadata, DCAT-AP)
  - [x] EJP-RD Beacon for CARE-SM data
  - [ ] SPARQL endpoint/ rdf store (data in CARE-SM model)
- Instructions on how to import the data to sda, beacon, and the rdf store.
- An example `containerized-computation` work flow, where
  - [ ] `beacon` and the `sparql` endpoints are used to find interesting data
  - [ ] `htsget` is used to retrieve the data
  - [ ] some computation is performed
  - [ ] the output is a link to the result

`htsget`, `beacon` and the sparql endpoint should be accessible from within the containerised compute environment to stage the data necessary for the analysis.

If needed, parts of this can be mocked.
