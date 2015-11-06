#/bin/bash

# create schema
echo "Creating index"
curl -XPUT http://localhost:9200/reuters  --data-binary @/etc/reuters/mappings.json
echo " "

# Import data
echo "Importing data"
curl -XPUT http://localhost:9200/reuters/articles/_bulk  --data-binary @/etc/reuters/articles.bulk.json
echo " "

# Count docs
echo "Counting imported docs"
curl -XGET http://localhost:9200/reuters/articles/_count
echo " "
