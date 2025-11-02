nano /etc/bind/kaisar/k59.com
@       IN      A       10.93.1.2   ; Elendil
@       IN      A       10.93.1.3   ; Isildur
@       IN      A       10.93.1.4   ; Anarion

named-checkzone k59.com /etc/bind/kaisar/k59.com
rndc reload

apt-get update
apt-get install apache2 -y

echo "<h1>Welcome to Elendil - k59.com</h1>" > /var/www/html/index.html

service apache2 restart


echo "nameserver 10.93.3.3" > /etc/resolv.conf

dig k59.com
dig k59.com
dig k59.com

curl k59.com

