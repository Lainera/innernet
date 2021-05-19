#!/bin/bash
set -e

DEFAULT_ARGS="--backend userspace"

innernet-server \
    $DEFAULT_ARGS \
    new \
    --network-name "evilcorp" \
    --network-cidr "10.66.0.0/16" \
    --external-endpoint "172.18.1.1:51820" \
    --listen-port 51820

innernet-server \
    $DEFAULT_ARGS \
    add-cidr evilcorp \
    --name "humans" \
    --cidr "10.66.1.0/24" \
    --parent "evilcorp" \
    --yes

innernet-server \
    $DEFAULT_ARGS \
    add-peer evilcorp \
    --name "admin" \
    --cidr "humans" \
    --admin true \
    --auto-ip \
    --save-config "peer1.toml" \
    --invite-expires "30d" \
    --yes

innernet-server $DEFAULT_ARGS serve evilcorp
