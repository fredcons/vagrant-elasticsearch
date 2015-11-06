#!/bin/bash

echo "Deleting index crunchbase" 
curl -XDELETE http://localhost:9200/crunchbase
echo ""

echo "Creating mapping crunchbase" 
curl -XPUT http://localhost:9200/crunchbase --data-binary @provisioning/files/mappings.json
echo ""

echo "Importing data"
curl -s -XPUT http://localhost:9200/crunchbase/companies/_bulk --data-binary @provisioning/files/companies.bulk.json > /dev/null

sleep 2
echo "Counting companies"
curl -XGET http://localhost:9200/crunchbase/companies/_count
echo ""
