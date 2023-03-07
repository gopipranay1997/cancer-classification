# FROM jupyter/scipy-notebook
FROM ubuntu:latest

ENV http_proxy http://172.30.10.43:3128
ENV https_proxy http://172.30.10.43:3128

RUN apt-get update && apt-get install -y python && apt-get install -y python3-pip python3-dev && cd /usr/local/bin && ln -s /usr/bin/python3 python && pip3 install flask 

COPY HeartPrediction_Pranay .


RUN pip install joblib


USER root

RUN dpkg --configure -a
RUN apt-get update && apt-get install -y jq

RUN mkdir model raw_data processed_data results


ENV RAW_DATA_DIR=/home/jovyan/raw_data
ENV PROCESSED_DATA_DIR=/home/jovyan/processed_data
ENV MODEL_DIR=/home/jovyan/model
ENV RESULTS_DIR=/home/jovyan/results
ENV RAW_DATA_FILE=data.csv


COPY data.csv ./raw_data/data.csv
COPY preprocessing.py ./preprocessing.py
COPY train1.py ./train1.py
COPY test1.py ./test1.py


EXPOSE 5500

CMD ["python","app.py"]
