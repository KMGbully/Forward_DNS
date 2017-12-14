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
# Find false positives
if [[ -f "false_pos" ]]; then
  rm -rf false_pos
  echo "Identifying False Positives:  "
  host -W 1 wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww.$1 | grep "has address" | cut -d " " -f4 | tee -a false_pos
  echo " "
  echo "Omitting results for above IP addresses"
else
  echo "Identifying False Positives:  "
  host -W 1 wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww.$1 | grep "has address" | cut -d " " -f4 | tee -a false_pos
  echo " "
  echo "Omitting results for above IP addresses"
fi
echo " "
echo "Discovered Host (A) records:"
for name in $(cat $2); do
  host -W 1 $name.$1 | grep "has address" | cut -d " " -f1,4 | grep -v -f false_pos | grep $name | tee -a $1_results &
done
rm -rf false_pos
echo " "
echo Completed Forward DNS Lookups. Outputs saved to $1_results
exit 0
