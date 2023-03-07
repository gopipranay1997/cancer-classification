FROM ubuntu:latest

ENV http_proxy http://172.30.10.43:3128
ENV https_proxy http://172.30.10.43:3128

RUN apt-get update && \
    apt-get install -y python && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install flask && \
    apt-get install -y jq && \
    pip install joblib
    
    
COPY HeartPrediction_Pranay .

RUN mkdir model raw_data processed_data results

ENV RAW_DATA_DIR=/home/jovyan/raw_data
ENV PROCESSED_DATA_DIR=/home/jovyan/processed_data
ENV MODEL_DIR=/home/jovyan/model
ENV RESULTS_DIR=/home/jovyan/results
ENV RAW_DATA_FILE=data.csv

COPY data.csv ./raw_data/
COPY preprocessing.py ./preprocessing.py
COPY train1.py ./train1.py
COPY test1.py ./test1.py

EXPOSE 5500

CMD ["python","app.py"]
