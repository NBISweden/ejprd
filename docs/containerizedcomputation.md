### Start the service:
- If you have not already loaded the data to the archive, or wish to reload it, run:
  ```
  docker compose --project-directory config/gdi-starter-kit down --remove-orphans -v
  docker compose --project-directory config/gdi-starter-kit up data_loader
  ```
- Run `docker compose --project-directory config/gdi-starter-kit up funnel -d`
- To try it with the rest of the stack, also run:
`docker compose --project-directory config/gdi-starter-kit up htsget -d`


### Access the service:
- Get a token:
    `token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')`
- Put it in your task file:
      `sed -e "s/{{TOKEN}}/$token/g" config/gdi-starter-kit/containerized-computation/task1.json > task.json`
- The task file `task1.json` contains instructions for downloading chromosome 11 of htsnexus_test_NA12878,
  using htsget, and to count the number of lines in this file.
- Submit your task: `curl 'localhost:8111/v1/tasks' --data @task.json`
- Open http://localhost:8111/ in your browser to see the status of the job.
- When the job has completed, you should have a new file `linecount.txt` in your `output/`
  folder (under `config/gdi-starter-kit/containerized-computation`). This file should contain the number of lines in the requested bam file.

## How to re-create keys
- The funnel container uses a cryptgh for receiving data from htsget. The private key must be unencrypted, so that
   it does not require a password. To generate such a key pair, run:
   ```
   crypt4gh-keygen -f --nocrypt --sk priv.key --pk pub.key
   ```
- The public key used by funnel must be base64 encoded and start with an empty line.
  To generate such a key file, run
  ```
  (echo ""; base64 -w0 pub.key) > pub64.key
  ```


### About the task execution:
When a task is submitted, the funnel container will download the requested
file and then spawn an inner execution container, which will execute the task (line
counting).

See [the GA4GH's documentation](https://www.ga4gh.org/product/task-execution-service-tes/) for more information the Task Execution Service (TES).
Below are some instructions for the most relevant parts of the task file `task1.json`:
-  `inputs.url`: this is the url to htsget and the request for the partial file
-  `outputs.path`: the path of the execution container that will be copied to the user on localhost
-  `executors.image`: the docker image that the execution container will run
-  `executors.command`: the command that the execution container will run
-  `executors.stdout`: the path on the execution container where the stdout from the command should end up. Should match with `outputs.path`


### Further comments:
Note that the [htsget config](https://github.com/NBISweden/ejprd/blob/feat/add_containerized_compute/config/gdi-starter-kit/config/download-config.toml#L17) has been updated, so that the response_url is set to http://download:8443/s3/,
rather than http://localhost:8443/s3/, since the the requests to download will be done from inside a (funnel) docker container.
