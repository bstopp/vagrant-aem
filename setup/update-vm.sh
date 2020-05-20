#!/bin/bash

echo 'Starting Basic VM Provisioning'

# Update the OS & Fix Guest Tools
echo 'Basic VM Provisioning: Updating the OS.'
yum update -y
yum install -y git
#/etc/init.d/vboxadd setup

# Update Ruby gems.
echo 'Basic VM Provisioning: Updating Ruby gems.'
yum install -y gcc ruby-devel rubygems

echo 'Basic VM Provisioning: Installing RVM'
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable

usermod -a -G rvm root
source /etc/profile.d/rvm.sh

rvm reload
rvm install 2.5
rvm use 2.5 --default

gem install librarian-puppet concurrent-ruby semantic_puppet deep_merge

echo 'Finished basic VM Provisioning.'
