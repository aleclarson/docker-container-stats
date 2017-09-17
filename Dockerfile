FROM alpine:3.5
RUN apk add --no-cache bash jq netcat-openbsd
COPY . .
CMD ["/run.sh"]
