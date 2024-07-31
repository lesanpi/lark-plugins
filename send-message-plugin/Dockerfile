FROM alpine:3.16

RUN apk add --no-cache curl jq
RUN apk add openssl

ARG APP_ID
ARG APP_SECRET
ARG RECEIVE_ID_TYPE
ARG RECEIVE_ID
ARG CONTENT
ARG MSG_TYPE

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
