nano /etc/bind/lorien/lorien.k59.com
; Subdomain operation untuk Palantir
operation   IN  A       10.93.4.3

; Alias / CNAME agar mudah diakses
op          IN  CNAME   operation.lorien.k59.com.


named-checkzone lorien.k59.com /etc/bind/lorien/lorien.k59.com
service bind9 restart

echo "nameserver 10.93.3.3" > /etc/resolv.conf

dig operation.lorien.k59.com
dig op.lorien.k59.com
