#nginx with alpine
FROM nginx:alpine

#nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf

#copy html files
COPY ./*.html /usr/share/nginx/html/

ENV DEVOPS="gitlantis"