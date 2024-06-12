#!/bin/bash
set -e

ping -c 4 172.10.10.10

# Get environmetn
REPO=$REPO
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT

cd /root/api
pwd
pwd
pwd
rm -rf .git

git config --global init.defaultBranch master
git config --global http.sslverify false
git init
git remote add origin ${REPO}
git branch -m master
git pull origin master

# Replace values in env. file
sed -i "s/127.0.0.1/${DB_HOST}/g" .env
sed -i "s/5433/${DB_PORT}/g" .env
cat .env

# This takes a while
npm install -g npm-check-updates
npm install --force

npm install @nestjs/common

npm audit fix --force




npm run start dev

exec "$@"