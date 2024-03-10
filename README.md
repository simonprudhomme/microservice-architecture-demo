# Microservice Achitecture

## Overview


## Prerequisites
### Development/Python
```bash
# Inbstall
brew install python

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# install dependencies
pip install -r requirements.txt
```
### MongoDB
https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-os-x/
!Important, create MongoDB Database [example](https://github.com/kantancoding/microservices-python/issues/21#issuecomment-1383206786)


### MySQL
```bash
# Install
brew install mysql
brew services start mysql

# create database
mysql -uroot < init.sql

# View database and tables
mysql -uroot
show databases;
use auth;
show tables;
describe user;
select * from user;

# if you need to delete the database
mysql -uroot -e "DROP DATABASE auth;"
mysql -uroot -e "DROP USER auth_user@localhost;"
```

# Set Hosts
```bash
sudo bash -c 'echo "127.0.0.1       mp3converter.com" >> /etc/hosts'
sudo bash -c 'echo "127.0.0.1       rabbitmq-manager.com" >> /etc/hosts'
```

# K8s 
# Install
brew install docker
brew install kubectl
brew install minikube
brew install k9s

# Start minikube
minikube start
minikube addons enable ingress

# start k9s
k9s

# Start minikube tunnel
minikube tunnel
```

## See docker image;
https://hub.docker.com/repository/docker/simonprudhomme/auth/general


curl -X POST http://mp3converter.com/login -u simonprudhomme@gmail.com:admin

curl -X POST -F 'file=@./test.mp4' -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNpbW9ucHJ1ZGhvbW1lQGdtYWlsLmNvbSIsImV4cCI6MTcxMDE4NjMyMCwiaWF0IjoxNzEwMDk5OTIwLCJhZG1pbiI6dHJ1ZX0.DA-1pTaNkyZphbp24icEjrQvOQJDlaUgKN1xqyqZiag' http://mp3converter.com/upload