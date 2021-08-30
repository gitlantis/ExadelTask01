FROM nginx:alpine

ENV DEVOPS="gitlantis"

COPY ./*.html /usr/share/nginx/html
COPY ./create_onstart.sh /docker-entrypoint.d
RUN chmod +x /docker-entrypoint.d/create_onstart.sh