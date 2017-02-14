
. vars

ifconfig $TUN_NAME up
ip addr add dev $TUN_NAME $TUN_PEER_IP
ip route add $TUN_NET dev $TUN_NAME

# set snat on remte for forwarding
# iptables -t nat -A POSTROUTING -o $EXTERNAL_IF -j SNAT --to-source $EXTERNAL_IP

