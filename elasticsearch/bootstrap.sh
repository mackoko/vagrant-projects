# install java
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre

sudo apt-get -y install oracle-java8-installer

# install elastic
#wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
#sudo apt-get update
#sudo apt-get -y install elasticsearch
sudo apt-get update
# sudo wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
# sudo dpkg -i elasticsearch-2.3.1.deb
sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.1.deb
sudo dpkg -i elasticsearch-5.3.1.deb

#elastic on localhost
sudo sed -i -e "s/\(network.host: \).*/\10.0.0.0/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/#network.host/network.host/g" /etc/elasticsearch/elasticsearch.yml

sudo sed -i 's/#START_DAEMON/START_DAEMON/' /etc/default/elasticsearch
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch
systemctl status elasticsearch

#sudo service /etc/init.d/elasticsearch restart

# https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04  - change file

# install kibana
#echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.4.x.list
#sudo apt-get update
#sudo apt-get -y install kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.3.1-amd64.deb
sudo dpkg -i kibana-5.3.1-amd64.deb

# kibana on localhost
sudo sed -i "s/#elasticsearch.url/elasticsearch.url/g" /etc/kibana/kibana.yml

sudo sed -i -e "s/\(server.host: \).*/\1\"0.0.0.0\"/" /etc/kibana/kibana.yml
sudo sed -i "s/#server.host/server.host/g" /etc/kibana/kibana.yml

sudo /bin/systemctl enable kibana.service
sudo systemctl restart kibana
systemctl status kibana
# sudo service kibana restart
# take a look https://github.com/stopsopa/elastic/blob/master/Vagrantfile

wget https://artifacts.elastic.co/downloads/logstash/logstash-5.3.1.deb
sudo dpkg -i logstash-5.3.1.deb

touch logstash-simple.conf
echo "input { stdin {} }" >> logstash-simple.conf
echo "output" >> logstash-simple.conf
echo "{" >> logstash-simple.conf
echo "elasticsearch { hosts => [\"10.0.0.10:9200\"] }" >> logstash-simple.conf
echo "stdout { codec => rubydebug }" >> logstash-simple.conf
echo "}" >> logstash-simple.conf
sudo cp logstash-simple.conf /etc/logstash/conf.d/logstash.conf

sudo /bin/systemctl enable logstash.service
sudo systemctl restart logstash
systemctl status logstash

# sudo chmod 777 /usr/share/logstash/data
# sudo chmod 777 /usr/share/logstash/data/*
# /usr/share/logstash/bin/logstash -f logstash-simple.conf 