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
gem update --system --no-document
#gem install json_pure --no-document
gem update --no-document
gem install librarian-puppet --no-document

# Install puppet
echo 'Basic VM Provisioning: Installing puppet.'
rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet-agent
echo 'PATH=$PATH:/opt/puppetlabs/bin' >> ~/.bash_profile
echo 'export PATH' >> ~/.bash_profile
. ~/.bash_profile

# Install puppet modules.
echo 'Basic VM Provisioning: Installing puppet modules.'
if [ -f /vagrant/puppet/Puppetfile.lock ]; then
  rm /vagrant/puppet/Puppetfile.lock
fi

# Cleaning old modules, just in case.
if [ -f /vagrant/puppet/modules ]; then
  rm -Rf /vagrant/puppet/modules/*
fi


# Install gems for Puppet
cd /vagrant/puppet
/usr/local/bin/librarian-puppet install

echo 'Finished basic VM Provisioning.'
