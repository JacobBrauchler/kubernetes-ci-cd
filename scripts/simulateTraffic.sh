#!/bin/bash

countForMaxPods=500
countFor1Pod=250
url=http://monitor-scale.192.168.99.100.xip.io
maxPods=5

echo 'Testing with 1 pod'

echo '250 concurrent requests'

# 250 conncurrent requests to puzzle
# curl -s --data "count=250" http://monitor-scale.192.168.99.100.xip.io/loadtest/concurrent > /dev/null
curl -s --data "count=${countFor1Pod}" "${url}/loadtest/concurrent" > /dev/null
sleep 2

echo '250 consecutive requests'

# 250 consecutive requests to puzzle      
# curl -s  --data "count=250" http://monitor-scale.192.168.99.100.xip.io/loadtest/consecutive > /dev/null
curl -s --data "count=${countFor1Pod}" "${url}/loadtest/consecutive" > /dev/null

echo 'Bringing up new pods'

# # scale to 5 pods
# curl -s --data "count=5" http://monitor-scale.192.168.99.100.xip.io/scale > /dev/null
curl -s --data "count=${maxPods}" "${url}/scale" > /dev/null

sleep 60

echo 'Testing with 5 pods'

# 250 conncurrent requests to puzzle
# curl -s --data "count=500" http://monitor-scale.192.168.99.100.xip.io/loadtest/concurrent > /dev/null
curl -s --data "count=${countForMaxPods}" "${url}/loadtest/concurrent" > /dev/null

sleep 2

# # 250 consecutive requests to puzzle      
# curl -s --data "count=500" http://monitor-scale.192.168.99.100.xip.io/loadtest/consecutive > /dev/null
curl -s --data "count=${countForMaxPods}" "${url}/loadtest/consecutive" > /dev/null

sleep 30

echo "Press any button when you are ready to finish"
read -n 1 

# scale to 1 pod

# curl -s --data "count=1" http://monitor-scale.192.168.99.100.xip.io/scale > /dev/null
curl -s --data "count=1" "${url}/scale" > /dev/null



# Reloads crossword data from database
# Get
# http://puzzle.192.168.99.100.xip.io/puzzle/v1/crossword
# curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://puzzle.192.168.99.100.xip.io/puzzle/v1/crossword

# Clear crossword view
# Put
# http://puzzle.192.168.99.100.xip.io/puzzle/v1/crossword/clear

# Saves data in crossword puzzle
# Put
# http://puzzle.192.168.99.100.xip.io/puzzle/v1/crossword


