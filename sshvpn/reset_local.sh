
. vars

# Change default gw to internal gw
ip route del default
ip route add default via $INTERNAL_GW dev $INTERNAL_IF
