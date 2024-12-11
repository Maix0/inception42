# as of writing latest is 3.21
FROM alpine:3.20
RUN apk add nginx;
RUN apk add openssl;
RUN adduser -D -g 'www' www;
RUN mkdir -p /var/lib/nginx;
RUN rm -rf /var/www/html;
RUN chown -R www:www /var/lib/nginx;

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=FR/OU=student/CN=maiboyer.42.fr";

RUN cat /etc/nginx/nginx.conf;
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./launch.sh /bin/nginx-launch
RUN chmod +x /bin/nginx-launch

CMD [ "/bin/nginx-launch", "nginx" ]

