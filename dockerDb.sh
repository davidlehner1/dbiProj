#!/bin/bash

# Check if the container with the name 'oraxe21' already exists
if [ "$(docker ps -aq -f name=oraxe21)" ]; then
    # Container exists, so start it
    docker start oraxe21
else
    # Container doesn't exist, so create and start it
    docker run --name oraxe21 -d -p 15210:1521 -e ORACLE_PASSWORD=Oraxe23 -v oracledb21:/opt/oracle/oradata gvenzl/oracle-xe:slim
fi
