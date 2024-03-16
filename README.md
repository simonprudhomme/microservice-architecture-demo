# Microservice Achitecture

## Overview
This project is a microservice architecture that includes the following services:
- Auth, using JWT, Msyq
- gateway
- mongodb to store the files
- converter, to convert the files
- rabbitmq, message broker
- notification, to send email

## Development
### Python
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
```bash
# Install
brew tap mongodb/brew
brew install mongodb-community@7.0
```
Note: create MongoDB Database [example](https://github.com/kantancoding/microservices-python/issues/21#issuecomment-1383206786)


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

### Set Hosts
```bash
sudo bash -c 'echo "127.0.0.1       mp3converter.com" >> /etc/hosts'
sudo bash -c 'echo "127.0.0.1       rabbitmq-manager.com" >> /etc/hosts'
```

### K8s 
```bash
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

## See docker repository
https://hub.docker.com/repository/docker/simonprudhomme/auth/general


## Run the project
```bash
# Start the services
minikube start

# regenerate the docker images and deploy the services
bash scripts/setup.sh all

# To acquire the JWT token
curl -X POST http://mp3converter.com/login -u simonprudhomme@gmail.com:admin

# To upload a file
curl -X POST -F 'file=@./test.mkv' -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNpbW9ucHJ1ZGhvbW1lQGdtYWlsLmNvbSIsImV4cCI6MTcxMDYzODUzNCwiaWF0IjoxNzEwNTUyMTM0LCJhZG1pbiI6dHJ1ZX0.Vb0yYmDdaan641gguSrEMQryimLwi3NQ7QowzSB_GhQ' http://mp3converter.com/upload
```