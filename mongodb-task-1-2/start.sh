#!/bin/bash

docker-compose -p mongo-kafka up -d --force-recreate       
sleep 20
echo "Waiting done--1"
docker-compose -p mongo-kafka ps
sleep 20
echo "Waiting done--2"
docker exec -it mongo1 mongo --eval "rs.initiate( {  _id: 'rs0', members: [ { _id: 0, host: 'mongo1:27017' }]});"

until [ \
  "$(docker exec -i mongo1 /bin/bash -c "curl -s -w '%{http_code}' -o /dev/null \"http://connect:8083/connectors\"")" \
  -eq 200 ]
do
  echo "Waiting..."
  sleep 5
done

sleep 5

docker exec -i mongo1 /bin/bash -c "cx /scratch_space/src/sourceTopic.json"
docker exec -i mongo1 /bin/bash -c "cx /scratch_space/dst/destinationTopic.json"
