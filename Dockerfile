ARG USER=beanstalkd
FROM liammartens/alpine
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# @user Switch to root for install
USER root

# @run Install beanstalkd
RUN apk add --update beanstalkd

# @copy Copy additional run files
COPY .docker ${DOCKER_DIR}

# @run Make the file(s) executable
RUN chmod -R +x ${DOCKER_DIR}

# @user Back to non-root user
USER ${USER}

# @run Start beanstalkd
CMD [ "-c", "beanstalkd -l $BEANSTALKD_TCP -p $BEANSTALKD_PORT -V" ]