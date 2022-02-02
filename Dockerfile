FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y net-tools iproute2 ipppd iptables ssh openfortivpn && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Fake ppp
RUN echo pppoe > /etc/modules
RUN mknod /dev/ppp c 108 0

COPY start.sh /start.sh
RUN chmod u+x /start.sh

COPY gateway-fix.sh /gateway-fix.sh
RUN chmod u+x /gateway-fix.sh

CMD [ "/start.sh" ]
