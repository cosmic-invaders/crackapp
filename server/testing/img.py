from flask import *
from PIL import Image
import io
import base64
import cv2 as cv
from roboflow import Roboflow
from flask_ngrok import run_with_ngrok
import matplotlib.pyplot as plt
from firebase_admin import credentials, initialize_app, storage
import datetime
import string

rf = Roboflow(api_key="DzJXlBY4OY5a7ohy6WQ2")

project = rf.workspace().project("car_dent_scratch_detection-1")
model = project.version(9).model
model.predict("car_dent.jpg").save("dent.jpg")
