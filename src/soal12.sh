# as root
apt update
apt install -y nginx php8.4-fpm php8.4-cli php8.4-curl php8.4-mbstring apache2-utils

# create web root
mkdir -p /var/www/html
cat > /var/www/html/index.php <<'PHP'
<?php
echo "hostname: " . gethostname();
?>
PHP

# enforce server_name only: in nginx server block (see next task)
