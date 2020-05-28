#!/bin/bash -e

# Check if running in privileged mode
if [ ! -w "/sys" ] ; then
    echo "[Error] Not running in privileged mode."
    exit 1
fi

# Default values
true ${INTERFACE:=wlan0}
true ${SUBNET:=192.168.254.0}
true ${AP_ADDR:=192.168.254.1}
true ${SSID:=dockerap}
true ${CHANNEL:=11}
true ${WPA_PASSPHRASE:=passw0rd}
true ${HW_MODE:=g}
true ${DRIVER:=nl80211}
true ${HT_CAPAB:=[HT40-][SHORT-GI-20][SHORT-GI-40]}
true ${MODE:=host}


if [ ! -f "/etc/hostapd.conf" ] ; then
    cat > "/etc/hostapd.conf" <<EOF
interface=${INTERFACE}
driver=${DRIVER}
ssid=${SSID}
hw_mode=${HW_MODE}
channel=${CHANNEL}

auth_algs=1
wpa_key_mgmt=WPA-EAP
wpa=2

nas_identifier=other

#FreeRADIUS Server Config
auth_server_addr=127.0.0.1
auth_server_port=1812
auth_server_shared_secret=radiusPassword1234

wpa_pairwise=CCMP
rsn_pairwise=CCMP
wpa_ptk_rekey=600
ieee80211n=1
ht_capab=${HT_CAPAB}
wmm_enabled=1 

#EAP Config 8021X
own_ip_addr=127.0.0.1
ieee8021x=1 
EOF

fi

if [ ! -f "/var/lib/dhcp/dhcpd.leases" ] ; then
    touch /var/lib/dhcp/dhcpd.leases
fi

# unblock wlan
rfkill unblock wlan

echo "Setting interface ${INTERFACE}"

# Setup interface and restart DHCP service 
ip link set ${INTERFACE} up
ip addr flush dev ${INTERFACE}
ip addr add ${AP_ADDR}/24 dev ${INTERFACE}

echo "Configuring DHCP server .."

cat > "/etc/dhcp/dhcpd.conf" <<EOF
option subnet-mask 255.255.255.0;
option routers ${AP_ADDR};
subnet ${SUBNET} netmask 255.255.255.0 {
  range ${SUBNET::-1}100 ${SUBNET::-1}200;
}
EOF

echo "Starting DHCP server .."
dhcpd ${INTERFACE}

echo "Starting HostAP daemon ..."
/usr/sbin/hostapd /etc/hostapd.conf 