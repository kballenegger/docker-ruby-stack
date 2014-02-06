# Memcached container
#
# Note: do not forget to map ports.


FROM centos

MAINTAINER Kenneth Ballenegger, kenneth@ballenegger.com

RUN yum -y install memcached

EXPOSE 11211

ENTRYPOINT ["memcached", "-u", "root"]
