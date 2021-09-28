#!/bin/bash

set -e
set -o pipefail

docker build -t didstopia/minecraft-server:latest .
