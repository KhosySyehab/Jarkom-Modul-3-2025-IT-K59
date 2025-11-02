#ERENDIS ==============================================================
nano /etc/bind/kaisar/k59.com
; Delegasi ke Pharazon
routedns     IN  NS      pharazon.k59.com.
pharazon     IN  A       10.93.2.7

web     IN  A       10.93.1.7   ; Elros
web     IN  A       10.93.2.7   ; Pharazon

named-checkzone k59.com /etc/bind/kaisar/k59.com
rndc reload

#PHARAZON ==============================================================
apt-get update
apt-get install bind9 -y

mkdir -p /etc/bind/routedns

nano /etc/bind/named.conf.local
zone "routedns.k59.com" {
    type master;
    file "/etc/bind/routedns/routedns.k59.com";
};

nano /etc/bind/routedns/routedns.k59.com
$TTL 604800
@       IN      SOA     routedns.k59.com. root.routedns.k59.com. (
                        2       ; Serial
                        604800  ; Refresh
                        86400   ; Retry
                        2419200 ; Expire
                        604800) ; Negative Cache TTL

@       IN      NS      pharazon.k59.com.
@       IN      A       10.93.2.7
load1   IN      A       10.93.1.7
load2   IN      A       10.93.2.7

service bind9 restart


#PALANTIR ==============================================================
echo "nameserver 10.93.3.3" > /etc/resolv.conf
dig routedns.k59.com
dig load1.routedns.k59.com
dig load2.routedns.k59.com

dig web.k59.com
host web.k59.com


