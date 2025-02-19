#!/bin/bash

docker pull jenkins/jenkins:lts

docker run -p 8080:8080 -p 50800:50800 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts