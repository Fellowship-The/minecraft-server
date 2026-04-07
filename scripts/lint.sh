#!/usr/bin/bash
set -x
yamllint docker-compose.yml | grep -v comments | grep -v line-length
