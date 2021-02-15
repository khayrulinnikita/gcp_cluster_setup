#!/usr/bin/env bash

sudo apt update && sudo apt install -y python3-pip
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray && sudo pip3 install -r requirements.txt
