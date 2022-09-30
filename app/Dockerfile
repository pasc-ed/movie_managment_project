FROM tiangolo/uwsgi-nginx-flask:python3.8-alpine

RUN apk --update add bash nano 
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev

ENV STATIC_URL /static
ENV STATIC_PATH /var/www/app/static

COPY ./requirements.txt /var/www/requirements.txt
RUN pip install -r /var/www/requirements.txt