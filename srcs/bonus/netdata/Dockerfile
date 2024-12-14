# as of writing latest is 3.21
FROM alpine:3.20

RUN apk add netdata;

# make everything log to stdout/stderr
RUN mkdir -p /opt/src /var/log/netdata;
RUN ln -sf /dev/stdout /var/log/netdata/access.log;
RUN ln -sf /dev/stdout /var/log/netdata/aclk.log;
RUN ln -sf /dev/stdout /var/log/netdata/debug.log;
RUN ln -sf /dev/stderr /var/log/netdata/error.log;
RUN ln -sf /dev/stderr /var/log/netdata/daemon.log;
RUN ln -sf /dev/stdout /var/log/netdata/collector.log;
RUN ln -sf /dev/stdout /var/log/netdata/fluentbit.log;
RUN ln -sf /dev/stdout /var/log/netdata/health.log;


# stolen from netdata github repo lul
# basically make a new user, and make sure everything needed is owned by netdata:root
RUN mkdir -p /etc/netdata /usr/share/netdata /usr/libexec/netdata;
RUN chown -R root:root /etc/netdata /usr/share/netdata /usr/libexec/netdata;
RUN chown -R netdata:root /usr/lib/netdata /var/cache/netdata /var/lib/netdata /var/log/netdata;
RUN chown -R netdata:netdata /var/lib/netdata/cloud.d;
RUN chmod 0700 /var/lib/netdata/cloud.d;
RUN chmod 0755 /usr/libexec/netdata/plugins.d/*.plugin;

RUN [ -f "/usr/libexec/netdata/plugins.d/cgroup-network" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/cgroup-network" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/local-listeners" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/local-listeners" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/apps.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/apps.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/freeipmi.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/freeipmi.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/go.d.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/go.d.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/perf.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/perf.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/ndsudo" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/ndsudo" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/slabinfo.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/slabinfo.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/netword-viewer.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/netword-viewer.plugin" || true;
RUN [ -f "/usr/libexec/netdata/plugins.d/systemd-journal.plugin" ] && chmod 4755 "/usr/libexec/netdata/plugins.d/systemd-journal.plugin" || true;
RUN find /var/lib/netdata /var/cache/netdata -type d -exec chmod 0770 {} \;;
RUN find /var/lib/netdata /var/cache/netdata -type f -exec chmod 0660 {} \;;
RUN cp -va /etc/netdata /etc/netdata.stock;

CMD [ "/usr/sbin/netdata", "-u", "netdata", "-D", "-s", "/host", "-p", "8888" ]
