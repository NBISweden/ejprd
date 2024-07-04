# Rems
See [`docs/rems.md`](rems.md) as well as the configuration files on the server.

# FDP
The FDP runs under `ejprd/` at the server. One can use [the GUI](https://fdp.ejprd.nbis.se) to add/remove users.

# SDA
The SDA pipeline runs under `ejprd/` at the server. The configuration files (`.env`,
`starter-kit-storage-and-interfaces/config/config.yaml`, `starter-kit-storage-and-interfaces/config/iss.json`),
as well as the docker files
(`starter-kit-storage-and-interfaces/docker-compose.yml`,
`starter-kit-storage-and-interfaces/docker-compose-demo.yml`) has been updated on the server.
Since these files include credentials, they are not commited.
The files `config/gdi-starter-kit/config/iss.json` and
`config/gdi-starter-kit/config/storage-config.yml` could be used as templates
to create new configuration files.

## Auth
To be able to login with LS-AAI, we run the SDA application `auth`. Thus, the `docker-compose-demo.yml` in
`starter-kit-storage-and-interfaces/` have been modified to include this section:
```
auth:
  extends:
    file: docker-compose.yml
    service: auth
 ```

## Credentials
If passwords for the SDA components are changed in the `.env` file or `config.yaml`,
the script `make_credentials.sh` in
`starter-kit-storage-and-interfaces/scripts` might need to be updated
accordingly.



# NGINX
NGINX is used as proxy server, it runs under `ejprd/` at the server.
See the documentation [`config/nginx/README.md`](/config/nginx/README.md).


## Password protection
Parts of the webpage can be password protected by nginx. See the section
for Containerized Computation (`cc.ejprd.nbis.se`) in `nginx.conf` for an example.

## Loading data

To upload more data to the archive, see [load-data.md](load-data.md).

## Relevant things to test

- Login at https://login.ejprd.nbis.se and copy the access token. You will need this
  for communication with the services.
  - _NB. The login service is slow. After clicking, you will have to wait before anything happens._
  - _NB. The lifetime of the access token is only one hour. Then it will expire and you need to login again to get a new one._

- Login to https://rems.ejprd.nbis.se and apply for access to the
  Test resource containing the dataset `DATASET0001`. Approve your own application.

- Verify that you can see the dataset using the download API:
  ```
  curl -s -H "Authorization: Bearer $token" 'https://download.ejprd.nbis.se/metadata/datasets/DATASET0001/files' | jq .
  ```

- Try to access a file with htsget:
  ```
  curl -v -H "Client-Public-Key: $pubkey" -H "Authorization: Bearer $token" -H -k \
  "https://htsget.ejprd.nbis.se/variants/DATASET0001/region_vcfs/Case7_IC.reg?referenceName=19&start=39955351"
  ```
