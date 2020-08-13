#!/bin/bash

yum update -y
yum install docker -y

service docker enable
service docker start

docker run --name hello -d -p 80:80 nginx