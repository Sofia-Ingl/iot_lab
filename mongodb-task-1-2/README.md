Основа проекта тут:
https://www.mongodb.com/docs/kafka-connector/current/quick-start/

Здесь сразу 2 задания - 1 и 2. Для второго в sourceTopic.json добавлена конфигурация схемы.

Для запуска контейнеров:
./start.sh
Для остановки контейнеров:
./stop.sh

Для подключения к базе1:
docker exec -it mongo1 mongo

Для подключения к базе2:
docker exec -it mongo1 mongo

Пример данных:
db.users.insertOne({ firstname: "lol", lastname: "kek", age: 33, email: "kek@gmail.com", sex: "M" })

Также по сравнению с оригинальным проектом были изменены версии mongo image в mongo.Dockerfile и pymongo в requirements.txt. Для того, чтобы можно было запустить на виртуальной машине.
