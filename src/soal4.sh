#ERENDIS
apt update && apt install bind`\9 -y

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
}

mkdir /etc/bind/kaisar
cp /etc/bind/db.local /etc/bind/kaisar/k59.com

nano /etc/bind/kaisar/k59.com
$TTL    604800
@       IN      SOA     ns1.k59.com. root.k59.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@ IN NS ns1.k59.com. 
@ IN NS ns2.k59.com. 
ns1 IN A 10.93.3.3 
ns2 IN A 10.93.3.4 
elendil IN A 10.93.1.2 
isildul IN A 10.93.1.3 
anarion IN A 10.93.1.4 
iriel IN A 10.93.1.5 
amandil IN A 10.93.1.6 
elros IN A 10.93.1.7 
galadriel IN A 10.93.2.2 
eleborn IN A 10.93.2.3 
oropher IN A 10.93.2.4 
gilgalad IN A 10.93.2.5 
celebrimbor IN A 10.93.2.6 
pharazon IN A 10.93.2.7 
aldarion IN A 10.93.4.2 
palantir IN A 10.93.4.3 
narvi IN A 10.93.4.4

nano /etc/bind/kaisar/3.93.10.in-addr.arpa
$TTL    604800
@       IN      SOA     ns1.k59.com. root.k59.com. (
                              2
                         604800
                          86400
                        2419200
                         604800 )
;
@       IN      NS      ns1.k59.com.
3       IN      PTR     ns1.k59.com.
4       IN      PTR     ns2.k59.com.

service bind9 restart
service bind9 status

#AMDIR
apt update && apt install bind9 -y
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
}

service bind9 restart
service bind9 status

#NODE LAIN
echo "nameserver 10.93.3.3" > /etc/resolv.conf
ping -c 3 palantir.k59.com
host -t A galadriel.k59.com
dig @10.93.3.4 k59.com
