#!/bin/bash

# Developer:   Jonathan Terrasi
# Version:     1.0
# Updated:     2021-09-19

# Description: Checks web server for proper TLS configuration, by making...
#              * HTTP connection to port 80
#              * HTTPS connection to port 443
#              * HTTP connection to port 443

# Arguments:   (optional) domain string (default: google.com)

DEF_URL="google.com"
checks=0

if [[ $# -eq 0 ]]; then
    URL=$DEF_URL
elif [[ $# -eq 1 ]]; then
    URL=$1
else
    echo "ERROR: Too many arguments passed. Pass only 1 argument." 
    exit 1
fi

HTTP80=$(curl -s http://$URL:80 | grep -E TITLE.*[0-9]{3} | cut -d " " -f 1 | cut -d ">" -f 2)
HTTPS443=$(curl -s https://$URL:443 | grep -E TITLE.*[0-9]{3} | cut -d " " -f 1 | cut -d ">" -f 2)
HTTP443=$(curl -s http://$URL:443 | grep -E TITLE.*[0-9]{3} | cut -d " " -f 1 | cut -d ">" -f 2)

# check HTTP ---> port 80 (expected: True)
if [[ $HTTP80 -ge 200 && $HTTP80 -lt 500 ]]; then
    echo "True"
    checks=$((checks+1))
else
    echo "False"
fi

# check HTTPS ---> port 443 (expected: True)
if [[ $HTTPS443 -ge 200 && $HTTPS443 -lt 500 ]]; then
    echo "True"
    checks=$((checks+1))
else
    echo "False"
fi

# check HTTPS -/-> 80 (expected: True)
if [[ $HTTP443 -ge 200 && $HTTP443 -lt 500 ]]; then
    echo "False"
else
    echo "True"
    checks=$((checks+1))
fi

# check if all checks passed
if [[ $checks -eq 3 ]]; then
    echo "All checks successfully passed."
else
    echo "Configuration errors detected."
fi
