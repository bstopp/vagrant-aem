#!/bin/bash

echo "Starting basic VM Provisioning"

# Update the OS & Fix Guest Tools
yum update -y
yum install -y git
yum install -y gcc ruby-devel rubygems
#/etc/init.d/vboxadd setup

# Update Ruby gems.
gem update --system --no-document
#gem install json_pure --no-document
gem update --no-document
gem install librarian-puppet --no-document

# Install puppet
rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet-agent
echo 'PATH=$PATH:/opt/puppetlabs/bin' >> ~/.bash_profile
echo 'export PATH' >> ~/.bash_profile

# Install puppet modules.
if [ -f /vagrant/puppet/Puppetfile.lock ]; then
	rm /vagrant/puppet/Puppetfile.lock
fi

# Install gems for Puppet
cd /vagrant/puppet
/usr/local/bin/librarian-puppet install

