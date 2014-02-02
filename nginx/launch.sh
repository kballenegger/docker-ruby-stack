echo "proxy_pass http://$APP_PORT_80_TCP_ADDR:$APP_PORT_80_TCP_PORT;" >/tmp/app_proxy_pass.nginx.conf
nginx -g "daemon off; error_log stderr;" -c /nginx/nginx.conf
