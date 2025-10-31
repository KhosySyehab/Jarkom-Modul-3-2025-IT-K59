# Minastir
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

ip addr add 10.93.5.2/24 dev eth0
ip addr add 192.168.122.2/24 dev eth1
ip route add default via 10.93.5.1 dev eth0

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 192.168.122.1" >> /etc/resolv.conf

ping -c 3 8.8.8.8
ping -c 3 google.com

# Durin
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Node lain (contoh Amandil / Gilgalad)
ip route add default via <IP_GATEWAY_MENUJU_DURIN>
ping -c 3 google.com