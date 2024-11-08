#!/bin/bash

url=$1

if [ ! -d "url" ]; then
    mkdir $url
fi


if [ ! -d "url/recon" ]; then
    mkdir $url/recon
fi

echo "[+] Getting subdomains..."
assetfinder $url >> $url/recon/sub_raw.txt
cat $url/recon/sub_raw.txt | grep $1 >> $url/recon/sub_final.txt   

echo "[+] Verifiying live subdomains..."
cat $url/recon/sub_final.txt | sort -u | httprobe | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/sub_live.txt
cat $url/recon/sub_live.txt


echo "[+] Enumerating ports and services..."
nmap -T5 -p- -A -iL $(pwd)/$url/recon/sub_live.txt -oA enumeration
cat enumeration.nmap./dc-build.sh
