# EAP Wi-Fi lab
This lab starts wireless access point (hostap) and dhcp server with WPA2-EAP-PEAP, WPA2-EAP-TTLS and WPA2-EAP-TLS authentication.

You can install ca.pem certificate to your client device for radius server validation.

## Before start

- Edit the "INTERFACE" variable in the docker-compose.yml file.
- Disable Wi-Fi interface.

## User credentials

|  Username 	|   Password  	|
|:---------:	|:-----------:	|
|    jsnow  	| password123 	|
|  hpotter  	|   Potter31  	|

## Usage
```
$ git clone https://github.com/zelfix/wifi-lab
$ cd wifi-lab 
$ docker-compose up
```

### Default SSID
wifi-lab-eap

### Testing
After connection you can check it with 
```
$ curl 192.168.254.1
```

Alternatively, you can check the connection using the eapol_test utility. http://deployingradius.com/scripts/eapol_test/
```
$ cd eap-test
$ eapol_test -c ./peap-mshapv2.conf
$ eapol_test -c ./tls.conf
$ eapol_test -c ./ttls-pap.conf
