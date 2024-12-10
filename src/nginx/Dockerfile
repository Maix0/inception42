# as of writing latest is 3.21
FROM alpine:3.20
RUN apk add nginx;
RUN adduser -D -g 'www' www;
RUN mkdir -p /var/lib/nginx;
RUN chown -R www:www /var/lib/nginx;


CMD [ "nginx", "-g", "daemon off;" ]

