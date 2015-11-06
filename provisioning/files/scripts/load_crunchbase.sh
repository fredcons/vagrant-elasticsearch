#/bin/bash

# create schema
echo "Creating index"
curl -XPUT http://localhost:9200/crunchbase  --data-binary @/etc/crunchbase/mappings.json
echo " "

# Import data
echo "Importing data"
curl -XPUT http://localhost:9200/crunchbase/companies/_bulk  --data-binary @/etc/crunchbase/companies.bulk.json
echo " "

#Count docs
echo "Counting imported docs"
curl -XGET http://localhost:9200/crunchbase/companies/_count
echo " "

