# as of writing latest is 3.21
FROM alpine:3.20 AS builder

RUN apk add wget gcc;

#RUN mkdir /ts-src;
#RUN wget https://github.com/nvim-treesitter/nvim-treesitter/archive/33d27173876499a0f037cb9edff90d583711b6ae.tar.gz -O /tmp/archive-ts.tar.gz;
#RUN tar xzf /tmp/archive-ts.tar.gz -C /ts-src/;
#RUN mv /ts-src/nvim-treesitter-33d27173876499a0f037cb9edff90d583711b6ae/ /ts;

#ENV NVIM_TREESITTER=/ts
RUN wget https://maix.me/verin -O /bin/verin;
RUN chmod +x /bin/verin;


COPY ./site /site
WORKDIR /build
ENV RUST_BACKTRACE=full
RUN /bin/verin build /site /build;

FROM alpine:3.20

RUN apk add nginx openssl;
RUN adduser -D -g 'www' www;
RUN mkdir -p /var/lib/nginx;
RUN rm -rf /var/www/html;

COPY --from=builder /build /var/www/html
COPY --from=builder /bin/verin /bin/verin
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN chown -R www:www /var/lib/nginx;
RUN chown -R www:www /var/www/html;

CMD [ "nginx" ]
