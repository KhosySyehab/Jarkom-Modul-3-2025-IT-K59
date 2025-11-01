# create htpasswd file
htpasswd -b -c /etc/nginx/.peri_htpasswd noldor silvan

# then add to peri.conf inside server block, e.g. before location /:
# add:
# auth_basic "Restricted";
# auth_basic_user_file /etc/nginx/.peri_htpasswd;

# After editing, test & reload
nginx -t && systemctl reload nginx

