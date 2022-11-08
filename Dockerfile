FROM ubuntu:16.04

ENV DOWNLOAD_LINK="https://cip.myassets.ch/CIP/asset/download/glutz-website/99636"
ENV DBPATH=/db/db.gax

# Install dependencies
RUN apt update && apt install -y wget curl libglib2.0-0 libglu1 libdbus-1-3 libgl1-mesa-glx libssl-dev fontconfig ttf-mscorefonts-installer
RUN fc-cache -f

# Download and extract glutz
RUN mkdir /glutz
RUN wget -c ${DOWNLOAD_LINK} -O - | tar -zx --directory /glutz
RUN mv /glutz/glutz-eaccess-desktop-1.13.4-Linux/* /glutz
RUN bash /glutz/install_udev_rules.sh

# Build a shell script because the ENTRYPOINT command doesn't like using ENV
RUN echo "#!/bin/bash \n /glutz/Desktop/eAccessServer --logfile="/var/log/glutz.log" --loglevel=5 --auto-convert --auto-reclaim ${DBPATH}" > ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# expose ports
EXPOSE 26682:26682
EXPOSE 8332:8332

# run
ENTRYPOINT ["./entrypoint.sh"]
