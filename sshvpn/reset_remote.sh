
. vars

# Adapt to your remote server's original default gw
ip route del default
ip route add default dev $EXTERNAL_IF
