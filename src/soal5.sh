#ERENDIS ==============================================================
nano /etc/bind/kaisar/k59.com
www     IN  CNAME   elros.k59.com.
@       IN  TXT     "Kerajaan K59"

nano /etc/bind/kaisar/3.93.10.in-addr.arpa
7.1.93.10.in-addr.arpa. IN PTR elros.k59.com.

named-checkconf
named-checkzone k59.com /etc/bind/kaisar/k59.com
named-checkzone 3.93.10.in-addr.arpa /etc/bind/kaisar/3.93.10.in-addr.arpa
rndc reload

nano /etc/named.conf.local
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

named-checkconf
rndc reload
ls -l /var/lib/bind/
cat /var/lib/bind/k59.com

#PALANTIR ==============================================================
# Pastikan resolver diarahkan ke DNS Master atau Slave
echo "nameserver 10.93.3.3" > /etc/resolv.conf
# atau
echo "nameserver 10.93.3.4" > /etc/resolv.conf

# Uji domain utama
dig k59.com

# Uji alias (CNAME)
dig www.k59.com
host www.k59.com

# Uji TXT record
dig TXT k59.com

# Uji reverse DNS
dig -x 10.93.1.7

nano /etc/bind/kaisar/k59.com
nano /etc/bind/kaisar/3.93.10.in-addr.arpa
named-checkconf
named-checkzone k59.com /etc/bind/kaisar/k59.com
named-checkzone 3.93.10.in-addr.arpa /etc/bind/kaisar/3.93.10.in-addr.arpa
rndc reload
dig k59.com
dig www.k59.com
dig TXT k59.com
dig -x 10.93.1.7



