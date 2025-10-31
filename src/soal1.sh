# DURIN
ip addr add 192.168.122.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.168.122.1
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#NODE LAIN
ip route add default via <IP_SUBNET_MASING2>
#ip route add default via 10.93.1.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
ping -c 3 8.8.8.8
ping -c 3 google.com
