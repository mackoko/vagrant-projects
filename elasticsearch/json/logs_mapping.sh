curl -H 'Content-Type: application/json' -XPUT http://10.0.0.10:9200/logstash-2015.05.18 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
';
curl -H 'Content-Type: application/json' -XPUT http://10.0.0.10:9200/logstash-2015.05.19 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
';
curl -H 'Content-Type: application/json' -XPUT http://10.0.0.10:9200/logstash-2015.05.20 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
';
