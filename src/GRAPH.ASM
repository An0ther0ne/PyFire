.model small,pascal

        Public ClearScreen,ClearTextScreen ;clear in graph mode too
        Public PutPixel,Sync,LINE,SetVideoSegment,SetGraphMode,SetTextMode
        Public Rectangle,SetColor,GrabColor,LINE2

.CODE
.386
                lwidth  dw      0
                lheight dw      0
                lhadd   dw      320
                lwadd   dw      200
                lhadd2  dw      320
                lwadd2  dw      200
                dist    dw      0
                cr      db      'VGA Graph Module (c) Grushetsky V. A.'
        
;==========================================================================
        SetGraphMode    PROC    FAR
                mov     ax,13h
                int     10h
                retf
        ENDP    SetGraphMode
;==========================================================================
        SetTextMode     PROC    FAR
                mov     ax,3
                int     10h
                retf
        ENDP    SetTextMode
;==========================================================================
        ClearScreen     Proc    Far
                push    es
         csseg: mov     ax,0A000h
                mov     es,ax
                xor     eax,eax
                mov     ecx,eax
                mov     edi,eax
                mov     cx,80*200
                cld
                rep     stosd
                pop     es
                retf
        endp    ClearScreen
;==========================================================================
        ClearTextScreen Proc    Far
                mov     ah,0fh
                int     10h
                mov     ah,0
                int     10h
                retf
        endp    ClearTextScreen
;==========================================================================
        PutPixel        Proc    Far xx:word,yy:word,cc:word
                push    es
         ppseg: mov     ax,0A000h
                mov     es,ax
                mov     ax,yy           ;y<=240 == byte
                mov     cl,160
                mov     di,xx
                mul     cl              ;byte multiply - work fasters
                shl     ax,1
                add     di,ax
                mov     ax,cc
                stosb
                pop     es
                ret
        endp    PutPixel
;==========================================================================
        Sync    Proc    Far
                CLI             ;WARNING!!! YOU MUST RESTORE (STI) AFTER CALL!
                mov     dx,3DAh
        @@1:    in      al,dx
                test    al,8
                jz      @@1     ;wait retrace
        @@2:    in      al,dx
                test    al,8
                jnz     @@2     ;wait for retrace finished
                retf
        endp    Sync
;==========================================================================
        SetVideoSegment PROC    FAR     VSEG:word;
                mov     ax,VSEG
                mov     word ptr cs:[csseg+1],ax
                mov     word ptr cs:[lvseg+1],ax
                mov     word ptr cs:[ppseg+1],ax
                mov     word ptr cs:[rcseg+1],ax
                mov     word ptr cs:[l2seg+1],ax
                ret
        ENDP    SetVideoSegment
;==========================================================================
        LINE    PROC    FAR     x1:word,y1:word,x2:word,y2:word,cc:word
                push    es
        lvseg:  mov     ax,0A000h
                mov     es,ax
                call    TESTCoords
                cmp     bx,dx           ;width ??? height
                jb      short @@lh
        @@lw:   inc     dx
                mov     di,ax
                mov     ax,cx           ;ax=y1 = 0..200 == 1 byte
                mov     cl,160
                mul     cl
                shl     ax,1            ;ax=y1*320
                add     di,ax           ;ax=y1*320+x1
                mov     ax,dx           ;ax=height
                mul     cl
                shl     ax,1    
                xor     dx,dx
                div     bx              ;ax=320*height/width
                mov     si,ax
                mov     ax,cc           ;al=color
                mov     es:[di],al      ;first point
                xor     bx,bx
                mov     ah,0
                mov     cl,6
        @@lw1:  inc     bx
                push    bx
                xchg    ax,bx
                mul     si
                shr     ax,cl           ;320*200 = 64000 < word
                dec     cl
                div     cl              ;ax <= 200 < byte
                inc     cl
                cmp     al,bh
                je      short @@lw2
                mov     bh,al           ;bh<=200 < byte
                add     di,word ptr cs:[lhadd]
        @@lw2:  inc     di
                xchg    ax,bx
                pop     bx
                mov     es:[di],al
                cmp     bx,word ptr cs:[lwidth]
                jne     short @@lw1
                pop     es
                RET

        @@lh:   inc     bx
                mov     di,ax
                mov     ax,cx           ;ax=y1 = 0..200 == 1 byte
                mov     cl,160
                mul     cl
                shl     ax,1            ;ax=y1*320
                add     di,ax           ;ax=y1*320+x1
                mov     ax,bx           ;ax=width
                mov     cl,200d
                mul     cl
                mov     cx,dx           ;cx=height
                xor     dx,dx
                div     cx
                mov     si,ax           ;si=200*width/height
                mov     ax,cc           ;al=color
                mov     es:[di],al      ;first point
                xor     bx,bx
                push    bp
                xor     bp,bp
                mov     cx,25
        @@lh1:  inc     bx
                push    bx
                xchg    ax,bx
                mul     si
                shr     ax,1
                shr     ax,1
                shr     ax,1
                xor     dx,dx
                div     cx
                cmp     ax,bp
                je      short @@lh2
                mov     bp,ax           ;bh<=320 < word
                inc     di
        @@lh2:  add     di,word ptr cs:[lhadd]
                xchg    ax,bx
                pop     bx
                mov     es:[di],al
                cmp     bx,word ptr cs:[lheight]
                jne     short @@lh1
                pop     bp
       @@lexit: pop     es
                RET
@@horizontal:   add     sp,2            ;passes ip
                cmp     bx,ax           ;x2 ??? x1
                ja      short @@l@h2
                xchg    ax,bx
       @@l@h2:  mov     di,ax
                mov     cx,bx
                sub     cx,ax           ;length of line
                mov     ax,dx           ;y1=y2 <= 240 == byte
                mov     dl,160
                mul     dl
                shl     ax,1
                add     di,ax
                mov     ax,cc           ;al=color (255 max)
                inc     cx
                cld
                rep     stosb
                jmp     @@lexit
@@vertical:     add     sp,2            ;passes ip
                mov     di,ax
                cmp     cx,dx           ;y1 ??? y2
                ja      short @@l@v1
                xchg    cx,dx           ;cx=y2, dx=y1
       @@l@v1:  sub     cx,dx           ;cx=y2-y1
                inc     cx
                mov     al,160
                mul     dl
                shl     ax,1
                add     di,ax
                mov     ax,cc
        @@l@v2: mov     es:[di],al
                add     di,320
                loop    @@l@v2
                jmp     @@lexit
        ENDP    LINE
;==========================================================================
TESTCoords      PROC    NEAR
                mov     ax,320
                mov     word ptr cs:[lhadd],ax
                mov     ax,x1
                mov     bx,x2
                mov     cx,y1
                mov     dx,y2
                cmp     bx,ax
                jne     short @@tc1
                cmp     cx,dx
                jne     short @@vertical        ;x1=x2 - vertical line
                add     sp,2
                pop     es
                leave
                pop     ax      ;return ip
                pop     bx      ;return cs
                pop     cx      ;color         
                add     sp,4    ;passes x2,y2
                push    cx      
                push    bx
                push    ax
                jmp     PutPixel                ;x1=x2 and y1=y2 - pixel
        @@tc1:  ja      short @@tc2
                xchg    ax,bx
                xchg    cx,dx
        @@tc2:  cmp     cx,dx
                je      short @@horizontal      ;y1=y2 - horizontal line
                sub     bx,ax
                sub     dx,cx
                test    dx,8000h
                jz      short @@tc3             ;if y2 > y1 then jump
                neg     dx
                neg     word ptr cs:[lhadd]
        @@tc3:  mov     word ptr cs:[lheight],dx
                mov     word ptr cs:[lwidth],bx
                RET
ENDP            TESTCoords
;==========================================================================
Rectangle       PROC FAR     x1:word,y1:word,x2:word,y2:word,cc:word
                push    es
         rcseg: mov     ax,0A000h
                mov     es,ax
                call    TESTCoords
                cld
                mov     di,ax
                mov     ax,cx           ;ax=y1 = 0..200 == 1 byte
                mov     cx,160
                mul     cl
                shl     ax,1            ;ax=y1*320
                add     di,ax           ;ax=y1*320+x1
                push    dx
                mov     ax,word ptr cs:[lhadd]
                mov     cx,dx
                imul    cx
                mov     dx,ax
                mov     cx,bx
                inc     cx
                mov     ax,cc
                xchg    bx,dx
                push    di
        @@rc1:  mov     byte ptr es:[di],al
                mov     byte ptr es:[di+bx],al
                inc     di
                loop    @@rc1
                xchg    bx,dx
                pop     di
                pop     cx
                inc     cx
        @@rc2:  mov     byte ptr es:[di],al
                mov     byte ptr es:[di+bx],al
                add     di,word ptr cs:[lhadd]
                loop    @@rc2
                pop     es
                RET
ENDP            Rectangle
;==========================================================================
SetColor        PROC    FAR     Nr:Byte,R:Byte,G:Byte,B:Byte
                mov  dx, 3C8h   ;Color port
                mov  al, Nr     ;number of color to change
                out  dx, al
                inc  dx         ;inc dx to write
                mov  al, r      ;red value
                out  dx, al
                mov  al, g      ;green
                out  dx, al
                mov  al, b      ;blue
                out  dx, al
                RET
ENDP            SetColor
;==========================================================================
;Использование этой процедуры не всегда удобно так как после ее вызова нужно
;позаботиться об извлечении из стека значений переменных
GrabColor       PROC    FAR     Nr:byte,R:Byte,G:byte,B:byte
        mov     dx,3C7h
        mov     al,Nr
        out     dx,al
        inc     dx
        inc     dx
        in      al,dx   ;R
        mov     R,al   
        in      al,dx   ;G
        mov     G,al      
        in      al,dx   ;G
        mov     B,al      
        retf
ENDP    GrabColor
;============================================line2 use an Brazenham's algoritm
LINE2   PROC    FAR     x1:word,y1:word,x2:word,y2:word,cc:word
                xor     ebx,ebx
                xor     edx,edx
                mov     ax,x1
                mov     bx,x2
                mov     cx,y1
                mov     dx,y2

                mov     si,[lhadd2]
                mov     di,[lwadd2]
                cmp     ax,si
                jbe     @@l2@A
                cmp     bx,si
                jbe     @@l2@A
                jmp     @@l2ee
        @@l2@A: cmp     cx,di
                jbe     @@l2@B
                cmp     dx,di
                jbe     @@l2@B
                jmp     @@l2ee

        @@l2@B: mov     di,si           ;di = max width
                xor     esi,esi
                inc     si
                sub     bx,ax
                sub     dx,cx
                test    bh,80h  
                jz      short   @@l2@1  ;jmp if width>=0
                neg     si
                neg     bx
                jmp     short   @@l2@2
        @@l2@1: or      bx,bx
                jnz     short   @@l2@2
                xor     si,si
        @@l2@2: test    dh,80h
                jz      short   @@l2@3  ;jmp if height>=0
                neg     di
                neg     dx
                jmp     short   @@l2@4
        @@l2@3: or      dx,dx
                jnz     short   @@l2@4
                xor     di,di
        @@l2@4: rol     esi,16
                mov     si,di
                push    es
                mov     di,ax
                mov     ax,cx
                mov     cl,160
                mul     cl
                shl     ax,1
                add     di,ax   ;es:di--> y1*320+x1
        l2seg:  mov     ax,0A000h
                mov     ES,AX
                xor     ax,ax
                mov     cx,bx
                mov     ax,cc   ;al=color
                push    bp
                cmp     bx,dx
                ja      short @@l2@5
                mov     cx,dx
        @@l2@5: mov     bp,cx           ;bp=dist
                cld
                inc     cx
                rol     edx,16
        @@l2@6: stosb
                dec     di
                add     dx,bx           ;dx=xerr+width
                rol     edx,16
                rol     ebx,16
                add     bx,dx           ;bx=yerr+height
                cmp     bx,bp           ;bx=yerr        bp=dist
                jna     short @@l2@7
                sub     bx,bp
                add     di,si
        @@l2@7: rol     edx,16
                rol     esi,16
                rol     ebx,16
                cmp     dx,bp           ;dx=xerr        bp=dist
                jna     short @@l2@8
                sub     dx,bp
                add     di,si
        @@l2@8: rol     esi,16
                loop    @@l2@6
                pop     bp
                pop     es
        @@l2ee: RET
ENDP    LINE2
;==========================================================================
END

