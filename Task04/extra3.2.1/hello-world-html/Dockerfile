FROM nginx:latest

RUN apt update
RUN apt install -y curl
ENV DEVOPS="gitlantis"

COPY ./*.html /usr/share/nginx/html
COPY ./create_onstart.sh /docker-entrypoint.d
RUN chmod +x /docker-entrypoint.d/create_onstart.sh