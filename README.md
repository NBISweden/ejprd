# EJP-RD - NBIS demo setup

This repo will contain
- Test data, created by the EJP-RD NBIS team
- Instructions on how to set up GDI components
  - htsget
  - lsaai-mock
  - storage-and-interfaces
  - beacon-v2
  - containerized-computation
- and the (EJP-RD) components
  - FDP (metadata, DCAT-AP)
  - SPARQL endpoint/ rdf store (data in CARE-SM model)
- Instructions on how to import the data to sda, beacon, and the rdf store.
- An example `containerized-computation` work flow, where
  - `beacon` and the `sparql` endpoints are used to find interesting data
  - `htsget` is used to retrieve the data
  - some computation is performed
  - the output is a link to the result

`htsget`, `beacon` and the sparql endpoint should be accessible from within the containerised compute environment to stage the data necessary for the analysis.

If needed, parts of this can be mocked.
