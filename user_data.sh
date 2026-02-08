#!/bin/bash
apt update -y
apt install docker.io -y
systemctl start docker
docker run -d -p 1337:1337 strapi/strapi

