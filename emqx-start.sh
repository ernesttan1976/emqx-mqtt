#!/bin/bash

# emqx-start.sh
# Create data and log directories with proper permissions
mkdir -p data
mkdir -p log
chmod -R 777 data
chmod -R 777 log

# Build custom EMQX image
docker build -t my-emqx:latest .

# Stop and remove existing container if it exists
docker stop emqx 2>/dev/null
docker rm emqx 2>/dev/null

# Run EMQX container with proper volume mounts and environment variables
docker run -d --name emqx \
  -p 1883:1883 \
  -p 8883:8883 \
  -p 8083:8083 \
  -p 8084:8084 \
  -p 18083:18083 \
  -v $(pwd)/data:/opt/emqx/data \
  -v $(pwd)/log:/opt/emqx/log \
  -v $(pwd)/emqx.conf:/opt/emqx/etc/emqx.conf \
  -e EMQX_NODE__NAME=emqx@localhost \
  -e EMQX_NODE__COOKIE=emqx_secure_cookie_123 \
  -e EMQX_DASHBOARD__DEFAULT_USERNAME=admin \
  -e EMQX_DASHBOARD__DEFAULT_PASSWORD=secure_password_here \
  --restart always \
  my-emqx:latest

echo "EMQX MQTT server is starting up. Dashboard will be available at http://localhost:18083"
echo "Dashboard username: admin"
echo "Dashboard password: secure_password_here"

# Show logs to check for any startup issues
echo "Checking container logs..."
sleep 5
docker logs emqx