docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/datasets.json --collection datasets
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/analyses.json --collection analyses
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/biosamples.json --collection biosamples
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/cohorts.json --collection cohorts
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/individuals.json --collection individuals
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/runs.json --collection runs

docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations1_IC.json --collection genomicVariations
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations1_trio.json --collection genomicVariations
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations6_IC.json --collection genomicVariations
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations7_IC.json --collection genomicVariations
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations8_IC.json --collection genomicVariations
docker compose exec db mongoimport --jsonArray --uri "mongodb://root:example@127.0.0.1:27017/beacon?authSource=admin" --file /docker-entrypoint-initdb.d/genomicVariations9_IC.json --collection genomicVariations

docker compose exec beacon python beacon/reindex.py
docker compose exec beacon python beacon/db/extract_filtering_terms.py
docker compose exec beacon python beacon/db/get_descendants.py
