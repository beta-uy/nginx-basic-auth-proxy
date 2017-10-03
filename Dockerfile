FROM nginx:latest

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends -y wget ca-certificates apache2-utils && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

