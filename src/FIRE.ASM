.MODEL SMALL
.286 
.STACK 200h
.DATA

xsize    =  320 
ysize    =  200 
randseed dw ?       

pallette db  0, 0, 0, 0, 0, 3, 0, 0, 6, 0, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0,10, 0, 0,11
         db  2, 0,10, 4, 0, 9, 6, 0, 9, 8, 0, 8,10, 0, 7,12, 0, 7,14, 0, 6,16, 0, 5
         db 18, 0, 5,20, 0, 4,22, 0, 4,24, 0, 3,26, 0, 2,28, 0, 2,30, 0, 1,32, 0, 0
         db 32, 0, 0,33, 0, 0,34, 0, 0,35, 0, 0,36, 0, 0,37, 0, 0,38, 0, 0,39, 0, 0
         db 40, 0, 0,41, 0, 0,42, 0, 0,43, 0, 0,44, 0, 0,45, 0, 0,46, 0, 0,47, 0, 0
         db 48, 1, 0,49, 1, 0,50, 2, 0,51, 2, 0,52, 3, 0,53, 3, 0,54, 4, 0,55, 4, 0
         db 56, 5, 0,57, 5, 0,58, 6, 0,59, 6, 0,59, 7, 0,60, 7, 0,61, 8, 0,62, 8, 0
         db 62, 9, 0,63,10, 0,63,11, 0,63,12, 0,63,12, 0,63,13, 0,63,14, 0,63,15, 0
         db 63,16, 0,63,16, 0,63,17, 0,63,18, 0,63,19, 0,63,20, 0,63,20, 0,63,21, 0
         db 63,22, 0,63,23, 0,63,24, 0,63,24, 0,63,25, 0,63,26, 0,63,27, 0,63,27, 0
         db 63,28, 0,63,29, 0,63,30, 0,63,30, 0,63,31, 0,63,32, 0,63,33, 0,63,33, 0
         db 63,34, 0,63,35, 0,63,36, 0,63,36, 0,63,37, 0,63,38, 0,63,39, 0,63,39, 0
         db 63,40, 0,63,41, 0,63,42, 0,63,42, 0,63,43, 0,63,44, 0,63,45, 0,63,45, 0
         db 63,46, 0,63,47, 0,63,48, 0,63,48, 0,63,49, 0,63,50, 0,63,51, 0,63,51, 0
         db 63,52, 0,63,53, 0,63,54, 0,63,54, 0,63,55, 0,63,56, 0,63,57, 0,63,57, 0
         db 63,58, 0,63,59, 0,63,60, 0,63,60, 0,63,61, 0,63,62, 0,63,63, 0,63,63, 0
         db 63,63, 1,63,63, 2,63,63, 3,63,63, 3,63,63, 4,63,63, 5,63,63, 6,63,63, 6
         db 63,63, 7,63,63, 8,63,63, 9,63,63, 9,63,63,10,63,63,11,63,63,12,63,63,12
         db 63,63,13,63,63,14,63,63,15,63,63,15,63,63,16,63,63,17,63,63,18,63,63,18
         db 63,63,19,63,63,20,63,63,21,63,63,21,63,63,22,63,63,23,63,63,24,63,63,24
         db 63,63,25,63,63,26,63,63,27,63,63,27,63,63,28,63,63,29,63,63,30,63,63,30
         db 63,63,31,63,63,32,63,63,33,63,63,33,63,63,34,63,63,35,63,63,36,63,63,36
         db 63,63,37,63,63,38,63,63,39,63,63,39,63,63,40,63,63,41,63,63,42,63,63,42
         db 63,63,43,63,63,44,63,63,45,63,63,45,63,63,46,63,63,47,63,63,48,63,63,48
         db 63,63,49,63,63,50,63,63,50,63,63,51,63,63,52,63,63,52,63,63,53,63,63,54
         db 63,63,54,63,63,55,63,63,56,63,63,56,63,63,57,63,63,58,63,63,58,63,63,59
         db 63,63,60,63,63,60,63,63,61,63,63,61,63,63,62,63,63,62,63,63,63,63,63,63
         db 63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,63,63,63,63,63,63
         db 63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,63,63,63,63,63,63
         db 63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,63,63,63,63,63,63
         db 63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,63,63,63,63,63,63
         db 63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,63,63,63,63,63,63

screen   db xsize*ysize dup (?) ; Virtual screen

.CODE 

Random          proc near
    mov     ax,[RandSeed]
    mov     dx,8405h
    mul     dx
    inc     ax
    mov     [RandSeed],ax
    ret  
Random          endp

SetUpScreen     proc near
    mov     ax,0013h
    int     10h
    mov     ax,0a000h
    mov     es,ax
    xor     di,di  
    cli
    cld
    mov     si, offset [pallette]
    mov     dx, 3c8h 
    mov     al, 0
    out     dx, al
    inc     dx
    mov     cx, 768
@PalLoop :
    outsb    
    dec     cx
    jnz     @PalLoop
    ret
SetUpScreen    endp

START:
    mov     ax,@DATA
    mov     ds,ax     
    call    SetUpScreen
    mov     [randseed],1234h
    push    es
    push    ds
    pop     es
    mov     di,offset [screen]
    mov     cx,xsize*ysize
    xor     ax,ax
    rep     stosb  
    pop     es
@MainLoop :
    mov     si,offset [screen]
    add     si,xsize*(ysize-1)
    mov     cx,xsize  
    xor     dx,dx
@Newline :                              ;FIRE INIT
            call    random
            or      dl,dl
            jnz     @@nozed
            mov     dl,0FFh
            mov     ds:[si],dl
            jmp     short @@skipzed
@@nozed:    or      dl,0Fh
            mov     ds:[si],dl
@@skipzed:  inc     si
            LOOP    @Newline
            mov     cx,xsize*ysize
            sub     cx,xsize
            mov     si,offset [screen]
            add     si,xsize
@FileLoop : 
    xor     ax,ax
    mov     al,ds:[si]
    mov     dl,ds:[si+1]
    shr     dl,1
    add     al,dl
    adc     ah,0
    mov     dl,ds:[si-1]
    shr     dl,1
    add     al,dl
    adc     ah,0
    mov     dl,ds:[si+xsize]
    shr     dl,1
    add     al,dl
    adc     ah,0
    mov     dl,ds:[si+xsize*2]
    shr     dl,1
    add     al,dl
    adc     ah,0
;    shr     ax,2
    mov     bl,3
    div     bl
    or      al,al
    jz      @zero
    dec     al
@Zero :  
    mov     ds:[si-xsize],al
    inc     si
    dec     cx
    jnz     @FileLoop
    mov     dx, 3dah
l1:
    in      al, dx
    and     al, 8h
    jnz     l1
l2:
    in      al, dx
    and     al, 8h
    jz      l2
    mov     cx,xsize*(ysize-2)
    shr     cx,1
    mov     si,offset [screen]
    mov     di,xsize*3
    rep     movsw
    mov     ah,01
    int     16h
    jnz     @@endl
    jmp     @MainLoop 
@@endl:
    mov     ah,0
    int     16h 
    mov     ax,0003h
    int     10h 
    mov     ax,4c00h
    int     21h 
END START
