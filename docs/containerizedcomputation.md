### Start the service:
- Run `docker compose --project-directory config/gdi-starter-kit up funnel -d`
- To try it with the rest of the stack, also run:
`docker compose --project-directory config/gdi-starter-kit up htsgetDecrypt -d`


### Access the service:
- Get a token:
    `token=$(curl -s -k https://localhost:8080/tokens | jq -r '.[0]')`
- Put it in your task file:
      `sed -i -e "s/bearer:.*@/bearer:$token@/g" config/gdi-starter-kit/containerized-computation/task1.json`
- The task file `task1.json` contains instructions for downloading chromosome 11 of htsnexus_test_NA12878,
  using htsget, and to count the number of lines in this file.
- Submit your task: `curl 'localhost:8111/v1/tasks' --data @config/gdi-starter-kit/containerized-computation/task1.json`
- Open http://localhost:8111/ in your browser to see the status of the job.
- When the job has completed, you should have a new file `linecount.txt` in your `output/`
  folder. This file should contain the number of lines in the requested bam file.


### About the task execution:
When a task is submitted, the funnel container will download the requested
file and then spawn an inner execution container, which will execute the task (line
counting).

Below are some instructions for the most relevant parts of the task file `task1.json`:
-  `inputs.url`: this is the url to htsget and the request for the partial file
-  `outputs.path`: the path of the execution container that will be copied to the user on localhost
-  `executors.image`: the docker image that the execution container will run
-  `executors.command`: the command that the execution container will run
-  `executors.stdout`: the path on the execution container where the stdout from the command should end up. Should match with `outputs.path`


### Further comments:
Note that the [htsget config](https://github.com/NBISweden/ejprd/blob/feat/add_containerized_compute/config/gdi-starter-kit/config/decrypt-config.toml#L17) has been updated, so that the response_url is set to http://download:8443/s3/,
rather than http://localhost:8443/s3/, as the funnel container will do the requests to download.
