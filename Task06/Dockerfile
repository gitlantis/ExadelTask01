FROM nginx:alpine

ENV DEVOPS=/run/secrets/my_secret

COPY /docker-encrypt/*.html /usr/share/nginx/html
COPY /docker-encrypt/create_onstart.sh /docker-entrypoint.d
RUN chmod +x /docker-entrypoint.d/create_onstart.sh