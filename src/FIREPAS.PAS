{$A+,B-,D+,E-,F+,G+,I-,L+,N+,O-,P-,Q-,R-,S-,T+,V+,X+,Y+}
{$M 32768,0,655360}
uses    asmsourc,crt;
        procedure SetGraphMode;external;{$l graph}
        procedure SetTextMode;external;
        procedure PutPixel(xx,yy,cc:word);external;
        procedure Line(x1,y1,x2,y2,color:word);external;
        procedure Line2(x1,y1,x2,y2,color:word);external;
        procedure Rectangle(x1,y1,x2,y2,color:word);external;
        procedure SetVideoSegment(vseg:word);external;
        procedure ClearScreen;external;
        procedure ClearTextScreen;external;
        procedure SetColor(n,r,g,b:byte);external;

label   l1,l2;
const
        FPAL:array [1..768] of byte=(
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$02,$00,$00,$03,$00,$00,
$04,$00,$00,$06,$00,$00,$08,$00,$00,$09,$00,$00,$0C,$00,$00,$0E,$00,$00,$10,$00,$00,$12,$00,$00,
$14,$00,$00,$16,$00,$00,$18,$00,$00,$1A,$00,$00,$1C,$00,$00,$1D,$00,$00,$1F,$00,$00,$21,$00,$00,
$24,$00,$00,$26,$00,$00,$28,$00,$00,$2A,$00,$00,$2C,$00,$00,$2D,$00,$00,$2E,$00,$00,$2F,$00,$00,
$30,$02,$00,$32,$04,$00,$34,$06,$00,$36,$08,$00,$38,$0A,$00,$39,$0C,$00,$3A,$0E,$00,$3B,$10,$00,
$3B,$12,$00,$3C,$14,$00,$3D,$16,$00,$3E,$18,$00,$3F,$1A,$00,$3F,$1C,$00,$3F,$1E,$00,$3F,$21,$00,
$3F,$22,$00,$3F,$23,$00,$3F,$24,$00,$3F,$24,$00,$3F,$25,$00,$3F,$26,$00,$3F,$27,$00,$3F,$27,$00,
$3F,$28,$00,$3F,$2A,$00,$3F,$2B,$00,$3F,$2C,$00,$3F,$2E,$00,$3F,$2F,$00,$3F,$30,$00,$3F,$30,$00,
$3F,$31,$00,$3F,$32,$00,$3F,$33,$00,$3F,$33,$00,$3F,$34,$00,$3F,$35,$00,$3F,$36,$00,$3F,$36,$00,
$3F,$37,$00,$3F,$38,$00,$3F,$39,$00,$3F,$39,$00,$3F,$3A,$00,$3F,$3B,$00,$3F,$3C,$00,$3F,$3C,$00,
$3F,$3D,$00,$3F,$3E,$00,$3F,$3F,$00,$3F,$3F,$00,$3F,$3F,$01,$3F,$3F,$02,$3F,$3F,$03,$3F,$3F,$03,
$3F,$3F,$04,$3F,$3F,$05,$3F,$3F,$06,$3F,$3F,$06,$3F,$3F,$07,$3F,$3F,$08,$3F,$3F,$09,$3F,$3F,$09,
$3F,$3F,$0A,$3F,$3F,$0B,$3F,$3F,$0C,$3F,$3F,$0C,$3F,$3F,$0D,$3F,$3F,$0E,$3F,$3F,$0F,$3F,$3F,$0F,
$3F,$3F,$10,$3F,$3F,$11,$3F,$3F,$12,$3F,$3F,$12,$3F,$3F,$13,$3F,$3F,$14,$3F,$3F,$15,$3F,$3F,$15,
$3F,$3F,$16,$3F,$3F,$17,$3F,$3F,$18,$3F,$3F,$18,$3F,$3F,$19,$3F,$3F,$1A,$3F,$3F,$1B,$3F,$3F,$1B,
$3F,$3F,$1C,$3F,$3F,$1D,$3F,$3F,$1E,$3F,$3F,$1E,$3F,$3F,$1F,$3F,$3F,$20,$3F,$3F,$21,$3F,$3F,$21,
$3F,$3F,$22,$3F,$3F,$23,$3F,$3F,$24,$3F,$3F,$24,$3F,$3F,$25,$3F,$3F,$26,$3F,$3F,$27,$3F,$3F,$27,
$3F,$3F,$28,$3F,$3F,$29,$3F,$3F,$2A,$3F,$3F,$2A,$3F,$3F,$2B,$3F,$3F,$2C,$3F,$3F,$2D,$3F,$3F,$2D,
$3F,$3F,$2E,$3F,$3F,$2F,$3F,$3F,$30,$3F,$3F,$30,$3F,$3F,$31,$3F,$3F,$32,$3F,$3F,$32,$3F,$3F,$33,
$3F,$3F,$34,$3F,$3F,$34,$3F,$3F,$35,$3F,$3F,$36,$3F,$3F,$36,$3F,$3F,$37,$3F,$3F,$38,$3F,$3F,$38,
$3F,$3F,$39,$3F,$3F,$3A,$3F,$3F,$3A,$3F,$3F,$3B,$3F,$3F,$3C,$3F,$3F,$3C,$3F,$3F,$3D,$3F,$3F,$3D,
$3F,$3F,$3E,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F);

     bufscrseg1:word=0;
     bufscrseg2:word=0;
     keyb:word=0;
     pbufscr1:pointer=nil;
     pbufscr2:pointer=nil;
     povtor=4;
     maxlen=40;
     def:boolean=false;
VAR
     i,j,k:integer;
     mas:array [1..maxlen] of char;
     c0,c1,c2,c3,c4:char;
     ss,s1:string[8];
     x,y,w:integer;
     p:longint;

     f,a:real;
     rmas:array [1..400] of record
      rx,ry,rdx,rdy:word;
      rb:boolean;
      ix,iy,t:word;
     end;


        function  GetVSegs:word;assembler;
        asm
                  mov   ax,word ptr [pbufscr1+2]
                  mov   bx,word ptr [pbufscr2+2]
                  mov   [bufscrseg1],ax
                  mov   [bufscrseg2],bx
        end;
        Procedure CopyVPage(Src,Dst:word);assembler;
        asm
                  push  es
                  push  ds
                  cld
                  mov   cx,32000
                  mov   dx,0
                  mov   ax,[Src]
                  mov   bx,[Dst]
                  mov   ds,ax
                  mov   es,bx
                  mov   si,dx
                  mov   di,dx
                  rep   movsw
                  pop   ds
                  pop   es
        end;
        Procedure ClearVPage(VSeg:word);assembler;
        asm
                  push  es
                  mov   bx,[VSeg]
                  mov   ax,0
                  mov   cx,32000
                  mov   es,bx
                  mov   di,ax
                  cld
                  rep   stosw
                  pop   es
        end;
        procedure fire;assembler;
        asm
                  mov     ax,bufscrseg1
                  mov     bx,bufscrseg2
                  push    ds
                  push    es
                  mov     ds,ax
                  mov     es,bx
                  mov     si,320
                  mov     di,si
                  mov     cl,5
             @@1: mov     al,ds:[si+320]
                  cbw
                  inc     al
                  add     al,ds:[si+320]
                  adc     ah,0
                  mov     dl,ds:[si+640]
                  mov     dh,0
                  add     dl,ds:[si+960]
                  adc     dh,0
                  shr     dx,1
                  mov     bl,ds:[si+1]
                  mov     bh,0
                  add     bl,ds:[si-1]
                  adc     bh,0
                  shr     bx,1
                  add     ax,bx
                  add     ax,dx
                  shr     al,2
             @@2: mov     ds:[di],al
                  inc     di
                  inc     si
                  cmp     si,201*320
                  jne     @@1
                  pop     es
                  pop     ds
        end;
        procedure fire2;assembler;
        asm
                  mov     ax,bufscrseg1
                  mov     bx,bufscrseg2
                  push    ds
                  push    es
                  mov     ds,ax
                  mov     es,bx
                  mov     si,320
                  mov     di,si
                  mov     cl,5
             @@1: mov     al,ds:[si+320]
                  cbw
                  add     al,ds:[si+320]
                  adc     ah,0
                  mov     dl,ds:[si+640]
                  mov     dh,0
                  add     dl,ds:[si+960]
                  adc     dh,0
                  shr     dx,1
                  mov     bl,ds:[si+1]
                  mov     bh,0
                  add     bl,ds:[si-1]
                  adc     bh,0
                  shr     bx,1
                  add     ax,bx
                  add     ax,dx
                  shr     ax,2
             @@2: mov     ds:[di],al
                  inc     di
                  inc     si
                  cmp     si,201*320
                  jne     @@1
                  pop     es
                  pop     ds
        end;

        Procedure SetPalAsm;assembler;
        asm
                  mov     si, offset FPAL
                  mov     dx, 3c8h
                  mov     al, 0
                  out     dx, al
                  inc     dx
                  mov     cx, 768
            @@1:  outsb
                  loop    @@1
        end;
        Procedure SetPalAsm2;assembler;
        asm
                  mov     si, offset FPAL
                  mov     dx, 3c8h
                  mov     cx, 0
            @@1:  mov     al, cl
                  out     dx, al
                  inc     dx
                  cld
                  lodsb
                  mov     ah,al
                  lodsb
                  out     dx,al
                  xchg    ah,al
                  out     dx,al
                  lodsb
                  out     dx,al
                  inc     cx
                  dec     dx
                  cmp     cx,256
                  jne     @@1
        end;

        function  RandomA:byte;assembler;asm
                  cli
                  in      al,40h
                  mov     ah,al
                  in      al,40h
                  rol     al,3
                  add     ah,al
                  in      al,40h
                  ror     ah,3
                  add     al,ah
                  sti
        end;
        Procedure SetPalette;
        var i:word;
            function red  (j:word):byte;begin
                     red  :=round(63*ln(1+sqr(i/10))/6.478893);
            end;
            function green(j:word):byte;begin
                     green:=round(31.5*(1+sin(j*pi/318.75-pi/4)));
            end;
            function blue(j:word):byte;begin
                     blue :={round(31.5*(1+sin(j*pi/318.75-pi/4)));}
                     round(sqr(j*7.9/255));
            end;
        begin
             for i:=1 to 255 do setcolor(i,red(i),green(i),blue(i));
        end;
BEGIN
     if maxavail<$10000 then begin
        writeln('ERROR: No enoth memory. Terminated!');
        halt(1);
     end;
     getmem(pbufscr1,$FFFF);
     GetVSegs;

     ClearTextScreen;
     Writeln;
     Writeln('This if pascal fire show demo.');
     Writeln('Just press ESC key to go to the next screen.');
     Writeln('There are four screens total...');
     keybread;{clear keyboard queue}
     repeat until keybread<>0;

{============================================================================}
     asm
        mov ax,13h
        int 10h
     end;
     keybread;
     SetPalAsm2;
   repeat
     ClearVPage(bufscrseg1);
     repeat
           for i:=0 to 319 do begin
               keyb:=random(133);
               if keyb<30 then begin
                  mem[bufscrseg1:320*201+i]:=0;
                  mem[bufscrseg1:320*202+i]:=0;
               end else if keyb<60 then begin
                  mem[bufscrseg1:320*201+i]:=32;
                  mem[bufscrseg1:320*202+i]:=32;
               end else if keyb<90 then begin
                  mem[bufscrseg1:320*201+i]:=128;
                  mem[bufscrseg1:320*202+i]:=128;
               end else begin
                  mem[bufscrseg1:320*201+i]:=255;
                  mem[bufscrseg1:320*202+i]:=255;
               end;
           end;
           fire;
           Synk;
           CopyVPage(bufscrseg1,$A000);
           keyb:=keybread;
     until keyb<>0;
   until   keyb=kbESC;
{============================================================================}
   repeat
     ClearVPage(bufscrseg1);
     repeat
           for i:=0 to 319 do begin
               keyb:=random(133);
               if keyb<30 then begin
                  mem[bufscrseg1:320*201+i]:=0;
                  mem[bufscrseg1:320*202+i]:=0;
               end else if keyb<60 then begin
                  mem[bufscrseg1:320*201+i]:=32;
                  mem[bufscrseg1:320*202+i]:=32;
               end else if keyb<90 then begin
                  mem[bufscrseg1:320*201+i]:=128;
                  mem[bufscrseg1:320*202+i]:=128;
               end else begin
                  mem[bufscrseg1:320*201+i]:=255;
                  mem[bufscrseg1:320*202+i]:=255;
               end;
           end;
           fire2;
{           CopyVPage(bufscrseg2,bufscrseg1);}
           Synk;
           CopyVPage(bufscrseg1,$A000);
           keyb:=keybread;
     until keyb<>0;
   until   keyb=kbESC;
{============================================================================}
   SetPalAsm;
   repeat
     ClearVPage(bufscrseg1);
     {ClearVPage(bufscrseg2);}
     for i:=1 to 300 do begin
         rmas[i].rb:=false;
         rmas[i].t:=i*2;
     end;
     fillChar(ptr(bufscrseg1,64000)^,960,#0);
     repeat
           keyb:=keybread;
           for i:=1 to 250 do with rmas[i] do begin
              if rb then begin
                 mem[bufscrseg1:320*(ry shr 6)+rx shr 6]:=16;
                 rx:=rx+rdx;
                 ry:=ry+rdy;
                 rdy:=rdy+1;
                 if (rx>319*64) or (ry>199*64) then begin
                    rb:=true;
                    ry:=12800;
                    rx:=round(64*(155+9*random));
                    f:=1.5+random/32;
                    a:=(50-100*random)*pi/180;
                    rdx:=round(64*f*sin(a));
                    rdy:=round(-64*f*cos(a));
                 end else mem[bufscrseg1:320*(ry shr 6)+rx shr 6]:=255;
              end else begin
                  dec(t);
                  if t=0 then begin
                     rb:=true;
                     ry:=200 shl 6;
                     rx:=round(64*(155+9*random));
                     f:=1.5+random/32;
                     a:=(50-100*random)*pi/180;
                     rdx:=round(64*f*sin(a));
                     rdy:=round(-64*f*cos(a));
                  end;
              end;
           end;
           fire2;
           Synk;
           CopyVPage(bufscrseg1,$A000);
     until keyb<>0;
   until   keyb=kbESC;
{============================================================================}
   repeat
     repeat
           keyb:=keybread;
           for i:=1 to 250 do with rmas[i] do begin
              if rb then begin
                 mem[bufscrseg1:320*(ry shr 6)+rx shr 6]:=16;
                 rx:=rx+rdx;
                 ry:=ry+rdy;
                 rdy:=rdy+1;
                 if (rx>319*64) or (ry>199*64) then begin
                    rb:=true;
                    ry:=12800;
                    rx:=round(64*(155+9*random));
                    f:=1.8+random/2;
                    a:=(25-50*random)*pi/180;
                    rdx:=round(64*f*sin(a));
                    rdy:=round(-64*f*cos(a));
                 end else mem[bufscrseg1:320*(ry shr 6)+rx shr 6]:=255;
              end else begin
                  dec(t);
                  if t=0 then begin
                     rb:=true;
                     ry:=200 shl 6;
                     rx:=round(64*(155+9*random));
                     f:=1.8+random/2;
                     a:=(25-50*random)*pi/180;
                     rdx:=round(64*f*sin(a));
                     rdy:=round(-64*f*cos(a));
                  end;
              end;
           end;
           fire2;
           Synk;
           CopyVPage(bufscrseg1,$A000);
     until keyb<>0;
   until   keyb=kbESC;

     freemem(pbufscr1,$FFFF);
     {freemem(pbufscr2,$FFFF);}
     asm
        mov ax,3
        int 10h
     end;
     clrscr;
     Writeln;
     Writeln('Fire show demo (c) by An0ther 0ne.');
     Writeln('GitHub project page : https://github.com/An0therOne/PyFire');
     Writeln('Thanks for watching.');
     Writeln;
END.