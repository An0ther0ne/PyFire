.MODEL TINY
.CODE
ORG 100h
.286 
START:
;-- set up screen
        push    cs
        pop     ds
        mov     ax,     0013h
        int     10h
        cld
;-- set up palette    
        mov     dx,     3c8h 
        xor     ax,     ax
        mov     bx,     ax
        out     dx,     al
        inc     dx
        mov     cx,     768
@PalLoop :
        mov     al,     bl      ;       R
        out     dx,     al
        mov     al,     bh      ;       G
        out     dx,     al
        mov     al,     ah      ;       B
        cmp     al,     80h
        ja      @blue
        shr     al,     1
@blue:        
        shr     al,     2
        out     dx,     al
        inc     ah
        mov     bl,     ah      ;       R
        mov     bh,     ah
        cmp     bl,     3Fh
        jb      @next
        mov     bl,     3Fh
@next:        
        shr     bh,     1
        cmp     bh,     3Fh
        jb      @green
        mov     bh,     3Fh
@green:
        loop    @PalLoop
;-- clearscreen    
        push    ds
        pop     es
        mov     di,     offset [screen]
        mov     cx,     xsize * ysize / 2
        xor     ax,     ax
        rep     stosw  
;-- Main loop
@MainLoop :
        mov     si,     offset [screen]
        add     si,     xsize * (ysize - 1)
        mov     cx,     xsize  
        xor     dx,     dx
@Newline :                              ;FIRE INIT
        call    random
        or      dl,     dl
        jnz     @@nozed
        mov     dl,     0FFh
        mov     ds:[si],dl
        jmp     short @@skipzed
@@nozed:    
        or      dl,     00Fh
        mov     ds:[si],dl
@@skipzed:   
        inc     si
        LOOP    @Newline
        
        mov     cx,     xsize * ysize
        sub     cx,     xsize
        mov     si,     offset [screen]
        add     si,     xsize
@FileLoop : 
        xor     ax,     ax
        mov     al,     ds:[si]
        mov     dl,     ds:[si+1]
        shr     dl,     1
        add     al,     dl
        adc     ah,     0
        mov     dl,     ds:[si-1]
        shr     dl,     1
        add     al,     dl
        adc     ah,     0
        mov     dl,     ds:[si+xsize]
        shr     dl,     1
        add     al,     dl
        adc     ah,     0
        mov     dl,     ds:[si+xsize*2]
        shr     dl,     1
        add     al,     dl
        adc     ah,     0
;       shr     ax,     2
        mov     bl,     3
        div     bl
        or      al,     al
        jz      @zero
        dec     al
@Zero :  
        mov     ds:[si-xsize],  al
        inc     si
        dec     cx
        jnz     @FileLoop
        mov     dx,     3dah
l1:
        in      al,     dx
        and     al,     8h
        jnz     l1
l2:
        in      al,     dx
        and     al,     8h
        jz      l2
        mov     cx,     xsize * (ysize - 2)
        shr     cx,     1
        mov     si,     offset [screen]
        push    0a000h
        pop     es
        mov     di,     xsize * 3
        rep     movsw
        mov     ah,     01
        int     16h
        jnz     @@endl
        jmp     @MainLoop 
@@endl:
        mov     ah,     0
        int     16h 
        mov     ax,     0003h
        int     10h 
        mov     ax,     4c00h
        int     21h 
    
Random          proc near
        mov     ax,     [RandSeed]
        mov     dx,     8405h
        mul     dx
        inc     ax
        mov     [RandSeed],     ax
        ret  
Random          endp

xsize    =  320 
ysize    =  200 
randseed dw 1234h
         
screen   db xsize*ysize dup (?) ; Virtual screen

END START
