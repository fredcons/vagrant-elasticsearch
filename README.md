# vagrant-elasticsearch

A simple Vagrant VM exposing Elasticearch and Kibana, based on the precise64 Vagrant base box. 

## Usage with the source code

To launch the VM, use : 

```
git clone https://github.com/fredcons/vagrant-elasticsearch
cd vagrant-elasticsearch
vagrant box add hashicorp/precise64
vagrant up
vagrant ssh

# launch ES and Kibana (deliberately not launched on startup, for educational reasons :) )
sudo service elasticsearch start
sudo service kibana start
exit

# test ES
curl http://localhost:9200
# test kibana
curl http://localhost:5601
```

## Usage with Atlas

The resulting VM is available on Hashicorp's [Atlas platform](https://atlas.hashicorp.com/fredcons/boxes/elasticsearch-handson) (formerly Vagrant Cloud). Here are a few commands for a faster start up time (with a bigger download upfront) :

```
mkdir es-handson && cd es-handson
cat <<EOT >> Vagrantfile
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "fredcons/elasticsearch-handson"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 5601, host: 5601
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
end
EOT
vagrant up
vagrant ssh
```

The elasticsearch and kibana services should be manually started as well.

You may want to adjust the CPU / memory parameters.

## Tools

[es2unix](https://github.com/elastic/es2unix) is available in the path.   
The [marvel](https://www.elastic.co/products/marvel), [bigdesk](http://bigdesk.org/) and [head](http://mobz.github.io/elasticsearch-head/) plugins are installed.   
VM provisioning is made with Ansible, with significant portions of code borrowed from [Traackr/ansible-elasticsearch](https://github.com/Traackr/ansible-elasticsearch).   

## Datasets

This VM comes with two datasets :
- crunchbase : a database of startups. See /etc/crunchbase for mapping and data. Run ~/scripts/load_crunchbase.sh to generate an index on http://localhost:9200/crunchbase
- reuters : the well-knwon reuters news dataset. See /etc/reuters for mapping and data. Run ~/scripts/load_reuters.sh to generate an index on http://localhost:9200/reuters

## Todo
 
- install [es-reindex](https://github.com/geronime/es-reindex) or [elasticdump](https://github.com/taskrabbit/elasticsearch-dump/)
