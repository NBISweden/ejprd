# Jupyter Notebook

Start the services from the root of the repository:

```sh
docker compose --project-directory config/notebook up -d
```

Access the service (preconfigured password: pass):
* Jupyter Lab http://localhost:10000/lab ([documentation](https://jupyterlab.readthedocs.io/en/latest/user/interface.html))
* Jupyter Notebook http://localhost:10000/tree ([documentation](https://jupyter-notebook.readthedocs.io/en/latest/))