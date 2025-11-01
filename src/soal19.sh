+limit_req_zone $binary_remote_addr zone=one:10m rate=10r/s;

server {
    # ... existing server block ...
    location / {
        limit_req zone=one burst=20 nodelay;
        proxy_pass http://...; # or fastcgi_pass for Elros
    }
}


# generate high concurrency load to see 429 responses
ab -n 2000 -c 50 "http://elros.k59.com/api/airing/" > ab_rate_limit.txt 2>&1
# check nginx error/access logs for 429 entries:
grep " 429 " /var/log/nginx/access.log || true
