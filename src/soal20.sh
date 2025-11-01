mkdir -p /var/cache/nginx/pharazon_cache
chown -R www-data:www-data /var/cache/nginx

# in /etc/nginx/conf.d/cache.conf (inside server block)
proxy_cache_path /var/cache/nginx/pharazon_cache levels=1:2 keys_zone=pharazon_cache:10m max_size=100m inactive=60m use_temp_path=off;

# example location
location / {
    proxy_cache pharazon_cache;
    proxy_cache_valid 200 302 10m;
    proxy_cache_valid 404 1m;
    add_header X-Cache-Status $upstream_cache_status;
    proxy_pass http://Kesatria_Lorien;
}

# first request - should be MISS
curl -i -u noldor:silvan http://pharazon.k59.com/ | egrep -i 'X-Cache-Status|HTTP/'

# second request - should be HIT
curl -i -u noldor:silvan http://pharazon.k59.com/ | egrep -i 'X-Cache-Status|HTTP/'


tar czvf /root/k59_test_results.tar.gz ~/ab_tests_k59 /root/ab_logs /root/elros_logs_k59 || true
