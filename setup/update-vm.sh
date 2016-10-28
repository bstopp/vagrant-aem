#!/bin/bash

echo 'Starting Basic VM Provisioning'

# Update the OS & Fix Guest Tools
echo 'Basic VM Provisioning: Updating the OS.'
yum update -y
yum install -y git
yum install -y gcc ruby-devel rubygems
#/etc/init.d/vboxadd setup

# Update Ruby gems.
echo 'Basic VM Provisioning: Updating Ruby gems.'

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
rvm install 2.3
rvm use 2.3 --default


gem update --system --no-document
gem uninstall --all

echo 'Finished basic VM Provisioning.'
