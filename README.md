# glutz-docker

Allows to run the [glutz](https://glutz.com) eAccessServer software in a Docker dontainer

Automaticaly downloads a fixed version while building the `Dockerfile`. To obtain the direct download url got to https://glutz.com/ch/de/service/download/soft-firm-ware and choose Linux, accept the GPL. You get redirected to the real download site (e.g. for 1.13.4 it is https://cip.myassets.ch/CIP/asset/download/glutz-website/99636). Adjust the `Dockerfile` with the new url.


# Instructions

Build the image using `docker build -t glutz-eaccessserver .` or by using the `docker-compose.yml` file using `docker-compose build`

Copy your `.gax` db file to folder on the server and mount the folder containing it either with `-v` when using `docker run -v /folder/containing/gax:/db glutz-eAccessServer` or add as a volume in your `docker-compose.yml`.

Set an the environt variable `DBPATH` to the folder of your .gax file either with `-e DBPATH=/db` when using `docker run` or in the `environment`

Map port 8332 with option `-p 8332:8332` or in the `ports:` section of `docker-compose.yaml`

docker run example: `docker run -v /folder/containing/gax:/db -e DBPATH=/db -p 8332:8332 glutz-eaccessserver`


_**Recommendation:**_

Secure your glutz instance with a reverse proxy like [traefik](https://traefik.io/) or [nginx](https://www.nginx.com/). Traefik allows easy configuration together with automatic let's encrypt certificates.


## Settings in eAccessDesktop

For me it was necessary to change the "Host-Address" setting in eAccessDesktop to `http://0.0.0.0:80`.  Probably any other port woud work too, but change to `0.0.0.0` is important. I think otherwise eAccessServer does not listen to all network interfaces and within docker there are multiple network interfaces. 
![](/doc/eAccessDesktop_Host-Address_Setting.PNG)