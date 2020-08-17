#-*- coding: utf-8 -*-

import cv2			# opencv
import numpy as np

# --- Global vars

videofilename 	= 'firecv2.avi'
videocodec 		= 'MJPG'
write2video 	= False
width    		= 720
height   		= 240
FPS      		= 30
shiftbits 		= 4
shftwidth 		= 1 << shiftbits
frames			= 0
title1			= "RecordFire demo. Press 'V' to capture video, 'Q' - to stop."

fourcc = cv2.VideoWriter_fourcc('M','J','P','G')

zeros = np.zeros((height, width), dtype="uint8")
frame = np.copy(zeros)							# Gray scale

firerow = np.empty(width, dtype="uint8")
sintable = [np.uint8(255*np.sin(i*3.1415/(shftwidth-1))) for i in range(shftwidth)]

while(True):
	
	shift = np.random.randint(shftwidth)
	for i in range(width >> shiftbits):
		j = i << shiftbits
		c = np.random.randint(2)
		for k in range(shftwidth):
			x = j + k + shift
			if x < width:
				firerow[x] = c*np.uint8(sintable[k])
	
	frame[-1] = firerow
	
	for i in range(height >> 1, height - 1):
		frame[i,:] = (frame[i+1,:] >> 1) + (frame[i,:] >> 1)
	for i in range(height-1):
		frame[i,:] = (frame[i+1,:] >> 1) + (frame[i,:] >> 1)		

	frame = cv2.GaussianBlur(frame, (3,7), 0)
	
	rframe = np.uint8(16*np.sqrt(frame))
	videoframe = cv2.merge([zeros, frame, rframe])
	
	if write2video:
		frames += 1
		video.write(videoframe)
		cv2.imshow("Recording video... Press 'Q' to stop.", videoframe)
	else:
		cv2.imshow(title1, videoframe)
	
	key = cv2.waitKey(1) & 0xFF
	if  key | 0x20 == ord('q') or key == 27: # 'q' or 'Q ' or 'ESC'
		break
	elif key | 0x20 == ord('v'):
		write2video = True
		cv2.destroyWindow(title1)
		video = cv2.VideoWriter(videofilename, fourcc, float(FPS), (width,height))
	#~ elif key != 255:
		#~ print(key)
if write2video:		
	print("Finalizing video. Total {} frames saved to file {}\n".format(frames, videofilename))
	video.release()


