# This script launches and bootstraps an entire "production" environment from scratch.


# mongo
start_mongo () {
    mongo_cid=$(sudo docker run \
        -d \
        `# [commented out] -p 27017:27017` \
        -v `readlink -f ./conf/mongo`:/mongo \
        -v /mongo:/data \
        -name mongo-1 \
        mongo)
    if [ $? -eq 0 ]; then
        export mongo_cid="$mongo_cid"
        echo "Started mongo in container [\$mongo_cid] $mongo_cid".
        echo -n "Sleeping to let mongo start... "
        sleep 3
        echo "done."
    else
        echo $mongo_cid; return 1
    fi
}

# memcached
start_memcached () {
    memcached_cid=$(sudo docker run \
        -d \
        `# [commented out] -p 11211:11211` \
        -name memcached-1 \
        memcached)
    if [ $? -eq 0 ]; then
        export memcached_cid="$memcached_cid"
        echo "Started memcached in container [\$memcached_cid] $memcached_cid".
    else
        echo $memcached_cid; return 1
    fi
}

# rack
start_rack () {
    rack_cid=$(sudo docker run \
        -d \
        `# [commented out] -p 80:80` \
        -v `readlink -f ./app`:/app \
        -e "env=$env" \
        -expose 80 \
        -name app-1 \
        ruby \
        bash -c -l 'export MONGODB_URI="mongodb://mongo.live.docker:27017"; cd /app && bundle --deployment && bundle exec thin -R config.ru -p 80 start')
    if [ $? -eq 0 ]; then
        export rack_cid="$rack_cid"
        echo "Started app in container [\$rack_cid] $rack_cid".
    else
        echo $rack_cid; return 1
    fi
}

# nginx
start_nginx () {
    nginx_cid=$(sudo docker run \
        -d \
        -p 80:80 \
        -v `readlink -f ./conf/nginx`:/nginx \
        -v `readlink -f ./static`:/app \
        -v `readlink -f ./certs`:/certs \
        -name nginx-1 \
        nginx)
    if [ $? -eq 0 ]; then
        export nginx_cid="$nginx_cid"
        echo "Started nginx in container [\$nginx_cid] $nginx_cid".
    else
        echo $nginx_cid; return 1
    fi
}



# convenience functions to start / stop everything, clean up
start_all () {
    services="mongo memcached rack nginx"
    for service in $(echo $services); do
        start_$service
    done
}

stop_all () {
    sudo docker kill $nginx_cid $rack_cid $memcached_cid $mongo_cid
    sudo docker rm $nginx_cid $rack_cid $memcached_cid $mongo_cid
}

clean_up () {
    sudo docker ps -a -q | xargs sudo docker rm
}


restart_app () {
    sudo docker kill $nginx_cid
    sudo docker rm $nginx_cid
    sudo docker kill $rack_cid
    sudo docker rm $rack_cid
    start_rack
    start_nginx
}


build_all () {
    services="mongo memcached rack nginx"
    for service in $(echo $services); do
        sudo docker build -rm -t $service - < "$service".docker
    done
}





