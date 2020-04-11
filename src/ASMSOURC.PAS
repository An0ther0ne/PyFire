unit AsmSourc;

                                INTERFACE

   Function  keybread:word;
   Function  keybport:word;
   Procedure FillScreen(cc:word);{ClearTextScreen, if cc=$0700}
   Procedure HideCursor;
   Procedure ShowCursor;
   Procedure A_WriteTextXY(xx1,yy1,cc1:word;ss1:string);
   Procedure A_WriteStrXY(xx1,yy1,cc1:word;ss1:string);{For Status Bar, etc.}
   Procedure ClearScreen;
   Procedure A_Delay(tt:word);
   Procedure Synk;
   Procedure Retrace;

const

 kbAltA   = $1E00;  kbAltEqual  = $8300;  kbAlt1   = $7800;  kbF1     = $3B00;
 kbAltB   = $3000;  kbAltMinus  = $8200;  kbAlt2   = $7900;  kbF2     = $3C00;
 kbAltC   = $2E00;  kbAltSpace  = $0200;  kbAlt3   = $7A00;  kbF3     = $3D00;
 kbAltD   = $2000;  kbBack      = $0E08;  kbAlt4   = $7B00;  kbF4     = $3E00;
 kbAltE   = $1200;  kbCtrlBack  = $0E7F;  kbAlt5   = $7C00;  kbF5     = $3F00;
 kbAltF   = $2100;  kbCtrlDel   = $0600;  kbAlt6   = $7D00;  kbF6     = $4000;
 kbAltG   = $2200;  kbCtrlEnd   = $7500;  kbAlt7   = $7E00;  kbF7     = $4100;
 kbAltH   = $2300;  kbCtrlEnter = $1C0A;  kbAlt8   = $7F00;  kbF8     = $4200;
 kbAltI   = $1700;  kbCtrlHome  = $7700;  kbAlt9   = $8000;  kbF9     = $4300;
 kbAltJ   = $2400;  kbCtrlIns   = $0400;  kbAlt0   = $8100;  kbF10    = $4400;
 kbAltK   = $2500;  kbCtrlLeft  = $7300;  kbShiftF1  = $5400;  kbCtrlF1  = $5E00;
 kbAltL   = $2600;  kbCtrlPgDn  = $7600;  kbShiftF2  = $5500;  kbCtrlF2  = $5F00;
 kbAltM   = $3200;  kbCtrlPgUp  = $8400;  kbShiftF3  = $5600;  kbCtrlF3  = $6000;
 kbAltN   = $3100;  kbCtrlPrtSc = $7200;  kbShiftF4  = $5700;  kbCtrlF4  = $6100;
 kbAltO   = $1800;  kbCtrlRight = $7400;  kbShiftF5  = $5800;  kbCtrlF5  = $6200;
 kbAltP   = $1900;  kbDel       = $5300;  kbShiftF6  = $5900;  kbCtrlF6  = $6300;
 kbAltQ   = $1000;  kbDown      = $5000;  kbShiftF7  = $5A00;  kbCtrlF7  = $6400;
 kbAltR   = $1300;  kbEnd       = $4F00;  kbShiftF8  = $5B00;  kbCtrlF8  = $6500;
 kbAltS   = $1F00;  kbEnter     = $1C0D;  kbShiftF9  = $5C00;  kbCtrlF9  = $6600;
 kbAltT   = $1400;  kbEsc       = $011B;  kbShiftF10 = $5D00;  kbCtrlF10 = $6700;
 kbAltU   = $1600;  kbGrayMinus = $4A2D;  kbAltF1  = $6800;
 kbAltV   = $2F00;  kbGrayPlus  = $4E2B;  kbAltF3  = $6A00;
 kbAltW   = $1100;  kbGrayStar  = $372A;  kbAltF4  = $6B00;
 kbAltX   = $2D00;  kbGrayDiv   = $352F;  kbAltF5  = $6C00;
 kbAltY   = $1500;  kbHome      = $4700;  kbAltF6  = $6D00;
 kbAltZ   = $2C00;  kbIns       = $5200;  kbAltF7  = $6E00;
                    kbLeft      = $4B00;  kbAltF8  = $6F00;
                    kbNoKey     = $0000;  kbAltF9  = $7000;
                    kbPgDn      = $5100;  kbAltF10 = $7100;
                    kbPgUp      = $4900;
                    kbRight     = $4D00;
                    kbShiftDel  = $0700;
                    kbShiftIns  = $0500;
                    kbShiftTab  = $0F00;
                    kbTab       = $0F09;
                    kbUp        = $4800;
                    kbSpace     = $3920;
 kbLowerq = $1071;  kbLowerz = $2C7A;
 kbLowerw = $1177;  kbLowerx = $2D78;
 kbLowere = $1265;  kbLowerc = $2E63;
 kbLowerr = $1372;  kbLowerv = $2F76;
 kbLowert = $1474;  kbLowerb = $3062;
 kbLowery = $1579;  kbLowern = $316E;
 kbLoweru = $1675;  kbLowerm = $326D;
 kbLoweri = $1769;  kbLowerl = $266C;
 kbLowero = $186F;  kbLowerk = $256B;
 kbLowerp = $1970;  kbLowerj = $246A;
 kbLowera = $1E61;  kbLowerh = $2368;
 kbLowers = $1F73;  kbLowerg = $2267;
 kbLowerd = $2064;  kbLowerf = $2166;
 kbSemicolon = $273B ;{      Char = ';' }
 kbQwote     = $2827 ;{      Char = ''' }
 kbCome      = $332C ;{      Char = ',' }
 kbPset      = $342E ;{      Char = '.' }
 kbSlash     = $352F ;{      Char = '/' }
 kbTild      = $2960 ;

          {‘’€˜ˆ‰ €‰’ ‚‘…ƒ„€ = 0 ¯à¨ ­ ¦ â¨¨}
           kpLeft       = $4B;
           kpRight      = $4D;           kpEnter      = $1C;
           kpUp         = $48;           kpF1         = $3B;
           kpDown       = $50;           kpF2         = $3C;
           kpPgDn       = $51;           kpF3         = $3D;
           kpDel        = $53;           kpF4         = $3E;
           kpHome       = $47;           kpF5         = $3F;
           kpEnd        = $4F;           kpF6         = $40;
           kpIns        = $52;           kpF7         = $41;
           kpPgUp       = $49;           kpF8         = $42;
           kpGrayPlus   = $4E;           kpF9         = $43;
           kpGrayMinus  = $4A;           kpF10        = $44;
           kpCapsLock   = $3A;           kpScrollLock = $46;
           kbSpacebar   = $39;           kpNumlock    = $45;
           kpALT        = $38;

           kpBksp       = $0E;           kpD          = $20;
           kpTab        = $0F;           kpF          = $21;
           kpQ          = $10;           kpG          = $22;
           kpW          = $11;           kpH          = $23;
           kpE          = $12;           kpJ          = $24;
           kpR          = $13;           kpK          = $25;
           kpT          = $14;           kpL          = $26;
           kpY          = $15;           kpZ          = $2C;
           kpU          = $16;           kpX          = $2D;
           kpI          = $17;           kpV          = $2F;
           kpO          = $18;           kpB          = $30;
           kpP          = $19;           kpN          = $31;
           kpA          = $1E;           kpM          = $32;
           kpS          = $1F;

           kp1          = $02;           kp6          = $07;
           kp2          = $03;           kp7          = $08;
           kp3          = $04;           kp8          = $09;
           kp4          = $05;           kp9          = $0A;
           kp5          = $06;           kp0          = $0B;

{COLORS}
           Black        =  0;
           Blue         =  1;
           Green        =  2;
           Cyan         =  3;
           Red          =  4;
           Magenta      =  5;
           Brown        =  6;
           LightGray    =  7;

           DarkGray     =  8;
           LightBlue    =  9;
           LightGreen   = 10;
           LightCyan    = 11;
           LightRed     = 12;
           LightMagenta = 13;
           Yellow       = 14;
           White        = 15;


                              IMPLEMENTATION


const
     cursor_pos   : word = 0;
     cursor_line  : word = 0;
     videomode    : word = 0;
     videopage    : word = 0;

Function keybread:word;assembler;
asm
          mov     ah,1
          int     16h
          jnz     @@next
          xor     ax,ax
          jz      @@exit
  @@next: xor     ax,ax
          int     16h
          push    ax
 @@clear: mov     ah,1
          int     16h
          jz      @@endcl {zf=1 - á¨¬¢®« ­¥ £®â®¢}
          xor     ax,ax
          int     16h
          jmp     @@clear {®ç¨áâª  ®ç¥à¥¤¨ ª« ¢¨ âãàë}
 @@endcl: pop     ax
  @@exit:
end;

Function keybport:word;assembler;
asm
          in      al,60h
          mov     ah,0
end;

Procedure FillScreen(cc:word);assembler;
   asm
          push      es
          mov       ax,0B800h
          mov       es,ax
          mov       cx,80*24
          mov       ax,cc
          xor       di,di
          cld
          rep       stosw
          mov       al,20h
          mov       cx,80
          rep       stosw
          pop       es
   end;
Procedure ClearScreen;Assembler;
asm
          mov        ah,0fh
          int        10h
          mov        ah,0
          int        10h
end;
Procedure HideCursor;Assembler;
asm
          mov  ah,0fh
          int  10h
          mov  videomode,ax
          mov  videopage,bx
          mov  ah,3
          int  10h
          mov  cursor_pos,dx
          mov  cursor_line,cx
          mov  ah,1
          mov  ch,20h
          int  10h
end;
Procedure ShowCursor;Assembler;
asm
          mov  ah,1
          mov  cx,cursor_line
          int  10h
end;
Procedure A_WriteTextXY(xx1,yy1,cc1:word;ss1:string);assembler;
asm
          push es
          push ds
          mov  ax,0B800h
          mov  es,ax
          mov  ax,yy1
          mov  cl,80
          mul  cl
          add  ax,xx1
          shl  ax,1
          mov  di,ax
          lds  si,dword ptr [ss1]
          mov  cl,byte ptr ds:[si]
          mov  ch,0
          cld
          inc  si
          mov  ax,cc1
          xchg ah,al
     @@1: lodsb
          stosw
          loop    @@1
          pop  ds
          pop  es
end;
Procedure A_WriteStrXY(xx1,yy1,cc1:word;ss1:string);assembler;
asm
          push es
          push ds
          mov  ax,0B800h
          mov  es,ax
          mov  ax,yy1
          mov  cl,80
          mul  cl
          add  ax,xx1
          shl  ax,1
          mov  di,ax
          lds  si,dword ptr [ss1]
          mov  cl,byte ptr ds:[si]
          mov  ch,0
          cld
          inc  si
          mov  bx,cc1
          mov  ah,bl
     @@1: lodsb
          cmp  al,'&'
          jne  @@2
          dec  cx
          jz   @@3
          lodsb
          cmp  al,'&'
          je   @@2
          xchg bh,bl
          mov  ah,bl
     @@2: stosw
          loop    @@1
     @@3: pop  ds
          pop  es
end;
Procedure A_Delay(tt:word);assembler;{delay tt timer tiks}
asm
          push es
          mov  ax,0
          mov  es,ax
          mov  ax,tt
          or   ax,ax
          jz   @@E
     @@1: mov  ch,es:[046Ch]
     @@2: mov  cl,es:[046Ch]
          cmp  ch,cl
          je   @@2
          dec  ax
          jnz  @@1
     @@E: pop  es
end;
Procedure Synk;assembler;
asm
                  mov     dx,3dah
           @@1:   in      al,dx
                  test    al,8
                  jz      @@1
           @@2:   in      al,dx
                  test    al,8
                  jnz     @@2
end;
Procedure Retrace;assembler;
asm
                  mov     dx,3dah
           @@1:   in      al,dx
                  test    al,8
                  jnz     @@1
           @@2:   in      al,dx
                  test    al,8
                  jz      @@2
end;
END.

ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
³Hex Dec Key ºHex Dec Key  ºHex Dec Key    ºHex Dec Key     ºHex Dec Key
³ÄÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
³01   1  Esc º12  18  E    º23  35  H      º34  52  . >     º45  69  NumLock
³02   2  1 ! º13  19  R    º24  36  J      º35  53  / ?     º46  70  ScrollLock
³03   3  2 @ º14  20  T    º25  37  K      º36  54  Shft(Rt)º47  71  Home [7]
³04   4  3 # º15  21  Y    º26  38  L      º37  55  * PrtSc º48  72
                                                                         [8]
³05   5  4 $ º16  22  U    º27  39  ; :    º38  56  Alt     º49  73  PgUp [9]
³06   6  5 % º17  23  I    º28  40  " '    º39  57  spacebarº4a  74  K -
³07   7  6 ^ º18  24  O    º29  41  ` ~    º3a  58  CapsLockº4b  75      [4]
³08   8  7 & º19  25  P    º2a  42  Shft(L)º3b  59  F1      º4c  76       [5]
³09   9  8 * º1a  26  [ {  º2b  43  \ |    º3c  60  F2      º4d  77      [6]
³0a  10  9 ( º1b  27  ] }  º2c  44  Z      º3d  61  F3      º4e  78  K +
³0b  11  0 ) º1c  28  Enterº2d  45  X      º3e  62  F4      º4f  79  End  [1]
    [2]
³0d  13  + = º1e  30  A    º2f  47  V      º40  64  F6      º51  81  PgDn [3]
³0e  14  bkspº1f  31  S    º30  48  B      º41  65  F7      º52  82  Ins  [0]
³0f  15  Tab º20  32  D    º31  49  N      º42  66  F8      º53  83  Del  [.]
³10  16  Q   º21  33  F    º32  50  M      º43  67  F9      º
³11  17  W   º22  34  G    º33  51  , <    º44  68  F10     º
³ÄÄÄÄÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÐÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


