CREATE TABLE readings (
    id Int32,
    firstname String,
    lastname String,
    age Int32,
    email String,
    regtime DateTime,
    regdate ALIAS toDate(regtime)
) Engine = MergeTree
PARTITION BY toYYYYMM(regtime)
ORDER BY (id, regtime);

CREATE TABLE readings_queue (
    id Int32,
    firstname String,
    lastname String,
    age Int32,
    email String,
    regtime DateTime
) ENGINE=Kafka('broker:29092', 'readings', 'readings_consumer_group1', 'CSV');

CREATE MATERIALIZED VIEW readings_queue_mv TO readings AS
SELECT id, firstname, lastname, age, email, regtime
FROM readings_queue
SETTINGS
stream_like_engine_allow_direct_select = 1;
