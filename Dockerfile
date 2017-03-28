FROM alpine:edge
MAINTAINER Liam Martens (hi@liammartens.com)

# add beanstalkd user
RUN adduser -D beanstalkd

# run updates
RUN apk update && apk upgrade

# add some default packages
RUN apk add tzdata perl curl bash git

# install beanstalkd
RUN apk add beanstalkd

# chown timezone files
RUN touch /etc/timezone /etc/localtime && \
    chown beanstalkd:beanstalkd /etc/localtime /etc/timezone

# copy run file
COPY scripts/run.sh /home/beanstalkd/run.sh
RUN chmod +x /home/beanstalkd/run.sh

ENTRYPOINT ["/home/beanstalkd/run.sh", "su", "-m", "beanstalkd", "-c", "/bin/sh"]