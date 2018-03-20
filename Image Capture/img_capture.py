import cv2
import time
import os

cam = cv2.VideoCapture(0) #choose camera

img_counter = 0

dirname = r'C:\Users\Administrator\Desktop\temp_dir\imgs'
os.mkdir(dirname)  #creates directory for images called 'imgs'

while True:
    ret, frame = cam.read()
    #cv2.imshow("test.png", frame) #useful for debugging
    #names current image after the unix timestamp
    imgname = str(format(time.time()*1000, '.0f'))+'.jpg'
    cv2.imwrite(os.path.join(dirname,imgname), frame)

    #the rest of the code is useful when debugging,
    #but isn't necessary when running from the script 'data_capture.vbs'
    if not ret:
        break
    k = cv2.waitKey(1)

    if k%256 == 27:
        # ESC pressed
        print("Escape hit, closing...")
        break

cam.release()

cv2.destroyAllWindows()
