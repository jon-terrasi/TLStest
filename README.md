# TLStest

## Overview

This simple Bash script tests the TLS and port configurations for web servers. Web server configuration using TLS encryption should allow non-TLS HTTP connections to port 80, allow TLS-encrypted HTTPS connections to port 443, and reject unencrypted HTTP connection attempts to port 80. This script verifies whether or not this behavior was successfully configured.

## Installation

Clone this project in the desired local directory.

## Usage

After cloning this project, give `test.sh` executable permission. Then execute the script in a Bash shell. 

You may optionally pass a domain (i.e. without the HTTP/HTTPS protocol) as an argument to test that domain's TLS configurations. Otherwise, the default domain of `google.com` will be used.
