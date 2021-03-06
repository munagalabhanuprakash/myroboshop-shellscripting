#!/usr/bin/env bash

source components/00-common.sh
CheckRootUser

ECHO "Configuring yum repos"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
CheckStatus $?

ECHO "Installing redis-6.2.7"
yum install redis-6.2.7 -y &>>${LOG_FILE}
CheckStatus $?

ECHO "Updating Bind ip in /etc/redis.conf and /etc/redis/redis.conf"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>${LOG_FILE}
CheckStatus $?

ECHO "Start Redis Database"
systemctl enable redis &>>${LOG_FILE} && systemctl start redis &>>${LOG_FILE}
CheckStatus $?



