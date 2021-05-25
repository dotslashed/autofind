#!/bin/bash

echo "Please enter your target domain in [example.com] format"


read TARGET

echo "[+] Finding subdomains using subfinder"

sleep 3

subfinder -d $TARGET -silent | httpx -silent | tee subdomains_found.txt


echo "[+] Finding subdomains using assetfinder"

sleep 3

assetfinder --subs-only $TARGET | httpx -silent | tee -a subdomains_found.txt


echo "[+] Finding subdomains using crtsh"

sleep 3

curl -sk "https://crt.sh/?q=$TARGET" | grep -oE "[a-zA-Z0-9._-]+\.$TARGET" | sed -e '/[A-Z]/d' -e '/*/d' | grep -oP '[a-z0-9]+\.[a-z]+\.[a-z]+' | httpx -silent | tee -a subdomains_found.txt

sleep 3

cat subdomains_found.txt | sort -u | tee final_subs.txt

echo "[+] Job completed successfully!!!"


