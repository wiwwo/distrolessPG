# Distroless PG
Or "very minimal system from distroless image to run Postgresql 17".
<br>Just the bare mininum you need as `/bin`, `/lib` etc to run Postgresql 17.
<br>Lots of TODOs, so keep in touch!

## HOWTO
Assuming you cloned this repo in `/tmp/distrolesPG`:
```
$  cd /tmp
$  git clone https://github.com/docker-library/postgres.git
$  cd postgres/17/bookworm/

$  cp /tmp/distrolesPG/Dockerfile.wiwwo .
$  cp /tmp/distrolesPG/my_entrypoint.sh .

```
Build it:
```
$  docker build . -f Dockerfile.wiwwo  -t distroless-pg-17

```

Run it:
```
$  docker run --name temporary_distroless_pg  \
    --rm -d \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -p5431:5432 \
    distroless-pg-17

```

Aaand it works:
```
$ psql -h 127.0.0.1 -p5431 -Upostgres postgres

psql (17.4 (Homebrew), server 17.4 (Debian 17.4-1.pgdg120+2))
WARNING: psql major version 15, server major version 17.
         Some psql features might not work.
Type "help" for help.


14:30:45 postgres@127/postgres
=# select now();
              now
-------------------------------
 2025-04-01 12:30:46.402765+00
(1 row)

Time: 18.005 ms

14:30:46 postgres@127/postgres
=#
```

I provide also a "minimal change" `Dockerfile`, which is way more similar to the originale one:
```
$  cp /tmp/distrolesPG/Dockerfile.wiwwo_minChange .
$  docker build . -f Dockerfile.wiwwo_minChange  -t distroless-pg-17-mincng
$  docker run --name temporary_distroless_pg  \
    --rm -d \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -p5431:5432 \
    distroless-pg-17-mincng

```

See the changes yourself:
```
$ diff Dockerfile Dockerfile.wiwwo_minChange

```
As you can see, you can "trust" the new `Dockerfile` as long as you trust the `busybox` and the `gcr.io/distroless/cc-debian12` images...
<br>No "sensible information" has been changed/manipulated/altered by me.

# Image size
```
$  docker image ls

distroless-pg-17-mincng       latest     e7d7e88b56e3   7 minutes ago    350MB
distroless-pg-17              latest     43f9bdef0d29   7 minutes ago    350MB

```
