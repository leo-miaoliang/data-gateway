FROM python:3.7-stretch
# default to UAT to be backward compatible.
ARG BUILD_ENV=uat
ENV PYTHON_ENV=${BUILD_ENV}

RUN apt-get update && apt-get -y install logrotate nginx

#RUN pip install pipenv -i https://mirrors.aliyun.com/pypi/simple

COPY ./docker/nginx.conf 	/etc/nginx/sites-enabled/default.conf
COPY ./config/logrotate.d/* /etc/logrotate.d/
RUN mkdir -p /var/log/gunicorn

COPY ./docker/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

RUN mkdir -p /var/src
COPY . /var/src
RUN chmod +x /var/src/*.py
RUN pip install --requirement /var/src/requirements.txt

WORKDIR /var/src

EXPOSE 30010
ENTRYPOINT ["entrypoint.sh", "default"]