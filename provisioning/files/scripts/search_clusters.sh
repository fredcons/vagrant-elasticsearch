#!/bin/bash

# Small utility script to test the carrot2 clustering plugin of elasticsearch
# can be used on the reuters index installed on this machine with : 
# ./search_clusters.sh reuters/articles chirac
# (yes these are old reuter news)


script_dir=$(readlink -f $(dirname $0))

# index_name should include type name as well, such as "reuters/articles" for example
index_name=$1
shift
search_string=$*

temp_query=search_clusters_query_$(date +%N|sed s/...$//).json
cp $script_dir/queries/search_clusters_query.json $script_dir/queries/$temp_query
sed -i "s/SEARCH_STRING/$search_string/" $script_dir/queries/$temp_query

temp_file=search_clusters_results_$(date +%N|sed s/...$//).json
temp_file_flat=search_clusters_results_$(date +%N|sed s/...$//).txt
curl -s -XPOST http://localhost:9200/$index_name/_search_with_clusters\?pretty --data-binary @$script_dir/queries/$temp_query > $temp_file 

cat $temp_file

#echo "*************"
echo "*  Clusters *"
#echo "*************"
cat $temp_file | jq '.clusters[] as $cluster | ("\($cluster.label);\($cluster.phrases | join(","));\($cluster.score);\($cluster.documents | join(",") )")' > $temp_file_flat 
#echo ""

echo "*************"
echo "*  Clusters *"
echo "*************"

while read cluster; do
  clean_cluster=$(echo "$cluster" | tr -d \")
  echo "Cluster : $(echo $clean_cluster | cut -d\; -f 1)"
  echo "Phrases : $(echo $clean_cluster | cut -d\; -f 2)" 
  echo "Score : $(echo $clean_cluster | cut -d\; -f 3)"
  docs=$(echo $clean_cluster | cut -d\; -f 4)
  echo "Matching documents : "
  for doc in ${docs//,/ }; do 
    curl -s -XGET http://localhost:9200/$index_name/$doc > doc.json
    echo " -  $(cat doc.json | jq '._source.title')" 
    rm -f doc.json
  done
  echo "----------------------------------------------------"
done < $temp_file_flat

rm -f $script_dir/queries/search_clusters_query_*.json 
rm -f $script_dir/search_clusters_results_*.json
rm -f $script_dir/search_clusters_results_*.txt


