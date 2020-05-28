# EAP Wi-Fi lab
This lab starts wireless access point (hostap) and dhcp server with WPA2-EAP-PSK authentication.

EAP-TLS mode is still Work in Progress.

## Before start

- Edit the "INTERFACE" variable in the docker-compose.yml file.
- Disable Wi-Fi interface.

## Users credentials

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
After connection check it with 
```
$ curl 192.168.254.1
```