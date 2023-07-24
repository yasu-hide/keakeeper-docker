FROM alpine:3.16
WORKDIR /tmp
RUN apk add --update --no-cache tzdata mariadb mariadb-server-utils mariadb-client openrc \
    && sed -ri '275s/cgroup_add_service/#cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc && touch /run/openrc/softlevel \
    && rc-update add mariadb \
    && /etc/init.d/mariadb setup
COPY mariadb-server.cnf /etc/my.cnf.d/
EXPOSE 3306
CMD ["mysqld_safe"]
