FROM alpine:3.7

RUN apk add --no-cache ca-certificates tzdata wget \
    && addgroup -S app \
    && adduser -S -g app app

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /app

RUN wget https://github.com/ouqiang/gocron/releases/download/v1.5.3/gocron-v1.5.3-linux-amd64.tar.gz \
	&& tar -zxvf gocron-v1.5.3-linux-amd64.tar.gz && rm -rf gocron-v1.5.3-linux-amd64.tar.gz \
	&& mv gocron-linux-amd64/gocron /app && rm -rf gocron-linux-amd64

RUN chown -R app:app ./

EXPOSE 5920

USER root

ENTRYPOINT ["/app/gocron", "web"]
