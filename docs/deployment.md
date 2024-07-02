TODO:
- where to look for more info

# Rems
See [`docs/rems.md`](rems.md) as well as the configuration files on the server.

# FDP
The FDP runs under `ejprd/` at the server. One can use [the GUI](https://fdp.ejprd.nbis.se) to add/remove users.

# SDA
The SDA pipeline runs under `ejprd/` at the server. The configuration files (`.env`,
`starter-kit-storage-and-interfaces/config/config.yaml`, `starter-kit-storage-and-interfaces/config/iss.json`),
as well as the docker files
(`starter-kit-storage-and-interfaces/docker-compose.yml`,
`starter-kit-storage-and-interfaces/docker-compose-demo.yml`) has been updated on the server. All changes are not
commited (credentials, keys etc).

## Auth
To use LS-AAI, we run the SDA application `auth`. Thus, the `docker-compose-demo.yml` in
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
