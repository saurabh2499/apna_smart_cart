import os
import random
import numpy as np
import cv2
from sklearn.model_selection import train_test_split
from keras.models import load_model
from keras.utils import to_categorical
import time


#model = load_model('total1.h5')

folder = "E:\\source\\practice\\hackfest\\detect_model\\detect_model\\obj"
#i = 1
class Detect():
    
    def __init__(self):
        trained_model = "./total1.h5"
        self.model = load_model(trained_model)

    def switch(self, x):
        switcher = {

            0:"hand",
            1:"bottle",
            2:"disk",
            3:"snacks"}
        return switcher.get(x, 'nothing')



    def preprocess(self):
        #self.img = cv2.imread(os.path.join(folder,filename), cv2.IMREAD_COLOR)
        #self.img = cv2.imread(image, cv2.IMREAD_COLOR)
        self.img = cv2.resize(self.img, (10, 10))
        self.img = np.array(self.img)
        self.img = self.img.reshape(1, 10, 10, 3)

    def predict(self, img):
        self.img = img
        #self.img = self.img[:,:,::-1]
        self.preprocess()
        self.img = np.array(self.img)
        #self.img = self.img.reshape(1, 200, 200, 3)
        val = self.model.predict(self.img)
        val = np.argmax(val)
        print(val)
        return self.switch(val)


    #img_path = 'Put you image path'

    ###test image ###
    #img_path = 'E:\\source\\practice\\hackfest\\detect_model\\detect_model\\obj\\1.70.jpg'

    #img = cv2.imread(os.path.join(folder,filename), cv2.IMREAD_COLOR)
    #img = cv2.resize(img, (300, 300))
    #img = np.array(img)
    #img = img.reshape(1, 300, 300, 3)
    
    #k = model.predict(img)
    #k = np.argmax(k[0])
    #print("prediction is : {} .really is : {}".format(switch(k), switch(type_)))
    #print("time taken in detecting first object is {} s".format(time.time() - t))
    
    



