# OpenCPU in Docker

# Build
## Default
docker build -t cannin/opencpu:opencpu-1.6 .

## Custom Install
docker build -t cannin/opencpu:enrichmentmap -f Dockerfile_enrichmentmap .

# Run
## Default
docker rm -f oc; docker run --name oc -t -p 80:80 -p 8004:8004 cannin/opencpu
docker rm -f oc; docker run --name oc -it -p 80:80 -p 8004:8004 cannin/opencpu bash
docker exec -it oc bash

## Custom
docker rm -f oc; docker run --name oc -t -p 80:80 -p 8004:8004 cannin/opencpu:enrichmentmap
docker rm -f oc; docker run --name oc -it -p 80:80 -p 8004:8004 cannin/opencpu:enrichmentmap bash
docker exec -it oc bash

# Call OpenCPU
curl http://localhost/ocpu/library/stats/R/rnorm/json -d "n=10&mean=5"

# Access output and files
## Public
curl http://public.opencpu.org/ocpu/library/stats/R/rnorm -d "n=10&mean=5"
curl http://public.opencpu.org/ocpu/tmp/x09e692cd2c/R/.val
curl http://public.opencpu.org/ocpu/tmp/x09e692cd2c/files/DESCRIPTION

## Local/Custom Package
curl http://localhost/ocpu/library/enrichmentmap/R/getMatrix/json -d "n=100&r=10&c=10"
curl http://localhost/ocpu/library/enrichmentmap/R/getJson -d "saveFile=TRUE"
curl http://localhost/ocpu/tmp/x06ee947c11/R/.val/print
curl http://localhost/ocpu/tmp/x06ee947c11/files/example.json
curl http://localhost/ocpu/tmp/x06ee947c11/files/DESCRIPTION
