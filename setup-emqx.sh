#!/bin/bash

# Create directories for persistence
mkdir -p ~/emqx-data
mkdir -p ~/emqx-log

# Pull and run EMQX container with env file
docker run -d --name emqx \
  -p 1883:1883 \
  -p 8083:8083 \
  -p 8084:8084 \
  -p 8883:8883 \
  -p 18083:18083 \
  -v ~/emqx-data:/opt/emqx/data \
  -v ~/emqx-log:/opt/emqx/log \
  --env-file .env \
  --restart always \
  emqx/emqx:latest

echo "EMQX MQTT server is starting!"
echo "Dashboard: http://localhost:18083"
echo "Username: admin"
echo "Password: ******** (check .env file)"