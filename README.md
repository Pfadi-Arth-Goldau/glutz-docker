# glutz-docker

Allows to run the [glutz](https://glutz.com) eAccessServer software in a Docker dontainer

Automaticaly downloads a fixed version while building the `Dockerfile`. To obtain the direct download url got to https://glutz.com/ch/de/service/download/soft-firm-ware and choose Linux, accept the GPL. You get redirected to the real download site (e.g. for 1.13.4 it is https://cip.myassets.ch/CIP/asset/download/glutz-website/99636)


# Instructions

Build the image using `docker build -t glutz-eAccessServer .` or by using the `docker-compose.yml` file using `docker-compos build`

Copy your .gax db file to folder on the server and mount the folder containing it either with `-v` when using `docker run` or add as a volume in your `docker-compose.yml`. Set an the environt variable `DBPATH` to the path of your .gax file.
