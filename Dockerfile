from daocloud.io/python:2.7
RUN pip install --upgrade pip
RUN pip install tornado
COPY requirements.txt /
RUN pip install -r /requirements.txt
RUN mkdir /app
WORKDIR /app

RUN pip install supervisor
RUN echo_supervisord_conf > supervisord.conf && \
    echo "[include]" >> supervisord.conf && \
    echo "files = /etc/supervisord.d/*.ini" >> supervisord.conf
RUN mv supervisord.conf /etc/
COPY tornado.ini /etc/supervisord.d/
COPY run.sh /

EXPOSE 9021 
#CMD ["python", "-m", "tornado.autoreload", "server.py"]

# other operation for the specific app
RUN apt-get update
# RUN apt-get install -y libmysqld-dev
RUN apt-get install -y libpq-dev python-dev
COPY requirements-others.txt /
RUN pip install -v -r /requirements-others.txt
# 时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

ENTRYPOINT ["/run.sh"]
CMD ["bash", "-c"]
