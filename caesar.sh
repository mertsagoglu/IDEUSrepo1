#!/bin/bash

usage() {
    echo "usage: caesar.sh [rotation]"
    exit 1
}

# handle -h
if [[ "$1" == "-h" ]]; then
    usage
fi

# determine rotation
if [[ -z "$1" ]]; then
    ROT=13
else
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        usage
    fi
    ROT=$(( $1 % 26 ))
fi

SRC_UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
SRC_LOW="abcdefghijklmnopqrstuvwxyz"

# build rotated sets (IMPORTANT: MUST BE IN ONE LINE)
TGT_UP="${SRC_UP:ROT}${SRC_UP:0:ROT}"
TGT_LOW="${SRC_LOW:ROT}${SRC_LOW:0:ROT}"

# perform translation
tr "$SRC_UP$SRC_LOW" "$TGT_UP$TGT_LOW"

