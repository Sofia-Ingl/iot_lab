#!/bin/bash

docker-compose -p clickhouse-kafka up -d --force-recreate       
sleep 15
docker exec -i connect /bin/bash -c "kafka-topics \
--bootstrap-server broker:29092 \
--topic readings \
--create --partitions 6 \
--replication-factor 1"
sleep 5
docker cp init.sql clickhouse-server:/docker-entrypoint-initdb.d/init.sql
docker exec -i clickhouse-server /bin/bash -c "clickhouse-client -n < /docker-entrypoint-initdb.d/init.sql"


docker exec -i connect /bin/bash -c "kafka-console-producer --broker-list broker:29092 --topic readings <<END
1,\"AAAA1\",\"AAAA2\",12,\"AAAA1@gmail.com\",\"2023-05-28 00:00:11\"
2,\"BBBB1\",\"BBBB2\",13,\"BBBB1@gmail.com\",\"2023-05-29 00:00:11\"
3,\"CCCC1\",\"CCCC2\",14,\"CCCC1@gmail.com\",\"2023-05-30 00:00:11\"
4,\"DDDD1\",\"DDDD2\",15,\"DDDD1@gmail.com\",\"2023-06-01 00:00:11\"
END"

