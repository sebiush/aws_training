#!/usr/bin/env bash

unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY

cd ./frontend && node index.js &
cd ./consumer && node index.js &
cd ./producer && node index.js &
cd ./stock && node index.js &
