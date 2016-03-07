[![](https://badge.imagelayers.io/jonnybgod/topbeat:latest.svg)](https://imagelayers.io/?images=jonnybgod/topbeat:latest)

# What is Topbeat?
Topbeat is the Beat used for server monitoring. It is a lightweight agent that installed on your servers, reads periodically system wide and per process CPU and memory statistics and indexes them in Elasticsearch.

![alt text](https://static-www.elastic.co/assets/blta28996a125bb8b42/packetbeat-fish-nodes-bkgd.png?q=755 "Packetbeat logo")

> https://www.elastic.co/products/beats/topbeat

# Why this image?

This runs the Topbeat agent inside it's own container, but by mounting the network host it is able to see the traffic from the other containers or from the applications running on the hosts.

# How to use this image
Build with:

```bash
docker build -t topbeat .
```

Start Topbeat as follows:

```bash
docker run -d \
  --pid=host \
  -e LOGSTASH_HOST=monitoring.xyz -e LOGSTASH_PORT=5044 \
  topbeat
```

Two environment variables are needed:
* `LOGSTASH_HOST`: to specify on which server runs your Logstash
* `LOGSTASH_PORT`: to specify on which port listens your Logstash for beats inputs

Optional variables:
* `CPU_PER_CORE`: to specify cpu usage per core (default: false)
* `PERIOD`: to specify how often to read server statistics (default: 10)
* `PROCS`: to specify regular expression to match the processes that are monitored (default: .*)
* `INDEX`: to specify the elasticsearch index (default: topbeat)
* `LOG_LEVEL`: to specify the log level (default: error) 
* `SHIPPER_NAME`: to specify the Topbeat shipper name (default: the container ID)
* `SHIPPER_TAGS`: to specify the Topbeat shipper tags

The docker-compose service definition should look as follows:
```yalm
topbeat:
  image: jonnybgod/topbeat
  restart: unless-stopped
  pid: host
  environment:
   - LOGSTASH_HOST=monitoring.xyz
   - LOGSTASH_PORT=5000
```
