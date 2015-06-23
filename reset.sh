#!/bin/bash

echo "Deleting index companies_db" 
curl -XDELETE http://localhost:9200/companies_db
echo ""

echo "Creating mapping companies_db" 
curl -XPUT http://localhost:9200/companies_db --data-binary @provisioning/files/mappings.json
echo ""

echo "Importing data"
curl -s -XPUT http://localhost:9200/companies_db/companies/_bulk --data-binary @provisioning/files/companies.bulk.json > /dev/null

sleep 2
echo "Counting companies"
curl -XGET http://localhost:9200/companies_db/companies/_count
echo ""
