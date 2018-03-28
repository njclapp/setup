#!/bin/bash

ufw enable
ufw deny from 192.168.1.1 to 224.0.0.1
ufw allow from 192.168.1.0/24 to any port 80
ufw allow from 192.168.1.0/24 to any port 137
ufw allow from 192.168.1.0/24 to any port 138
ufw allow from 192.168.1.0/24 to any port 139
ufw allow from 192.168.1.0/24 to any port 445
ufw allow from any to any port 1337
#ufw allow from 192.168.1.0/24 to any port 7777
ufw allow from 192.168.1.0/24 to any port 8112