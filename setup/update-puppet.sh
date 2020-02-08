#!/bin/bash

echo 'Starting Puppet VM Provisioning'

# Install puppet
echo 'Puppet VM Provisioning: Installing puppet.'
rpm -Uvh https://yum.puppet.com/puppet6-release-el-5.noarch.rpm
yum -y install puppet-agent
echo 'PATH=$PATH:/opt/puppetlabs/bin' >> ~/.bash_profile
echo 'export PATH' >> ~/.bash_profile
. ~/.bash_profile

rvm use system
gem install librarian-puppet

# Install puppet modules.
echo 'Puppet VM Provisioning: Installing puppet modules.'
rm -Rf /vagrant/puppet/.librarian
rm -Rf /vagrant/puppet/.tmp
rm -Rf /vagrant/puppet/Puppetfile.lock

# Cleaning old modules, just in case.
rm -Rf /vagrant/puppet/modules/*

# Install gems for Puppet
cd /vagrant/puppet
LIBRARIAN_PUPPET_TMP=/tmp /usr/local/bin/librarian-puppet install

echo 'Finished basic VM Provisioning.'
