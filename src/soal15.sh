location ~ \.php$ {
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param REMOTE_ADDR $remote_addr;
    fastcgi_param HTTP_X_REAL_IP $remote_addr;
    fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    fastcgi_index index.php;
}


<?php
echo "hostname: " . gethostname() . PHP_EOL;
$ip = $_SERVER['HTTP_X_REAL_IP'] ?? $_SERVER['REMOTE_ADDR'] ?? 'unknown';
echo "visitor_ip: " . $ip;
?>
