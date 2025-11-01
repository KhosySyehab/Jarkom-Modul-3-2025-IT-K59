# Adjust port and socket path per host:
NGINX_PORT=8004   # set 8005 on Celeborn, 8006 on Oropher
PHP_SOCK="/run/php/php8.4-fpm.sock"  # typical sock; or tcp 127.0.0.1:9000 if configured

cat > /etc/nginx/sites-available/peri.conf <<EOF
server {
    listen ${NGINX_PORT} default_server;
    server_name galadriel.k59.com; # change per host
    root /var/www/html;
    index index.php index.html;

    # only respond to matching host header
    if (\$host != 'galadriel.k59.com') { return 444; }

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        # forward real IP (later for soal 15)
        fastcgi_pass unix:${PHP_SOCK};
        fastcgi_index index.php;
    }
}
EOF

ln -sf /etc/nginx/sites-available/peri.conf /etc/nginx/sites-enabled/peri.conf
nginx -t && systemctl reload nginx
