#!/usr/bin/bash
yamllint docker-compose.yml | grep -v comments | grep -v line-length
