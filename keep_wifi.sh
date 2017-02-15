#!/bin/bash

cd /root/

. sshvpn/vars

while true; do

# Check sshvpn if workable
if ping -I tun$TUN_INDEX -c1 $TUN_PEER_IP >/dev/null; then
   echo "ssh vpn working"
   sleep 60
   continue
fi

# check if the target external ip is reachable
if ! ping -c1 $EXTERNAL_IP >/dev/null ; then
  echo "remote ip: $EXTERNAL_IP is not reachable, wait till it is reachble"
  sleep 60
  continue
fi

echo "ssh vpn not working, recreate it.."

killall ssh

# recreate sshvpn if not
ssh -f -w $TUN_INDEX:$TUN_INDEX $EXTERNAL_IP -p $SSH_PORT true

cd /root/sshvpn && ./local.sh

ssh  $EXTERNAL_IP -p $SSH_PORT "cd /root/sshvpn && ./remote.sh"

# restart wifi
service hostapd restart

done
