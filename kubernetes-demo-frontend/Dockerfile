FROM nginx:stable
# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

EXPOSE 8080

ADD nginx.default.conf /etc/nginx/conf.d/default.conf
ADD logger.sh .
ADD entrypoint.sh .
ADD gzipAssets.sh .

ADD build /var/www/html/kubernetes-demo-frontend
RUN chmod -R go+rw /var/www/html/kubernetes-demo-frontend

CMD ["sh", "./entrypoint.sh"]
