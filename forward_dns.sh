#!/bin/bash
clear
if [[ -z "$1" ]]; then
echo "Usage:  ./forward_dns.sh <hostname> </path/to/subdomains>"
exit 0
fi
if [[ -z "$2" ]]; then
echo "Usage:  ./forward_dns.sh <hostname> </path/to/subdomains>"
exit 0
fi
echo "Discovered Host (A) records:"
for name in $(cat $2); do
  host -W 1 $name.$1 | grep "has address" | cut -d " " -f1,4 | grep $name | tee -a $1_results &
done
echo "Completed Forward DNS Lookups"
exit 0
