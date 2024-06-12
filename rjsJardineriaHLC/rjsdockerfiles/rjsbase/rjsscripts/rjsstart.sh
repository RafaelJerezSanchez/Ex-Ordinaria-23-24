#!/bin/bash
set -e

ping -c 4 192.168.5.192

REPO=$REPO
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT

cd /root/api
rm -rf .git

git config --global init.defaultBranch main
git config --global http.sslverify false
git init
git remote add origin ${REPO}
git branch -m master
git pull origin master

sed -i "s/127.0.0.1/${DB_HOST}/g" .env
sed -i "s/5433/${DB_PORT}/g" .env
cat .env

npm install -g npm-check-updates
npm install --force

npm install @nestjs/common


npm run start dev

tail -f /dev/null