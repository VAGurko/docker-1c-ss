# Docker 1C standalone server

## Подготовка к работе

Подключить разделы (пример из docker-compose.yml):

```
    volumes:
      - ./data:/home/usr1cv8
      - ./conf:/opt/1cv8/conf
```

Если есть файл с конфигурацией сервера config.yml в папке конфигураций (/opt/1cv8/conf/config.yml) то запускается сервер с выбранной конфигурацией иначе запуск сервера производится в режиме работы с файловой базой расположенной в каталоге:

```./data/.1cv8/1C/1cv8/standalone-server/db-data``` 

# Примеры для работы с конфигурациями

- [ ] Создать конфигурационный файл по параметрам командной строки

```
docker compose exec 1c-ss ibcmd server config init \
--dbms=postgresql \
--db-server=dbServerName \
--db-user=dbUser \
--db-pwd=dbUserPassword \
--db-name=dbName \
--name=docsIB \
--base=/webAccess >> /opt/1cv8/conf/config.yml
```

Автономный сервер, запущенный с таким конфигурационным файлом, будет запускать веб-клиента при обращении по адресу http://localhost:8314/webAccess .

- [ ] Создать конфигурационный файл по параметрам информационной базы сервера

```
docker compose exec 1c-ss ibcmd server config import \
--cluster-data="d:\1C srvinfo" \
--name=demoma \
--out=d:\ss-cfgs\demoma.yml
```

Одновременно с импортом информации об информационной базе можно импортировать данные публикации. Для этого следует в командной строке импорта указать путь к файлу default.vrd (параметр --publication):

```
docker compose exec 1c-ss ibcmd server config import \
--cluster-data="/opt/1cv8/conf/cluster" \
--name=demoma \
--publication=/opt/1cv8/conf/default.vrd \
--out=/opt/1cv8/conf/config.yml
```

- [ ] Создание конфигурационного файла автономного сервера

```
docker compose exec 1c-ss ibcmd server config init \
--db-path="/home/usr1cv8/.1cv8/1C/1cv8/standalone-server/file-db" \ 
--name=docsIB --base=/webAccess \
--out="/opt/1cv8/conf/config.yml"
```

- [ ] Создать информационную базу из файла конфигурации (*.cf)

```
docker compose exec 1c-ss ibcmd infobase create \
--db-path="/home/usr1cv8/.1cv8/1C/1cv8/standalone-server/file-db" \ 
--load="/opt/1cv8/conf/1Cv8.cf"
```
- [ ] Загрузить конфигурацию из файла (*.cf)

Первая команда выполнит собственно загрузку конфигурации в информационную базу, а вторая ‑ обновит конфигурацию базы данных (с выполнением, при необходимости, реструктуризации базы данных).

```
docker compose exec 1c-ss ibcmd infobase config load \
--dbms=mssqlserver --db-server=dbServerName \
--db-user=dbUser \
--db-pwd=dbUserPassword \
--db-name=docs-db \
--name=docsIB 1Cv8.cf
```
```
docker compose exec 1c-ss ibcmd infobase config apply \
--dbms=mssqlserver \
--db-server=dbServerName \
--db-user=dbUser \
--db-pwd=dbUserPassword \
--db-name=docs-db \
--name=docsIB
```

- [ ] Создать информационную базу из файла выгрузки (*.dt)

```
docker compose exec 1c-ss ibcmd infobase create \
--create-database \
--restore=/home/usr1cv8/backup/1cv8.dt
```

- [ ] Загрузить в информационную базу данные из файла выгрузки (*.dt)

```
docker compose exec 1c-ss ibcmd infobase restore /home/usr1cv8/backup/1cv8.dt
```



Документация доступна по этой [ссылке](https://its.1c.ru/db/v8314doc/bookmark/adm/TI000000894)