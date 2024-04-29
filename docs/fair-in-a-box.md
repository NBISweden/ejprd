# FAIR Data Point and EJP-RD Beacon API implementation

Start the services from the root of this repository:

```sh
docker compose --project-directory config/fair-in-a-box up -d
```

Access the services: 

* FAIR Data Point Client at http://localhost:7070 ([documentation](https://fairdatapoint.readthedocs.io/en/latest/) | [default users](https://fairdatapoint.readthedocs.io/en/latest/deployment/local-deployment.html))
* GraphDB at http://localhost:7200 ([documentation](https://graphdb.ontotext.com/documentation/10.6/))
* EJP-RD-Beacon-in-a-Box at http://localhost:8000 ([documentation](https://fairdatapoint.readthedocs.io/en/latest/))