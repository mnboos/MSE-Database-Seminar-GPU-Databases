FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Samuel Kurath <skurath@hsr.ch>

EXPOSE 5432

COPY entrypoint.sh /opt/pg-strom/
COPY start_postgres.sh /opt/pg-strom/
COPY postgresql.conf /opt/pg-strom/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


ENTRYPOINT ["./opt/pg-strom/entrypoint.sh"]

RUN apt-get update \
&& apt-get install wget build-essential vim supervisor software-properties-common git libpq-dev -y \
&& apt-get install postgresql postgresql-contrib postgresql-server-dev-9.5 -y \
&& cd /opt/pg-strom/ \
&& git clone https://github.com/heterodb/pg-strom.git pg_strom \
&& cd pg_strom \
&& git checkout STABLE_v1 \
&& make \
&& make install \
&& chmod +x /opt/pg-strom/entrypoint.sh \
&& chmod +x /opt/pg-strom/start_postgres.sh \
&& cp /opt/pg-strom/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf \
