# Mongo container
#
# Note: do not forget to map volumes and ports.


FROM centos

MAINTAINER Kenneth Ballenegger, kenneth@ballenegger.com

# install mongo
RUN touch /etc/yum.repos.d/mongodb.repo &&\
    echo '[mongodb]' >> /etc/yum.repos.d/mongodb.repo &&\
    echo 'name=MongoDB Repository' >> /etc/yum.repos.d/mongodb.repo &&\
    echo 'baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/' >> /etc/yum.repos.d/mongodb.repo &&\
    echo 'gpgcheck=0' >> /etc/yum.repos.d/mongodb.repo &&\
    echo 'enabled=1' >> /etc/yum.repos.d/mongodb.repo &&\
    yum -y install mongo-10gen-server

EXPOSE 27017

ENTRYPOINT ["mongod", "-f", "/mongo/mongod.conf"]
