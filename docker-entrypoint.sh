#!/bin/sh
set -e

if [ "$1" = 'start' ]; then

  setConfiguration() {
    KEY=$1
    VALUE=$2
    sed -i "s/{{$KEY}}/$VALUE/g" ${TOPBEAT_HOME}/topbeat.yml
  }

  if [ -n "${LOGSTASH_HOST+1}" ]; then
    setConfiguration "LOGSTASH_HOST" "$LOGSTASH_HOST"
  else
    echo "LOGSTASH_HOST is needed"
    exit 1
  fi

  if [ -n "${LOGSTASH_PORT+1}" ]; then
    setConfiguration "LOGSTASH_PORT" "$LOGSTASH_PORT"
  else
    echo "LOGSTASH_PORT is needed"
    exit 1
  fi

  sed -i "s#{{CPU_PER_CORE}}#${CPU_PER_CORE:-false}#g" ${TOPBEAT_HOME}/topbeat.yml
  sed -i "s#{{PERIOD}}#${PERIOD:-10}#g" ${TOPBEAT_HOME}/topbeat.yml
  sed -i "s#{{PROCS}}#${PROCS:-.*}#g" ${TOPBEAT_HOME}/topbeat.yml
  sed -i "s#{{INDEX}}#${INDEX:-topbeat}#g" ${TOPBEAT_HOME}/topbeat.yml
  sed -i "s#{{SHIPPER_NAME}}#${SHIPPER_NAME}#g" ${TOPBEAT_HOME}/topbeat.yml
  sed -i "s#{{SHIPPER_TAGS}}#${SHIPPER_TAGS}#g" ${TOPBEAT_HOME}/topbeat.yml

  echo "Initializing Topbeat..."
  ${TOPBEAT_HOME}/topbeat -e -v -c ${TOPBEAT_HOME}/topbeat.yml

  wait
else
  exec "$@"
fi
