nano /etc/bind/named.conf.local
zone "k59.com" {
    type master;
    file "/etc/bind/kaisar/k59.com";
    allow-transfer { 10.93.3.4; };
};

zone "3.93.10.in-addr.arpa" {
    type master;
    file "/etc/bind/kaisar/3.93.10.in-addr.arpa";
    allow-transfer { 10.93.3.4; };
};

mkdir -p /etc/bind/kaisar

nano /etc/bind/kaisar/3.93.10.in-addr.arpa
$TTL    604800
@       IN      SOA     ns1.k59.com. root.k59.com. (
                            2       ; Serial
                       604800       ; Refresh
                        86400       ; Retry
                      2419200       ; Expire
                       604800 )     ; Negative Cache TTL
;

@       IN      NS      ns1.k59.com.
@       IN      NS      ns2.k59.com.

3       IN      PTR     ns1.k59.com.
4       IN      PTR     ns2.k59.com.
2       IN      PTR     galadriel.k59.com.
3       IN      PTR     celebron.k59.com.
4       IN      PTR     oropher.k59.com.
1       IN      PTR     durin.k59.com.

named-checkzone 3.93.10.in-addr.arpa /etc/bind/kaisar/3.93.10.in-addr.arpa
rndc reload

nano /etc/bind/named.conf.local
zone "k59.com" {
    type slave;
    masters { 10.93.3.3; };
    file "/var/lib/bind/k59.com";
};

zone "3.93.10.in-addr.arpa" {
    type slave;
    masters { 10.93.3.3; };
    file "/var/lib/bind/3.93.10.in-addr.arpa";
};

service bind9 restart

echo "nameserver 10.93.3.3" > /etc/resolv.conf

host 10.93.3.3
dig -x 10.93.3.3
dig -x 10.93.2.2

