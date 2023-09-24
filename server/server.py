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

cred = credentials.Certificate(
    "crackapp-23e59-firebase-adminsdk-o18mf-aafa26780f.json")
initialize_app(
    cred, {'storageBucket': 'crackapp-23e59.appspot.com'})
app = Flask(__name__)
# run_with_ngrok(app)



@app.route('/')
def home():
    return jsonify({'message': 'hi'})






@app.route('/imageapi', methods=['POST'])
def crack_finder():
    image_str = request.json.get('image')
    image_bytes = base64.b64decode(image_str)
    image_file = io.BytesIO(image_bytes)

    image = Image.open(image_file)
    image = image.convert("RGB")
    image.save("K:/MistralHack/crackapp/server/test.jpg")
    
    rf = Roboflow(api_key="DzJXlBY4OY5a7ohy6WQ2")
    #########additional app keys##############
    # DzJXlBY4OY5a7ohy6WQ2
    # ao0gkNxhFLHpuGLDxLya
    # x9uX7YwqY57VddkIXY5L
    # ########crack###############
    project = rf.workspace().project("crack-shadyar-zhir")
    model = project.version(1).model
    model.predict("test.jpg").save("crack.jpg")
    
    # ##########dent##############
    # project = rf.workspace().project("dentsegmentation")
    # model = project.version(2).model
    # model.predict("test.jpg").save("dent.jpg")
    
    project = rf.workspace().project("car_dent_scratch_detection-1")
    model = project.version(9).model
    model.predict("test.jpg").save("dent.jpg")
    
    # project = rf.workspace().project("dent-7ltse")
    # model = project.version(2).model
    # model.predict("test.jpg").save("dent.jpg")


    Pred = Image.open('K:/MistralHack/crackapp/server/crack.jpg')
    pred2 = Image.open('K:/MistralHack/crackapp/server/dent.jpg')
    t_res = image.resize((250,200))
    pred_res = Pred.resize((250,200))
    pred_res_2 = pred2.resize((250,200))
    final = Image.new("RGB", (790, 200), "white")
    final.paste(t_res,(0,0))
    final.paste(pred_res,(270,0))
    final.paste(pred_res_2, (540, 0))
    final.save("K:/MistralHack/crackapp/server/final.jpg")
    
    with open('K:/MistralHack/crackapp/server/final.jpg', 'rb') as f:
        image_bytes = f.read()
        image_b64 = base64.b64encode(image_bytes).decode('utf-8')
        res = Response(image_b64, mimetype='text/plain')
        @res.call_on_close
        def handle_post_request_completion():
            # Code to be executed after the POST request is completed
            file_extension = 'jpg'
            destination_filename = generate_destination_filename(file_extension)
            fileName = "final.jpg"
            bucket = storage.bucket()
            blob = bucket.blob(destination_filename)
            blob.upload_from_filename(fileName)
            # Opt : if you want to make public access from the URL
            blob.make_public() 
        return res

    
def generate_destination_filename(file_extension):
    timestamp = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    return f"images/{timestamp}.{file_extension}"



if __name__ == '__main__':
    # app.run()  # for global deployment
    app.run(port=3001) # for local development
