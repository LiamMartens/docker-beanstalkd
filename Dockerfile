ARG USER='beanstalkd'
FROM liammartens/alpine
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# install beanstalkd
RUN apk add beanstalkd

# copy run file
COPY scripts/run.sh ${ENV_DIR}/scripts/continue.sh
RUN chmod +x ${ENV_DIR}/scripts/continue.sh