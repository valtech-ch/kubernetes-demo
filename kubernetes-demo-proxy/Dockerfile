FROM nginx:stable

LABEL vendor=Valtech \
  name=kubernetes-demo-proxy

RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

ADD logger.sh .
ADD entrypoint.sh .

EXPOSE 8080

ADD nginx.default.conf.tmpl /etc/nginx/conf.d/default.conf.tmpl
ADD nginx-gzip.conf /etc/nginx/conf.d/nginx-gzip.conf

CMD ["sh", "./entrypoint.sh"]
