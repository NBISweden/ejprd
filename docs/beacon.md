# Beacon v2

1. (First time only:) Run `git submodule init`
1. Run `git submodule update --remote` to checkout the beaconized data
1. Start beacon: `docker compose up`
1. (First time only: ) Run:
   ```
   docker compose exec beacon python /beacon/beacon/reindex.py
   docker compose exec python beacon/db/extract_filtering_terms.py
   docker compose exec python beacon/db/get_descendants.py
   ```
1. Beacon should be running at port 5050, try it `curl localhost:5050/api | jq .` Check that the `response.name` is set to a suitable name.
1. Try to search for a specific variant:
```
curl 'http://localhost:5051/api/g_variants?referenceName=19&start=39062814&end=39062815&referenceBases=G&alternateBases=C' | jq .
```
  This should list 5 variants.
