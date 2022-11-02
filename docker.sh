#!/bin/bash
mv Dockerfile /root/.jenkins/workspace/Containerization_Pipeline/target
cd /root/.jenkins/workspace/Containerization_Pipeline/target
docker build . -t tomcat_packaged
