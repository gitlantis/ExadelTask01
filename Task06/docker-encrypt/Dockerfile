FROM nginx:alpine

ENV DEVOPS=/run/secrets/my_secret

COPY *.html /usr/share/nginx/html
COPY create_onstart.sh /docker-entrypoint.d
RUN chmod +x /docker-entrypoint.d/create_onstart.sh