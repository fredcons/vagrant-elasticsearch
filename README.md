# vagrant-elasticsearch

A simple Vagrant VM exposing Elasticearch and Kibana, based on the precise64 Vagrant base box. 

## Usage

To launch the VM, use : 

```
vagrant up
# test ES
curl http://localhost:9200
# test kibana
curl http://localhost:5601
```

## Tools

[es2unix](https://github.com/elastic/es2unix) is available in the path.
The [bigdesk](http://bigdesk.org/) and [head](http://mobz.github.io/elasticsearch-head/) plugins are installed
VM provisioning is made with Ansible, with significant portions of code borrowed from [Traackr/ansible-elasticsearch](https://github.com/Traackr/ansible-elasticsearch)

## Todo
 
- package the VM and upload it to [Atlas](https://atlas.hashicorp.com/)
- install [es-reindex](https://github.com/geronime/es-reindex)
- provide indexable datasets
- install marvel
