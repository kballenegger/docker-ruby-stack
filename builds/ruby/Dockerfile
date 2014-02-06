# Kenji container
#
# Note: do not forget to map volumes and ports.


FROM centos

MAINTAINER Kenneth Ballenegger, kenneth@ballenegger.com

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# install epel
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# install ruby with rvm
RUN yum -y install which &&\
    ln -sf /proc/self/fd /dev/fd &&\
    curl -sSL https://get.rvm.io | bash -s stable &&\
    bash -l -c 'rvm install 2.1.0 && rvm use 2.1.0 --default'

WORKDIR /app
