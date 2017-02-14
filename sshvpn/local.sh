
. vars

# Create a pair of tun interfaces between local server and remote server
#ssh -f -w $TUN_INDEX:$TUN_INDEX $EXTERNAL_IP -p $SSH_PORT true


ifconfig $TUN_NAME up
ip addr add dev $TUN_NAME $TUN_LOCAL_IP
ip route add $TUN_NET dev $TUN_NAME


#ip route del default
#ip route add default via $TUN_PEER_IP dev $TUN_NAME

# Some IPs should also go with local gateway:
# EXTERNAL_IP should be accessible from local server
ip route add $EXTERNAL_IP via $INTERNAL_GW dev $INTERNAL_IF
# I want INTERNAL_DNS also accessible because it does not belong to INTERNAL_NET
ip route add $INTERNAL_DNS via $INTERNAL_GW dev $INTERNAL_IF
# INTERNAL_NET should not go to VPN
ip route add $INTERNAL_NET via $INTERNAL_GW dev $INTERNAL_IF


