FROM ubuntu:16.04
RUN apt update && apt install -y wget curl libglib2.0-0 libglu1 libdbus-1-3
RUN mkdir /glutz
RUN wget -c https://cip.myassets.ch/CIP/asset/download/glutz-website/99636 -O - | tar -zx --directory /glutz
RUN mv /glutz/glutz-eaccess-desktop-1.13.4-Linux/* /glutz
RUN echo 'ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2013", MODE="0666", SYMLINK+="glutz_ga2"' >/lib/udev/rules.d/90-glutz-ga2.rules


ENV DBPATH=/db/db.gax
CMD ["bash", "-c", "/glutz/Desktop/eAccessServer --auto-convert --auto-reclaim $DBPATH"]
