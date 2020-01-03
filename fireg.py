#-*- coding: utf-8 -*-
#
# pg.Surface.set_at((x,y),(r,g,b))
# 	Put pixel
#
# pygame.PixelArray 	
# 	pygame object for direct pixel access of surfaces:
#
# Inintialization
import pygame as pg
# import numpy as np
import random as rnd
from math import cos
from sys import exit
pg.init()

# Globals
Pi = 3.1415925
margins = 2
display_width  = 640
display_height = 200
screen_color = (32,0,0)
fire_color=(240,152,92)

window = pg.display.set_mode((display_width, display_height))
pg.display.set_caption('FIREG')
screen_width  = display_width - 2*margins
screen_height = display_height - 2*margins
screen = pg.Surface((screen_width, screen_height))

def igniinitline(line):
	mline = []
	(r2,g2,b2) = screen_color
	for c1 in line:
		r1,g1,b1 = c1 >> 16, (c1 >> 8) & 0xFF, c1 & 0xFF
		r1 = (r1 + r2 + screen_color[0]) // 3
		g1 = (g1 + g2 + screen_color[1]) // 3
		b1 = (b1 + b2 + screen_color[2]) // 3
		r2,g2,b2 = r1,g1,b1
		mline.append((r1,g1,b1))
	return mline

def ignition_1():	# Method 1
	for x in range(screen_width >> 2):
		if rnd.random()>0.75:
			for k in range(4):
				screen.set_at(((x<<2)+k,screen_height-1),fire_color)
		else:
			for k in range(4):
				screen.set_at(((x<<2)+k,screen_height-1),screen_color)
			
def ignition_2():	# Method 2
	pxarray = pg.PixelArray(screen)
	y = screen_height-1
	icol = []
	isize = 20
	for k in range(isize):
		c = cos((k - isize//2)*Pi/25)
		c *= c
		r = fire_color[0] * c
		g = fire_color[1] * c
		b = fire_color[2] * c
		icol.append((r,g,b))
	pxarray[::,y] = igniinitline(pxarray[::,y])
	for i in range(isize):
		x = rnd.randrange(screen_width - isize)
		for k in range(isize):
			# pxarray[x+k,y]   = 0xF0F000
			# pxarray[x+k,y]   = icol[k]
			(i,r,g,b) = pg.Color(pxarray[x+k,y])
			r = (r + 2*icol[k][0]) // 3
			g = (g + 2*icol[k][1]) // 3
			b = (b + 2*icol[k][2]) // 3
			pxarray[x+k,y]   = (r,g,b)
	# this is optional to unlock surface before blit, but on exit from function surface will be unlocked automatically because 'pxarray' is local variable in this procedure.
	# pxarray.close()
	
def ignition_3():
	pxarray = pg.PixelArray(screen)
	y = screen_height-1
	line = pxarray[::,y]
	(fcr,fcg,fcb) = fire_color
	(scr,scg,scb) = screen_color
	fc2 = (max(fcr // 3, scr) << 16) + (max(fcg // 3, scg) << 8) + max(fcb // 3,scb)
	fc1 = (max(fcr >> 1, scr) << 16) + (max(fcg >> 1, scg) << 8) + max(fcb >> 1,scb)
	for i in range(screen_width >> 2):
		r = rnd.random()
		x = i << 2
		for k in range(4):
			if r < 0.3:
				line[x+k] = screen_color
			elif r < 0.6:
				line[x+k] = fc2
			elif r < 0.85:
				line[x+k] = fc1
			else:
				line[x+k] = fire_color

def firegoon_1():
	pxarray = pg.PixelArray(screen)
	for yi in range(screen_height>>1):
		y = screen_height - 2 - yi
		pxarray[::,y] = pxarray[::,y+1]

def firegoon_2(): # This is too slow
	pxarray = pg.PixelArray(screen)
	for yi in range(screen_height-1):
		y = screen_height - 2 - yi
		iline = pxarray[::,y]
		nline = pxarray[::,y+1]
		rline = []
		for i in range(len(iline)):
			cr = (((iline[i] & 0xFF0000) + (nline[i] & 0xFF0000)) >> 1) & 0xFF0000
			cg = (((iline[i] & 0x00FF00) + (nline[i] & 0x00FF00)) >> 1) & 0x00FF00
			cb = ((iline[i] & 0x0000FF) + (nline[i] & 0x0000FF)) >> 1
			rline.append(cr + cg + cb)
#			rline.append((r,g,b))
		pxarray[::,y] = rline		

screen.fill(screen_color)
done  = True
ignition = ignition_2
firegoon = firegoon_2
while done:
	for e in pg.event.get():
		# Cycle events
		if e.type == pg.QUIT:
			done = False
		elif e.type == pg.KEYDOWN:
			if e.key == pg.K_ESCAPE:
				done = False
	# screen.fill(screen_color)
	ignition()
	firegoon()
	window.blit(screen,(margins,margins))
	pg.display.flip()
	pg.time.delay(10)
