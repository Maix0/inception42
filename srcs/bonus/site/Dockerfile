# as of writing latest is 3.21
FROM alpine:3.20 as builder

RUN apk add cargo;
RUN apk add wget;
RUN apk add gzip;
RUN apk add tar;

RUN mkdir /ts-src;
RUN wget https://github.com/nvim-treesitter/nvim-treesitter/archive/33d27173876499a0f037cb9edff90d583711b6ae.tar.gz -O /tmp/archive-ts.tar.gz;
RUN tar xzf /tmp/archive-ts.tar.gz -C /ts-src/;
RUN mv /ts-src/nvim-treesitter-33d27173876499a0f037cb9edff90d583711b6ae/ /ts;

ENV NVIM_TREESITTER=/ts
RUN wget https://github.com/traxys/verin/archive/0c4681e086e656fe0a951b6da54493155d9a45d4.tar.gz -O /tmp/archive-verin.tar.gz;
RUN mkdir /verin-src;
RUN tar xzf /tmp/archive-verin.tar.gz -C /verin-src/;
RUN mv /verin-src/verin-0c4681e086e656fe0a951b6da54493155d9a45d4 /verin;
RUN cd verin && cargo update && cargo build --release;
RUN cp /verin/target/release/verin /bin/verin;


COPY ./site /site
WORKDIR /build
ENV RUST_BACKTRACE=full
RUN /bin/verin build /site /build;

FROM alpine:3.20

RUN apk add nginx;
RUN apk add openssl;
RUN adduser -D -g 'www' www;
RUN mkdir -p /var/lib/nginx;
RUN rm -rf /var/www/html;

COPY --from=builder /build /var/www/html
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN chown -R www:www /var/lib/nginx;
RUN chown -R www:www /var/www/html;

CMD [ "nginx" ]
