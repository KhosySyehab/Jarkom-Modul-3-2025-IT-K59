# ADARION
nano /etc/dhcp/dhcpd.conf
# ========================================
# DHCP Server - Aldarion (K59)
# ========================================
default-lease-time 600;
max-lease-time 7200;
authoritative;
# --- Subnet Keluarga Manusia (Numenor)
subnet 10.93.1.0 netmask 255.255.255.0 {
    range 10.93.1.6 10.93.1.34;
    range 10.93.1.68 10.93.1.94;
    option routers 10.93.1.1;
    option broadcast-address 10.93.1.255;
    option domain-name-servers 10.93.5.2; # DNS Forwarder (Minastir)
    default-lease-time 600;
    max-lease-time 7200;
}

# --- Subnet Keluarga Peri (Elf)
subnet 10.93.2.0 netmask 255.255.255.0 {
    range 10.93.2.35 10.93.2.67;
    range 10.93.2.96 10.93.2.121;
    option routers 10.93.2.1;
    option broadcast-address 10.93.2.255;
    option domain-name-servers 10.93.5.2;
    default-lease-time 600;
    max-lease-time 7200;
}

# --- Subnet Khamul (Fixed IP)
subnet 10.93.3.0 netmask 255.255.255.0 {
    option routers 10.93.3.1;
    option broadcast-address 10.93.3.255;
    option domain-name-servers 10.93.5.2;
}

# --- Subnet DHCP Server sendiri (Aldarion)
subnet 10.93.4.0 netmask 255.255.255.0 {
    option routers 10.93.4.1;
    option broadcast-address 10.93.4.255;
}

# --- Fixed Address untuk Khamul
host Khamul {
    hardware ethernet <MAC_ADDRESS_KHAMUL>;
    fixed-address 10.93.3.95;
}

# ========================================
service isc-dhcp-server restart
service isc-dhcp-server status

# AMANDIL & GILGALAD
apt update && apt install isc-dhcp-client -y
ip addr flush dev eth0
dhclient -v eth0
ip a

#=======================================

ip addr add 10.93.1.0/24 dev eth0
ip route add default via 10.93.1.1