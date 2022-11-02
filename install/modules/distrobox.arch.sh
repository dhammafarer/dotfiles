#!/bin/bash

mkdir -p ~/box/arch

distrobox-create --image docker.io/library/archlinux:latest --name arch --home ~/box/arch
