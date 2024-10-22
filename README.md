# CEL-dev-tool
This small repository houses a Dockerized instance of Elastic's [Mito CLI Tool](https://github.com/elastic/mito) which, according to their readme, is a "message stream processing engine based on CEL." This tool is particularly useful for testing CEL programs written for the [CEL input](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-cel.html) for Filebeat/Elastic Agent.

## Usage
1. Clone the repo
2. run `docker build -t cel-dev-tool:v1 -f Dockerfile .`
3. run `docker run --rm --volume ./data/:/data cel-dev-tool:v1 -data /data/data.json /data/app.cel`
    1. we mount the .data/ directory into the container which contains our CEL program (app.cel) as well as the state configuration (data.json).

---

The included data/app.cel is a simple script that reaches out to the Github API to retrieve self-hosted runner statuses. It is somewhat unique in that it uses the `state.cursor` to store the authentication token due to CEL only supporting Basic and Oauth2 authentication methods. The `state.cursor` vars do not get reset after each iteration/restart in the Elastic Agent/Beats implementation. It would be wise to include the `cursor.auth_token` in the [redact options](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-cel.html#cel-state-redact).