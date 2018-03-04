ARG USER=beanstalkd
FROM liammartens/alpine
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# @env default beanstalkd port
ENV BEANSTALKD_PORT=11300

# @user Switch to root for install
USER root

# @run Install beanstalkd
RUN apk add --update beanstalkd

# @user Back to non-root user
USER ${USER}

# @healthcheck Simple beanstalkd connection healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD nc -z 127.0.0.1 "${BEANSTALKD_PORT}" || exit 1

# @run Start beanstalkd
CMD [ "-c", "beanstalkd -l 0.0.0.0 -p ${BEANSTALKD_PORT} -V" ]