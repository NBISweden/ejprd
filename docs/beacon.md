# Beacon v2

1. (First time only:) Run `git submodule init`
1. Run `git submodule update --remote` to checkout the beaconized data
1. Start beacon: `docker compose up`
1. (First time only: )Run: `config/beacon_db_load.sh` to load all data to the db
1. Beacon should be running at port 5050, try it `curl localhost:5050/api | jq .`
1. Try to search for a specific variant:
```
curl 'https://beacon.gdi.elixir-greece.org/api/g_variants?referenceName=22&start=16050114&end=16050115&referenceBases=A&alternateBases=G' | jq .
```
