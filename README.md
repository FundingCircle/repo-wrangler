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

docker run --rm -it -e GITHUB_ORG -e GITHUB_TOKEN repo-wrangler ./main.rb
```
