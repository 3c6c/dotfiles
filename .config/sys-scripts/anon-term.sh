#!/bin/bash

echo "Current IP: $(curl ifconfig.me;printf '\n')"
sudo systemctl start tor
. torsocks on
echo "New IP: $(curl ifconfig.me;printf '\n')"
