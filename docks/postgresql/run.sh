#! /usr/bin/env bash

docker run --name jetel-postgres -e POSTGRES_USER=jetel -e POSTGRES_PASSWORD=jetel -p 5432:5432 -d postgres