FROM --platform=linux/amd64 node:23-alpine as base

RUN npm i postmark-cli -g
RUN apk add --no-cache curl jq
RUN apk add openssl

ARG POSTMARK_SERVER_TOKEN
ARG APP_NAME
ARG VERSION
ARG RECEIVE_EMAIL
ARG LINK


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN echo "👷🏻 Executing Email deployment notification..."
# ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "/entrypoint.sh"]
