echo "Adding puppet repo"
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
echo "installing puppet"
sudo apt-get --assume-yes install puppet;
echo "ensure puppet service is running"
sudo puppet resource service puppet ensure=running enable=true
#echo "ensure puppet service is running"
#sudo puppet resource service puppetmaster ensure=running enable=true

echo "ensure puppet service is running for standalone install"
sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'
#http://stackoverflow.com/questions/21589388/does-vagrant-automatically-install-puppet