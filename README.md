# Repo Wrangler

It wrangles them repos!

## Build

```shell
docker build -t repo-wrangler .
```

## Run

```shell
export GITHUB_ORG=your_org_here
export GITHUB_TOKEN=your_token_here
export SLACK_API_TOKEN=your_token_here

docker run --rm -it -e GITHUB_ORG -e GITHUB_TOKEN -e SLACK_API_TOKEN -u `id -u`:`id -g` -v "$PWD":/work -w /work repo-wrangler ./main.rb
```
