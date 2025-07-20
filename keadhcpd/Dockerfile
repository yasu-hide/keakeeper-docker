FROM alpine:3.22.1
RUN apk add --update --no-cache kea kea-dhcp4 kea-dhcp6 kea-utils kea-admin kea-ctrl-agent mysql-client \
    && mkdir -p run/kea/lock
RUN echo "Quick hack for kea-admin" && ln -s /usr/share/kea/kea/scripts /usr/share/kea/
WORKDIR /etc/kea
COPY kea-dhcp4.conf /etc/kea/
COPY kea-dhcp6.conf /etc/kea/
COPY kea-ctrl-agent.conf /etc/kea/
