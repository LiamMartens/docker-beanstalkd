#!/bin/bash
export HOME=/home/$(whoami)

if [ -z "$BEANSTALKD_PORT" ]; then
	export BEANSTALKD_PORT=11300
fi

if [ -z "$TIMEZONE" ]; then
	export TIMEZONE='UTC'
fi

# get ip addresses and export them as environment variables
export BEANSTALKD_TCP=`awk 'END{print $1}' /etc/hosts`

# set timezone
cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime
echo $TIMEZONE > /etc/timezone

# run user scripts
if [[ -d ${ENV_DIR}/files/.$(whoami) ]]; then
	chmod +x ${ENV_DIR}/files/.$(whoami)/*
	run-parts ${ENV_DIR}/files/.$(whoami)
fi

# run beanstalkd
echo "Starting beanstalkd on $BEANSTALKD_PORT"
beanstalkd -l $BEANSTALKD_TCP -p $BEANSTALKD_PORT &

$SHELL