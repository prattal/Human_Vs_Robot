#skeleton_capture.py
#authored by Shay Merley merleyst@rose-hulman.edu
#This code tracks a person's upper body joint positions using an xbox 360 kinect and writes
#them to a csv file with respect to time.
#based heavily on example code found at https://github.com/malmaladei/kinectpy_test/blob/master/KinectPy-test/vpykinect.py

from visual import *
import pykinect
from pykinect import nui
from pykinect.nui import JointId
import os
import sys
import time
from time import strftime
import numpy as np
import cv2
import datetime



class Skeleton:
    """Kinect skeleton represented as a VPython frame.
    """

    def __init__(self, f):
        """Create a skeleton in the given VPython frame f.
        """
        self.frame = f
        self.joints = [sphere(frame=f, radius=0.08, color=color.yellow)
                       for i in range(20)]
        self.joints[3].radius = 0.125
        self.joints[11].color = color.blue
        #we only care about the upper body, so we make the lower joints invisible in the viewing window
        self.joints[0].radius = 0
        self.joints[1].radius = 0
        self.joints[12].radius = 0
        self.joints[13].radius = 0
        self.joints[14].radius = 0
        self.joints[15].radius = 0
        self.joints[16].radius = 0
        self.joints[17].radius = 0
        self.joints[18].radius = 0
        self.joints[19].radius = 0
        self.bones = [cylinder(frame=f, radius=0.05, color=color.yellow)
                      for bone in _bone_ids]
        #named joints (it just makes things easier)
        self.centerHip = self.joints[0]
        self.lowerSpine=self.joints[1]
        self.upperSpine=self.joints[2]
        self.head  =  self.joints[3]
        self.leftShoulder = self.joints[4]
        self.leftElbow = self.joints[5]
        self.leftWrist=self.joints[6]
        self.leftHand=self.joints[7]
        self.rightShoulder=self.joints[8]
        self.rightElbow = self.joints[9]
        self.rightWrist = self.joints[10]
        self.rightHand = self.joints[11]
        self.leftHip = self.joints[12]
        self.leftKnee = self.joints[13]
        self.leftAnkle = self.joints[14]
        self.leftFoot = self.joints[15]
        self.rightHip = self.joints[16]
        self.rightKnee = self.joints[17]
        self.rightAnkle = self.joints[18]
        self.rightFoot = self.joints[19]

    def update(self):
        """Update the skeleton joint positions in the depth sensor frame.

        Return true if the most recent sensor frame contained a tracked
        skeleton.
        """
        updated = False
        for skeleton in _kinect.skeleton_engine.get_next_frame().SkeletonData:
            if skeleton.eTrackingState == nui.SkeletonTrackingState.TRACKED:
     
                # Move the joints.
                os.system('cls')
                for joint, p in zip(self.joints, skeleton.SkeletonPositions):
                    joint.pos = (p.x, p.y, p.z)
                    
                # Move the bones.
                for bone, bone_id in zip(self.bones, _bone_ids):
                    p1, p2 = [self.joints[id].pos for id in bone_id]
                    bone.pos = p1
                    bone.axis = p2 - p1
                updated = True
        return updated


#only used when displaying rgb image (not usually necessary, but might be good for framing)
def video_frame_ready (frame):
     video = np.empty(( 480 , 640 , 4 ), np.uint8)
     frame.image.copy_bits (video.ctypes.data)
     cv2.imshow ( 'frame' , video)



def draw_sensor(f):
    """Draw 3D model of the Kinect sensor.

    Draw the sensor in the given (and returned) VPython frame f, with
    the depth sensor frame aligned with f.
    """
    box(frame=f, pos=(0, 0, 0), length=0.2794, height=0.0381, width=0.0635,
        color=color.blue)
    cylinder(frame=f, pos=(0, -0.05715, 0), axis=(0, 0.0127, 0), radius=0.0381,
             color=color.blue)
    cone(frame=f, pos=(0, -0.04445, 0), axis=(0, 0.01905, 0), radius=0.0381,
         color=color.blue)
    cylinder(frame=f, pos=(0, -0.05715, 0), axis=(0, 0.0381, 0), radius=0.0127,
             color=color.blue)
    cylinder(frame=f, pos=(-0.0635, 0, 0.03175), axis=(0, 0, 0.003),
             radius=0.00635, color=color.red)
    cylinder(frame=f, pos=(-0.0127, 0, 0.03175), axis=(0, 0, 0.003),
             radius=0.00635, color=color.red)
    cylinder(frame=f, pos=(0.0127, 0, 0.03175), axis=(0, 0, 0.003),
             radius=0.00635, color=color.red)
    text(frame=f, text='KINECT', pos=(0.06985, -0.00635, 0.03175),
         align='center', height=0.0127, depth=0.003)
    return f



# A bone is a cylinder connecting two joints, each specified by an id.
_bone_ids = [ [1, 2], [2, 3], [7, 6], [6, 5], [5, 4], [4, 2],
             [2, 8], [8, 9], [9, 10], [10, 11]]

#add these id's to display skeleton's legs. Since we are usually behind a table they just display nonsense
# [15, 14], [14, 13], [13, 12],[12, 0], [0, 16], [16, 17], [17, 18], [18, 19]]

# Initialize and level the Kinect sensor.
_kinect = nui.Runtime()
_kinect.skeleton_engine.enabled = True
_kinect.camera.elevation_angle = -1  #change this to point kinect up or down



if __name__ == '__main__':
##########
    # displays rgb image (useful for setting up camera frame)
    #kinect = nui.Runtime()
    #kinect.video_frame_ready += video_frame_ready
    #kinect.video_stream.open( nui.ImageStreamType.Video, 2 , nui.ImageResolution.Resolution640x480, nui.ImageType.Color )
    #cv2.namedWindow('frame',cv2.WINDOW_AUTOSIZE)
############
    
    draw_sensor(frame())
    skeleton = Skeleton(frame(visible=False))

    filename = r'C:\Users\Administrator\Desktop\temp_dir\skeleton_data.csv'
    skeleton_data= open(filename, 'w')

    #headers for csv file, comma delimited
    title_string = "Time Stamp, Head x, Head y, Head z, Neck x, Neck y, Neck z,\
Right Shoulder x, Right Shoulder y, Right Shoulder z, \
Right Elbow x, Right Elbow y, Right Elbow z, \
Right Wrist x, Right Wrist y, Right Wrist z, \
Right Hand x, Right Hand y, Right Hand z, \
Left Shoulder x, Left Shoulder y, Left Shoulder z, \
Left Elbow x, Left Elbow y, Left Elbow z, \
Left Wrist x, Left Wrist y, Left Wrist z, \
Left Hand x, Left Hand y, Left Hand z"
    #print headers to file
    print>>skeleton_data, title_string
    

    while True:
        
        rate(30)
        skeleton.frame.visible = skeleton.update()
    
        #print stuff here
        os.system('cls')
        print 'Time Stamp:      ', time.time()*1000
        print '----------------------------------------------'
        print 'Head:            ', skeleton.head.pos
        print 'Neck:            ', skeleton.upperSpine.pos
        print 'Right Shoulder:  ', skeleton.rightShoulder.pos
        print 'Right Elbow:     ', skeleton.rightElbow.pos
        print 'Right Wrist:     ', skeleton.rightWrist.pos
        print 'Right Hand:      ', skeleton.rightHand.pos
        print 'Left Shoulder:   ', skeleton.leftShoulder.pos
        print 'Left Elbow:      ', skeleton.leftElbow.pos
        print 'Left Wrist:      ', skeleton.leftWrist.pos
        print 'Left Hand:       ', skeleton.leftHand.pos
        
        data = [str(time.time()*1000)]
        #in the range of the joints we care about, print the joint positions to the console
        for k in range(3,13):
            data = data + [str(skeleton.joints[k].pos.x)] + [str(skeleton.joints[k].pos.y)] + [str(skeleton.joints[k].pos.z)]
        print>>skeleton_data, ",".join(data)

        key = cv2.waitKey( 33 )
        if key == 27 : # ESC
             break

cv2.destroyAllWindows()
kinect.close()
  
