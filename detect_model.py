from db_management import Manage
from predict import Detect


#from PIL import Image
import matplotlib.pyplot as plt
import cv2
import numpy as np
import math
#import queue
import time
#import serial
#import imutils
#import cv2
import numpy as np
import argparse
#import time
from skimage.measure import compare_ssim as ssim

detect = Detect()
manager = Manage()

cap = cv2.VideoCapture(1)
print('a')
imageA = cv2.imread('ab164.png', cv2.IMREAD_COLOR)
print(type(imageA))
def mse(imageA, imageB):
	# the 'Mean Squared Error' between the two images is the
	# sum of the squared difference between the two images;
	# NOTE: the two images must have the same dimension
	err = np.sum((imageA.astype("float") - imageB.astype("float")) ** 2)
	err /= float(imageA.shape[0] * imageA.shape[1])
	
	# return the MSE, the lower the error, the more "similar"
	# the two images are
	return err

def crop(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    th, threshed = cv2.threshold(gray, 100, 255, cv2.THRESH_BINARY_INV)
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (11,11))
    morphed = cv2.morphologyEx(threshed, cv2.MORPH_CLOSE, kernel)
    cnts = cv2.findContours(morphed, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]
    cnt = sorted(cnts, key=cv2.contourArea)[-1]
    x,y,w,h = cv2.boundingRect(cnt)
    dst = img[y:y+h, x:x+w]
    return dst

def func(image):
    
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (5, 5), 0)
    thresh = cv2.threshold(gray, 45, 255, cv2.THRESH_BINARY)[1]
    thresh = cv2.erode(thresh, None, iterations=2)
    thresh = cv2.dilate(thresh, None, iterations=2)
    cnts,_ = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
    areas = [cv2.contourArea(c) for c in cnts]
    max_index = np.argmax(areas)
    c=cnts[max_index]
    M=cv2.moments(c)
    extTop=int(M['m10']/M['m00'])
    extBot=int(M['m01']/M['m00'])
    ext=(extTop,extBot)
    cv2.waitKey(0)
    return extBot
i = 0
while(1):
    i += 1
    if i < 100:
        ret, frame_ = cap.read()
        continue
    ret, frame = cap.read()
    #print("*")
    k = mse(imageA, frame)
    #print("k: {}".format(k))
    if k >2500 :
        print("#")
        pred = detect.predict(frame)
    #print(pred)
        plt.imsave(".\\blah\\new"+ str(i) +".png",frame)
        if pred == 'hand':
        #print("hand/blank")
            print("")

        else:
            print('*')
            ret, frame_ = cap.read()
            frame = crop(frame)
            frame_ = crop(frame_)
            t1 = func(frame)
            t2 = func(frame_)
            if t1 < t2:
                direction = 0
            else:
                direction = 1

            #manager.update(pred, direction)

            #while(True):
            #    ret, fr = cap.read()
            #    if detect.predict(fr) != pred:
            #        break
                #else:
                #    print('KL')
            print(pred, direction)
            manager.update(pred, direction)
 














































##detect = Detect()
##manager = Manage()
#def bytes_to_int(bytes):
#    result = 0
#    for b in bytes:
#        result = result * 256 + int(b) - 48
#    return result




#cap=cv2.VideoCapture(1)
#L=queue.Queue(maxsize=5)
#a=0
#b=0
#ArduinoSerial = serial.Serial('com5',9600)
#time.sleep(2)
#count=0
##i = 0
#while (count<10000000):

#    ret,frame=cap.read()
    
#    ca=0
#    cb=0
#    for i in range(5):
#        b=ArduinoSerial.read()
#        #if b != 0:
#         #   b = 1
#        #print(b)
#        #print('$')
#        #b=bytes_to_int(b)
#        #print(b)
#        #print("*")
#        if(b==0):
#            cb=cb+1
#        else:
#            ca=ca+1
#    if(ca<cb):
#        b=0
#    else:
#        b=1
#    print(b)
    
    
#    if(L.full()):
#        L.get()
#    L.put(frame)
    
#    if((a==0 and b==1)):
#        print('start detection')
#        motion=1
#        #count=0;
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        ret,frame=cap.read()
#        #img1=Image.fromarray(frame, 'RGB')
#        #print("frame is {}:".format(frame))
#        img1 = frame.astype(int)
#        #cv2.imshow('img', img1)
#        plt.imsave('ab'+ str(count) + '.png', img1)
#        print('saved')
#        #t1 = detect.preprocess(img1)
#        #t1=detect.predict(frame)

#        #return motion and img1

#        #while(count)
#    elif((a==1 and b==0)):
#        motion=0
#        print('detection off')
#        img1=L.get()
#        img1=img1.astype(int)
#        #t1=identify(img1)
#        #plt.imshow(img1)
#        plt.imsave('ab'+ str(count) + '.png', img1)
#        #if(t1==0):
#        #    continue
#        ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        #ret,frame=cap.read()
#        img2=frame.astype(int)
#        #t2=identify(img2)
#        plt.imsave('.\\blah\\ab' + str(count) + '.png', img2)
#        print('second_saved')
#        #if(t2==0):
#        #    motion=0
#            #return motion and img1
#        #else:
#        #    continue
#    a=b    
#    count=count+1


