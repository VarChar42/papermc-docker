FROM eclipse-temurin:17-alpine

ENV MC_VERSION="latest" \
    JVM_RAM="" \
    JVM_ARGS="" \
    DEBUG="false"

COPY setup_paper.sh .


RUN apk update && apk add curl jq \
    && mkdir mc_root

WORKDIR /mc_root

CMD ["sh", "../setup_paper.sh"]

EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME ["/mc_root"]