#!/usr/bin/env bash
taskkill -F -IM $(netstat -aon | grep 3000 | awk '{ print $5 }' | awk 'FNR <= 1')
taskkill -F -IM $(netstat -aon | grep 3001 | awk '{ print $5 }' | awk 'FNR <= 1')
taskkill -F -IM $(netstat -aon | grep 3002 | awk '{ print $5 }' | awk 'FNR <= 1')
taskkill -F -IM $(netstat -aon | grep 3003 | awk '{ print $5 }' | awk 'FNR <= 1')
