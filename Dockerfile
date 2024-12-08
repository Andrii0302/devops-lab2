FROM alpine

WORKDIR /home/optima

COPY  ./HTTPserver .

RUN apk add libstdc++

RUN apk add libc6-compat

ENTRYPOINT ["./HTTPserver"]