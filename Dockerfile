from python:2.7
RUN pip install --upgrade pip
RUN pip install tornado
COPY requirements.txt /
RUN pip install -r /requirements.txt
RUN mkdir /app
WORKDIR /app
CMD ["python", "-m", "tornado.autoreload", "server.py"]
