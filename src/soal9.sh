nano /etc/bind/kaisar/k59.com

; Delegasi untuk subdomain lorien.k59.com
lorien      IN      NS      ns1.lorien.k59.com.
ns1.lorien  IN      A       10.93.2.3

named-checkzone k59.com /etc/bind/kaisar/k59.com
rndc reload

mkdir -p /etc/bind/lorien

nano /etc/bind/lorien/lorien.k59.com
$TTL    604800
@       IN      SOA     ns1.lorien.k59.com. root.lorien.k59.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.lorien.k59.com.
ns1     IN      A       10.93.2.3

; contoh isi wilayah lorien
galadriel   IN  A       10.93.2.2
celeborn    IN  A       10.93.2.3
oropher     IN  A       10.93.2.4

nano /etc/bind/named.conf.local
zone "lorien.k59.com" {
    type master;
    file "/etc/bind/lorien/lorien.k59.com";
};

named-checkzone lorien.k59.com /etc/bind/lorien/lorien.k59.com
service bind9 restart

echo "nameserver 10.93.3.3" > /etc/resolv.conf

dig lorien.k59.com NS
dig galadriel.lorien.k59.com

