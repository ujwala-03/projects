import streamlit as st
import pickle
import pandas as pd
import numpy as np
import sklearn
from sklearn.preprocessing import RobustScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.neighbors import KNeighborsClassifier

st.title("Age group prediction")

age = st.number_input("Enter the age",min_value=12,max_value=81)
gender = st.number_input("Enter gender, male=1, female=2", min_value=1, max_value=2)
PIA = st.number_input("Enter physical activity status, yes=1, no=2", min_value=1, max_value=2)
BMI= st.number_input("Enter Body mass index", min_value=14.5, max_value=70.2)
GLU = st.number_input("Enter glucose", min_value=63, max_value=406)
DIA = st.number_input("Enter your diabetes status, yes=1, no=2, might be=3", min_value=1, max_value=3)
oral=st.number_input("Enter oral value", min_value=40, max_value=605)
INS=st.number_input("Enter insulin value", min_value=0.13, max_value=102.3)

with open("pickle_ml.pkl","rb")as f:
    model=pickle.load(f)

if st.button('submit'):
    pred=model.predict([[age, gender, PIA, BMI, GLU, DIA, oral, INS]])

    st.write(pred[0])
if st.button('Go to next page'):
    st.switch_page("pages/page2.py")