# Repo Wrangler

It wrangles them repos!

## Build

```shell
docker build -t repo-wrangler .
```

## Run

```shell
docker run --rm -it -u `id -u`:`id -g` -v "$PWD":/work -w /work repo-wrangler ./main.rb
```
