#!/usr/bin/env bash

# Get running container's IP
IP=`hostname --ip-address`

if [ $# == 1 ]; then SEEDS="$1,$HOST"; 
else SEEDS="$HOST"; fi


# Dunno why zeroes here
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CASSANDRA_CONFIG/cassandra.yaml

# Set broadcast_rpc_address
sed -i -e "s/^# broadcast_rpc_address.*/broadcast_rpc_address: $HOST/" $CASSANDRA_CONFIG/cassandra.yaml

# Be your own seed
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEEDS\"/" $CASSANDRA_CONFIG/cassandra.yaml

# Listen on IP:port of the container
sed -i -e "s/^listen_address.*/listen_address: $IP/" $CASSANDRA_CONFIG/cassandra.yaml

# Broadcast on IP:port of the container
sed -i -e "s/^# broadcast_address.*/broadcast_address: $HOST/" $CASSANDRA_CONFIG/cassandra.yaml


cassandra -f
