# Nginx container
#
# Note: do not forget to map volumes and ports.


FROM centos

MAINTAINER Kenneth Ballenegger, kenneth@ballenegger.com

# install nginx
RUN touch /etc/yum.repos.d/nginx.repo &&\
    echo '[nginx]' >> /etc/yum.repos.d/nginx.repo &&\
    echo 'name=nginx repo' >> /etc/yum.repos.d/nginx.repo &&\
    echo 'baseurl=http://nginx.org/packages/centos/6/x86_64' >> /etc/yum.repos.d/nginx.repo &&\
    echo 'gpgcheck=0' >> /etc/yum.repos.d/nginx.repo &&\
    echo 'enabled=1' >> /etc/yum.repos.d/nginx.repo &&\
    yum -y install nginx

EXPOSE 80

CMD bash -l /nginx/launch.sh
