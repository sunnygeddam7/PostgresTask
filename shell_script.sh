#!/bin/bash

log_file="httpd.log"

# Count total hits by IP address
echo " Count total hits by IP address: "
awk '{print $1}' "$log_file" | sort -n | uniq -c

# Count hits by date
echo " Count hits by date: "
awk -F' ' '{print $4}' "$log_file" | cut -d':' -f1 | sort | uniq -c

# Generate a file with a list of all IP addresses
echo "Generate a file with a list of all IP addresses: "
awk '{print $1}' "$log_file" | sort -u   > ./shell/ip_addresses.txt

# Count hits day-wise and IP address-wise
echo "Count hits day-wise and IP address-wise: "
awk -F' ' '{print $1" "$4}' "$log_file" | sort | uniq -c 

#  individual unique URLs
echo "individual unique URLs: "
awk '{print $11}' "$log_file" | uniq 

# Count success hits by day
echo "Count success hits by day: "
grep 'HTTP/1.1" 200' "$log_file" | cut -d'[' -f2 | cut -d':' -f1 | sort | uniq -c 

# Count URLs with gif/png/jpeg/jpg extensions
echo "Count URLs with gif/png/jpeg/jpg extensions: "
grep -Eo 'GET\s([^[:space:]]+\.(gif|png|jpeg|jpg))' httpd.log | wc -l 
 
#Create a file with IP address, date, Complete URL, sucess/failure
echo "creating a file with IP address, date, Complete URL, sucess/failure"
awk '/(gif|png|jpeg|jpg)/ {split($4, date, "[/:]"); split($7, url, "\""); status = ($9 == "200") ? "Success" : "Failure"; print $1, date[2], date[1], date[3], $7, status}' httpd.log 
