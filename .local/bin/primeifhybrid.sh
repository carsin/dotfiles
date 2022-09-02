#!/bin/bash


if [[ $(supergfxctl -g) == "hybrid" ]]; then
    prime-run "$1"
else
    exec "$1"
fi
