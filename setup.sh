#!/bin/bash
MYSQL_CNT=mariadb

do_mysql_secure_installation () {
docker-compose exec "${MYSQL_CNT}" mysql_secure_installation
}

do_initialize_database () {
echo "Create database kea"
docker-compose exec -T "${MYSQL_CNT}" mysql -u root << EOF
DROP DATABASE IF EXISTS kea;
CREATE DATABASE kea;
GRANT ALL ON kea.* TO keauser@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

docker-compose run --rm --no-deps keadhcp4 kea-admin db-init mysql -h ${MYSQL_CNT} -u keauser -p password -n kea

docker-compose exec -T "${MYSQL_CNT}" mysql -h ${MYSQL_CNT} -u keauser -ppassword kea < <(docker-compose run --rm --no-deps keaphpfpm cat /var/www/keakeeper/db/auth.sql)

}

do_copy_dhcp_conf () {
cd keadhcpd
cid=$(docker ps -a | grep -e keadhcp4 -e keadhcp6 | head -1 | awk '{print $1}')
docker cp kea-dhcp4.conf ${cid}:/etc/kea/kea-dhcp4.conf
docker cp kea-dhcp6.conf ${cid}:/etc/kea/kea-dhcp6.conf
docker cp kea-ctrl-agent.conf ${cid}:/etc/kea/kea-ctrl-agent.conf
docker exec ${cid} chown 82:82 /etc/kea
cid=
cd -
docker ps -a | grep -e keadhcp4 -e keadhcp6 | grep Exited | awk '{print $1}' | xargs --no-run-if-empty docker rm
}

docker-compose up -d "${MYSQL_CNT}"
do_initialize_database
do_mysql_secure_installation
docker-compose down

docker-compose up -d
do_copy_dhcp_conf
docker-compose down

docker-compose up -d
