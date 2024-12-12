FROM alpine:latest AS build

RUN apk add --no-cache build-base automake autoconf

WORKDIR /home/optima

COPY ./HTTPserver .

RUN ./configure

RUN make

FROM alpine:latest

COPY --from=build /home/optima/funca /usr/local/bin/funca

ENTRYPOINT ["/usr/local/bin/funca"]