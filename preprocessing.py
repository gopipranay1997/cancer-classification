import os
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pickle
# os.environ['RAW_DATA_DIR'] = "/home/k8user/heart-disease-jenkins/Heart-Disease-Prediction-main"
# os.environ["RAW_DATA_FILE"] = "/home/k8user/heart-disease-jenkins/Heart-Disease-Prediction-main/data.csv"
# Set path for the input
RAW_DATA_DIR = os.environ["RAW_DATA_DIR"]
RAW_DATA_FILE = os.environ["RAW_DATA_FILE"]
raw_data_path = os.path.join(RAW_DATA_DIR, RAW_DATA_FILE)
data = pd.read_csv(raw_data_path, sep=",")
X = data.drop(['Unnamed: 32', 'id', 'diagnosis'], axis=1)
y = pd.DataFrame(np.where(data['diagnosis']=='M',1,0), columns=['diagnosis'])
data1 = pd.concat([X,y], axis=1)
train, test = train_test_split(data1, test_size=0.2, stratify=data1['diagnosis'])


# Set path to the outputs
PROCESSED_DATA_DIR = os.environ["PROCESSED_DATA_DIR"]
train_path = os.path.join(PROCESSED_DATA_DIR, 'train.csv')
test_path = os.path.join(PROCESSED_DATA_DIR, 'test.csv')

# Save csv
train.to_csv(train_path, index=False)
test.to_csv(test_path,  index=False)
