#!/bin/bash

firewall-cmd --zone=internal --permanent --remove-port=0-65535/udp 
firewall-cmd --zone=internal --permanent --remove-port=0-65535/tcp 
firewall-cmd --zone=internal --permanent --add-source=10.0.0.0/16
firewall-cmd --zone=internal --permanent --add-service=ssh
firewall-cmd --zone=internal --permanent --remove-service=ipp-client
firewall-cmd --zone=internal --permanent --remove-service=mdns
firewall-cmd --zone=internal --permanent --remove-service=samba-client

firewall-cmd --zone=public --permanent --remove-port=0-65535/udp 
firewall-cmd --zone=public --permanent --remove-port=0-65535/tcp 
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --remove-service=dhcpv6-client

firewall-cmd --reload

