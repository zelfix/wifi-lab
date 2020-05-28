FROM alpine

RUN apk add --no-cache bash hostapd dhcp iproute2
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["/bin/bash", "./entrypoint.sh" ]