#!/bin/bash

set -e

if [ -d /vagrant/sync ] ; then
    vagrantsync=/vagrant/sync
elif [ -d /home/vagrant/sync ] ; then
    vagrantsync=/home/vagrant/sync
elif [ -d /vagrant ] ; then
    vagrantsync=/vagrant
else
    echo "Can't find sync directory!" >&2
    exit 1
fi

yum --nogpgcheck -y install \
    http://yum.puppetlabs.com/puppet5/puppet5-release-fedora-25.noarch.rpm
yum -y install puppet-agent

. /etc/profile.d/puppet-agent.sh

yum -y update

puppet apply "$vagrantsync"/manifests/server.pp
puppet apply "$vagrantsync"/manifests/ssh.pp
