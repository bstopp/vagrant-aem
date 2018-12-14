#!/bin/bash

echo 'Starting Puppet VM Provisioning'

# Install puppet
echo 'Puppet VM Provisioning: Installing puppet.'
rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet
echo 'PATH=$PATH:/opt/puppetlabs/bin' >> ~/.bash_profile
echo 'export PATH' >> ~/.bash_profile
. ~/.bash_profile

gem install librarian-puppet --no-document

# Install puppet modules.
echo 'Puppet VM Provisioning: Installing puppet modules.'
rm -Rf /vagrant/puppet/.librarian
rm -Rf /vagrant/puppet/.tmp
if [[ -f /vagrant/puppet/Puppetfile.lock ]]; then
  rm /vagrant/puppet/Puppetfile.lock
fi

# Cleaning old modules, just in case.
if [[ -e /vagrant/puppet/modules ]]; then
	rm -Rf /vagrant/puppet/modules/*
fi

# Install gems for Puppet
cd /vagrant/puppet
librarian-puppet install

echo 'Finished basic VM Provisioning.'
