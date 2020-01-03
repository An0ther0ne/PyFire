# PyFire

## Prehistory
 
This is my research about implementation fire effect.
I wanted to find the simplest and fastest realization that effect with python and pygame.
Unfortunate, operations with separate pixels in the pygame too slow.
You can verify this yourself by running the regular version of program:
    
		python fireg.py

And as you can see, it work very very slowly:

![variant2](img/fireg2.gif)
![variant3](img/fireg3.gif)

For comparison, you can see below how quickly a similar algorithm does work, implemented on pure assembler in the DOS system.
You can find corresponded binaries in the 'bin' folder of project. 
And you can properly execute them in the [DOSBox][1] environment.
These programs work very fast even on ancient computers and have screen frame synchronization procedure like “Synk” (see pascal version) for speed reduction. 

![FIRE.ASM](img/fireasm.gif)

Or the pascal version (with some inline assembler tricks):

![FIRE.PAS](img/firepas1.gif)

![FIRE.PAS](img/firepas2.gif)

![FIRE.PAS](img/firepas3.gif)

## Work around

The first way to improve Python responsibility to work with array of pixels little above than small size – is to use NumPy library. 
But this doesn't optimal decision because we have been translating arrays from PyGame to Numpy and vice versa. 
The secondary way – use OpenGL library for Python – looks good. Let's try it...

# Requirements:

* Python
* PyGame
 
# Project structure:
 
## Folders:

*	img - screenshots, images, etc.
*	src - additional source files.
*	bin - compiled binaries.
 
## Files:
	
* fireg.py - regular version of fire effect for python & pygame 
* FIRE.ASM - source of an assembler version
* FIRE.EXE - binary of assembler version for DOS system (16 bit)
* FIREPAS.EXE - binary of borland pascal 7.0 version for DOS system (16 bit) 

# AUTHOR
   An0ther0ne

# Links

[1]: https://www.dosbox.com/ "DOSBox offisial site."
