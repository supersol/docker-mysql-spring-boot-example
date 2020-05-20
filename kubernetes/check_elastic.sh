#!/bin/bash

# keeping this simple as possible
# can be implemented with different languages

# simple api call to elasticsearch with sample index
# query can vary depending on complexity
# count can be also parsed with grep/cut etc instead of jq
error_count=$(curl --silent \
                   -X GET "localhost:9200/test_index/_count" \
                   -H 'Content-Type: application/json' \
                   -d'{"query": { "simple_query_string":{"query": "Handbill not printed"}}}' | jq .count)

if [[ $error_count -gt 3 ]]; then
  # simple echo
  # can be more complex, like calling other api, sending email, etc.
  echo "Fire!"
fi
