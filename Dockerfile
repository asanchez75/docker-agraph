
FROM centos:centos6
MAINTAINER Franz Support <support@franz.com>

ENV __VERSION__ 6.3.0
ENV __FINAL_VERSION__ 6.3.0
ENV __TGZ__ agraph-6.3.0-linuxamd64.64.tar.gz

RUN yum -y update
RUN yum clean all

RUN curl -f -o $__TGZ__ http://franz.com/ftp/pri/acl/ag/ag$__VERSION__/linuxamd64.64/$__TGZ__
#RUN curl -f -o $__TGZ__ https://bitbucket.org/asanchez75/docker-agraph/downloads/agraph-6.3.0-linuxamd64.64.tar.gz
RUN groupadd agraph \
    && useradd -d /data -g agraph agraph \
    && tar zxf $__TGZ__ \
    && rm -f $__TGZ__

RUN pushd agraph-$__FINAL_VERSION__ && \
       ./install-agraph /app/agraph -- --non-interactive \
       		--config-file /data/etc/agraph.cfg \
		--data-dir /data \
		--log-dir /data/log \
		--pid-file /data/var/agraph.pid \
		--runas-user agraph \
		--super-user test \
		--super-password xyzzy \
    && popd && rm -r agraph-$__FINAL_VERSION__
# Augment the config with a SessionPorts directive
RUN echo "SessionPorts 10000-10034" >> /data/etc/agraph.cfg

VOLUME /data

EXPOSE 10000-10034 10035

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
