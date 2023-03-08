FROM jupyter/scipy-notebook

ENV http_proxy http://172.30.10.43:3128
ENV https_proxy http://172.30.10.43:3128

USER root

RUN apt-get update && \
    apt-get install -y jq && \
    pip3 install flask && \
    pip install joblib && \
    dpkg --configure -a 
    
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

EXPOSE 5501

CMD ["python","app.py"]










# # FROM ubuntu:latest


# FROM jupyter/scipy-notebook


# ENV http_proxy http://172.30.10.43:3128
# ENV https_proxy http://172.30.10.43:3128

# # USER root
# RUN chmod 700 /var/lib/apt/lists/partial

# RUN apt-get update && pip3 install flask && apt-get install -y jq && pip install joblib
    
# #     apt-get install -y python && \
# #     apt-get install -y python3-pip python3-dev && \    

# RUN dpkg --configure -a
    
# COPY HeartPrediction_Pranay .

# RUN mkdir model raw_data processed_data results

# ENV RAW_DATA_DIR=/home/jovyan/raw_data
# ENV PROCESSED_DATA_DIR=/home/jovyan/processed_data
# ENV MODEL_DIR=/home/jovyan/model
# ENV RESULTS_DIR=/home/jovyan/results
# ENV RAW_DATA_FILE=data.csv

# COPY data.csv ./raw_data/
# COPY preprocessing.py ./preprocessing.py
# COPY train1.py ./train1.py
# COPY test1.py ./test1.py

# EXPOSE 5501

# CMD ["python","app.py"]
