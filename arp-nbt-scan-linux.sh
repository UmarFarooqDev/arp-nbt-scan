#!/bin/bash

#Forked from moleculea 10.10.2014
#Script flow:
#Obtain IP, Interface and Subnet Mask >
#Perform Arp-Scan against the range >
#Output Identified IPs to file
#Perform NBTSCAN on IPs in file
#Output data into file

# Version 0.0.2

#Obtain IP address, Interface and Subnet Mask

myip=`ip addr | grep global | awk '{print $2}'`
myiface=`ip -o link show | awk '{print $2,$9}' | grep UP | cut -d ':' -f1`

#Print out IP address, Interface and Subnet Mask

echo -e "Your Network Interface is \e[0;31m$myiface\e[0m"
echo -e "Your IP address and Netmask is \e[0;32m$myip\e[0m"
echo -e "Your Broadcast Address  is \e[0;33m$bybcast\e[0m"

#Sleep for 3 seconds

sleep 3

#Begin Arp-Scan

echo "Performing Arp-Scan"

#arp-scan {Specify Interface} [Interface] [Scan Source IP] {Print the 1st Column} {REGEX from Numbers} > [Output IPs to file]

arp-scan -I $myiface $myip | awk '{print $1}' | grep -E '^[0-9]+\.' > .arp-tmp

clear

sleep 3

echo -e "Found the following IPs"

cat .arp-tmp

sleep 3

echo -e "Beginning nbtscan"

nbtscan -f .arp-tmp
