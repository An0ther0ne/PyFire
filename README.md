# PyFire
This is my research about implementation fire effect.
I wanted to find the simplest and fastest realization that effect with python and pygame.
Unfortunate, operations with separate pixels in the pygame too slow.
You can verify this yourself by running the regular version of program:
	python fireg.py

And as you can see, it work very very slowly:

![variant2](img/fireg2.gif)
![variant3](img/fireg3.gif)

For comparison, you can see below how quickly a similar algorithm does work, implemented on pure assembler in the dos system.
You can find corresponded binaries in the 'bin' folder of project. 
And you can properly execute them in the [DOSBox] environment. 

![FIRE.ASM](img/fireasm.gif)

Or the pascal version (with some inline assembler tricks):

![FIRE.PAS](img/firepas1.gif)

![FIRE.PAS](img/firepas2.gif)

![FIRE.PAS](img/firepas3.gif)

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

[DOSBox]: https://www.dosbox.com/
