# Front-End - Build - Dockerfile
#
# VERSION               0.0.1

FROM nginx

MAINTAINER Bruno Reato
ADD properties.js.template /tmp/properties.js.template

#Entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
