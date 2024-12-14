# as of writing latest is 3.21
FROM alpine:3.20

RUN apk add vsftpd;

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf.new

COPY ./conf_ftp.sh /bin/conf_ftp
RUN chmod +x /bin/conf_ftp

STOPSIGNAL SIGKILL

CMD [ "/bin/conf_ftp", "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
