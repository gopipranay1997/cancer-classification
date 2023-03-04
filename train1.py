import pandas as pd
import numpy as np

import json
import os
from joblib import dump
import pickle

from sklearn.model_selection import StratifiedKFold, cross_val_score
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC

# os.environ['PROCESSED_DATA_DIR'] = "/home/k8user/heart-disease-jenkins/Heart-Disease-Prediction-main"
# Set path to inputs
PROCESSED_DATA_DIR = os.environ["PROCESSED_DATA_DIR"]
train_data_file = 'train'
train_data_path = os.path.join(PROCESSED_DATA_DIR, train_data_file)
df = pd.read_csv(train_data_path, sep=",")
# Split data into dependent and independent variables
# Drop useless variables
X_train = df.drop(['diagnosis'], axis='columns')
y_train = df['diagnosis']
# Model 
logit_model = LogisticRegression(max_iter=10000)
logit_model = logit_model.fit(X_train, y_train)

# Cross validation
cv = StratifiedKFold(n_splits=3) 
val_logit = cross_val_score(logit_model, X_train, y_train, cv=cv).mean()

# Validation accuracy to JSON
train_metadata = {
    'validation_acc': val_logit
}
