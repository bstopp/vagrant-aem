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
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
rvm install 2.5
rvm use 2.5 --default


gem update --system --no-document
gem uninstall --all

echo 'Finished basic VM Provisioning.'
