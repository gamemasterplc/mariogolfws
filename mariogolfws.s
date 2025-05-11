.n64

.open "mariogolf.z64", "mariogolfws.z64", 0

SCREEN_W equ 424
SCREEN_W_FLOAT equ 424.0
SCREEN_H equ 240
FBCOPY_ROW_H equ (2048/SCREEN_W)
FBCOPY_ROW_NUM equ (((SCREEN_H+FBCOPY_ROW_H-1)/FBCOPY_ROW_H)-2)
CFB_ADDR equ 0x80400000
ZBUF_ADDR equ 0x80700000

.headersize 0x80025C00-0x1000 //Main Segment

.org 0x80028320
//Fix Load of Z Buffer Address
lui v0, hi(ZBUF_ADDR)
addiu v0, v0, lo(ZBUF_ADDR)

.org 0x8002A67C
addiu t0, r0, (SCREEN_W-16) //Fix Scissor Width

.org 0x8002A684
addiu a3, r0, SCREEN_W //Fix Viewport Width

.org 0x8002B308
ori s3, s3, (SCREEN_W-1) //Fix Framebuffer Copy Pitch

.org 0x8002B310
lui s2, hi(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Copy Clear Rect Load Hi
addiu s2, s2, lo(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Copy Clear Rect Load Lo

.org 0x8002B4A8
ori v0, v0, (SCREEN_W-1) //Fix Framebuffer Copy Pitch

.org 0x8002B4B4
lui a0, hi(0x07000000|((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Hi
addiu a0, a0, lo(0x07000000|((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Lo

.org 0x8002B4C4
lui a2, hi(((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Hi
addiu a2, a2, lo(((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Lo

.org 0x8002B4D0
//Fix Row FB Copy Rectangle Hi
lui t0, hi(0xE4000000|((SCREEN_W-9) << 14))

.org 0x8002B4DC
//Fix Row FB Copy Rectangle Lo
addiu t0, t0, lo(0xE4000000|((SCREEN_W-9) << 14))

.org 0x8002B520
//Fix Row Height
addiu v0, r0, FBCOPY_ROW_H
j 0x8002B538
addiu v1, v0, 7

.org 0x8002B644
lui v0, (FBCOPY_ROW_H*4) //Fix Row Tile Advance

.org 0x8002B64C
//Fix Row Advance
addiu s7, s7, (FBCOPY_ROW_H*4)
addiu s5, s5, FBCOPY_ROW_H
addiu s6, s6, (SCREEN_W*FBCOPY_ROW_H*2)

.org 0x8002B664
addiu v0, r0, FBCOPY_ROW_NUM

.org 0x8002B68C
ori v0, v0, (SCREEN_W-1) //Fix Reset Framebuffer Width

.org 0x8002B6A4
lui t7, hi(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Copy Clear Rect Load Hi
addiu t7, t7, lo(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Copy Clear Rect Load Lo

.org 0x8002B6EC
ori v0, v0, (SCREEN_W-1) //Fix Framebuffer Copy Pitch

.org 0x8002B6F8
lui a0, hi(0x07000000|((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Hi
addiu a0, a0, lo(0x07000000|((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Lo

.org 0x8002B708
lui a2, hi(((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Hi
addiu a2, a2, lo(((SCREEN_W-9) << 14)) //Fix Copy Clear Rect Load Lo

.org 0x8002B714
//Fix Row FB Copy Rectangle
lui t0, hi(0xE4000000|((SCREEN_W-9) << 14))
addiu t0, t0, lo(0xE4000000|((SCREEN_W-9) << 14))

.org 0x8002B764
//Fix Row Height
addiu v0, r0, FBCOPY_ROW_H
j 0x8002B77C
addiu v1, v0, 7

.org 0x8002B878
lui v0, (FBCOPY_ROW_H*4) //Fix Row Tile Advance

.org 0x8002B880
//Fix Row Advance
addiu t2, t2, (FBCOPY_ROW_H*4)
addiu t5, t5, FBCOPY_ROW_H
addiu t4, t4, (SCREEN_W*FBCOPY_ROW_H*2)

.org 0x8002B890
addiu v0, r0, FBCOPY_ROW_NUM

.org 0x8002C0A4
li s7, ((SCREEN_W << 14)|(SCREEN_H << 2)) //Fix SCissor for Temporary Copy

.org 0x8002C34C
ori v0, v0, (SCREEN_W-1) //Fix Framebuffer Pitch for Temporary Copy

.org 0x8002CB88
ori s7, s7, (SCREEN_W-1) //Fix Game Framebuffer Width

.org 0x8002CD14
li t1, (((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Mode Select Scissor

.org 0x8002DEA8
ori fp, fp, (SCREEN_W-1) //Fix Game Framebuffer Width

.org 0x8002D878
ori s4, s4, (SCREEN_W-1) //Fix Mode Select Framebuffer Width

.org 0x8002DA08
li t3, (((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Mode Select Scissor

.org 0x8002DF10
li a0, (((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Other Scissor

.org 0x8002E314
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of HUD Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of HUD Ortho

.org 0x8002E49C
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of HUD Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of HUD Ortho

.org 0x8002E644
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of HUD Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of HUD Ortho

.org 0x8002F298
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x8002F500
lui a3, hi(0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Copy Clear Rect Hi

.org 0x8002F528
addiu a3, a3, lo(0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Copy Clear Rect Lo

.org 0x8002F678
lui a3, hi(0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Copy Clear Rect Hi

.org 0x8002F6E8
addiu a3, a3, lo(0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Copy Clear Rect Lo

.org 0x80032420
li.u at, SCREEN_W_FLOAT //Fix Sub-Viewport Width

.org 0x80032A04
li t1, (0xF6000000|((SCREEN_W-9) << 14)|((SCREEN_H-9) << 2)) //Fix Background Color

.org 0x80032BB0
li t7, ((SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Default Scissor

.org 0x80032BD8
li s5, (0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Default Clear Rect

.org 0x80032D08
lui a2, hi(0xF6000000|((SCREEN_W-1) << 14)) //Fix Copy Clear Rect Hi
addiu a2, a2, lo(0xF6000000|((SCREEN_W-1) << 14)) //Fix Copy Clear Rect Lo

.org 0x80032BCC
ori s2, s2, (SCREEN_W-1) //Fix Main Framebuffer Width

.org 0x80048740
addiu a0, r0, (SCREEN_W/2) //Fix Centering of Golf Sub-Viewport

.org 0x80064DF0
//Fix X Scale of Screen Effects
li.u at, (1.0/SCREEN_W_FLOAT)
li.l at, (1.0/SCREEN_W_FLOAT)

.org 0x80065010
li.u at, -(SCREEN_W_FLOAT/2) //Fix X Offset of Screen Effects

.org 0x80065108
//Fix X Scale of Screen Effects
li.u at, (1.0/SCREEN_W_FLOAT)
li.l at, (1.0/SCREEN_W_FLOAT)

.org 0x80065328
li.u at, (SCREEN_W_FLOAT/2) //Fix X Scale of 3D to 2D

.org 0x8006AFAC
li.u at, (((SCREEN_W_FLOAT/2)-8)/4) //Fix Scale of Image Fades

.org 0x8006AFD4
li.u at, -((SCREEN_W_FLOAT/2)-8) //Fix Offset of Image Fades

.org 0x8006B210
li t2, (0xE4000000|((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Image Fade Small Size

.org 0x8006B33C
li t6, (0xE4000000|((SCREEN_W-8) << 14)|((SCREEN_H+24) << 2)) //Fix Image Fade Large Size

.org 0x8006B34C
li.u at, 158720.0 //Fix Y Offset of Image Fades

.org 0x8006B78C
li s7, (0xE4000000|((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Fade Rect

.org 0x8006BAD4
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Restart Game Text

.org 0x8006BF80
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Left Edge of Restart Window

.org 0x8006BF94
addiu a3, s1, (SCREEN_W/2) //Fix X Position of Left Edge of Restart Window

.org 0x8006C174
addiu v0, r0, ((SCREEN_W/2)-32) //Fix X Position of Restart Window Yes

.org 0x8006C200
addiu a3, s1, ((SCREEN_W/2)-32) //Fix X Position of Restart Window Yes Right Edge

.org 0x8006C300
addiu v0, r0, ((SCREEN_W/2)+32) //Fix X Position of Restart Window No

.org 0x8006C324
addiu v0, s1, ((SCREEN_W/2)+32) //Fix X Position of Restart Window No Right Edge

.org 0x8006CC18
addiu a3, r0, ((SCREEN_W-8)*4) //Fix Right Edge of Half Turn Image

.org 0x8006CC58
addiu t6, r0, (311296/(SCREEN_W-16)) //Load DSDX for Half Turn Image

.org 0x8006CD08
sw t6, 0x20(sp) //Set DSDX for Half Turn Image

.org 0x8006F8BC
addiu a0, r0, ((SCREEN_W/2)-112) //Fix X Position of How To Play Title

.org 0x8006F950
addiu a0, r0, ((SCREEN_W/2)-108) //Fix X Position of How To Play Instruction

.org 0x8006FA84
addiu a0, r0, ((SCREEN_W/2)-112) //Fix X Position of How To Play Title

.org 0x8006FB18
addiu a0, r0, ((SCREEN_W/2)-108) //Fix X Position of How To Play Instruction

.org 0x80070234
addiu v0, a1, ((SCREEN_W/2)-66) //Fix X Position of Cursor Rght Edge
addiu a1, a1, ((SCREEN_W/2)-90) //Fix X Position of Cursor Left Edge

.org 0x8007043C
lui t5, (((SCREEN_W/2)+8) >> 2) //Fix X Position of Right Edge of Arrows

.org 0x8007044C
lui t4, (((SCREEN_W/2)-8) >> 2) //Fix X Position of Left Edge of Arrows

.org 0x800707D4
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Selected How To Play Option

.org 0x80070824
addiu a0, r0, (SCREEN_W/2) //Fix X Position of How To Play Options

.org 0x80070EA0
lui v1, (0xE400|(((SCREEN_W/2)+132) >> 2)) //Fix Right Edge of How to Play Board

.org 0x80070EC8
lui v1, (((SCREEN_W/2)-124) >> 2) //Fix Left Edge of How to Play Board

.org 0x80080004
addiu a1, r0, ((SCREEN_W-104)*4) //Fix X Position of Coin Icon Left

.org 0x80080014
addiu a3, r0, ((SCREEN_W-80)*4) //Fix X Position of Coin Icon Right

.org 0x80080144
addiu a1, r0, (SCREEN_W-80) //Fix X Position of Coin Cross

.org 0x80080180
addiu a1, r0, (SCREEN_W-62) //Fix X Position of Coin Number

.org 0x80080420
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of HUD Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of HUD Ortho

.org 0x80080468
li.u at, (SCREEN_W_FLOAT/SCREEN_H) //Load HUD Aspect Ratio Low Part
li.l at, (SCREEN_W_FLOAT/SCREEN_H) //Load HUD Aspect Ratio High Part

.org 0x80081E24
addiu a0, r0, (SCREEN_W/2) //Fix Centering of Golf Hole Sub-Viewport 1

.org 0x80081ED4
addiu a0, r0, (SCREEN_W/2) //Fix Centering of Golf Hole Sub-Viewport 2

.org 0x80082460
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Ground Type Text

.org 0x800824A8
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Hole Distance Text

.org 0x80084644
li.u at, ((SCREEN_W_FLOAT/2)-14) //Fix X Position of Boo Distance

.org 0x800854C4
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Boo Wings

.org 0x8008555C
li.u at, ((SCREEN_W_FLOAT/2)-60) //Fix X Position of Top Right Boo

.org 0x80085774
li.u at, -((SCREEN_W_FLOAT/2)-32) //Fix X Position of Golf Club Icon

.org 0x80085B18
addiu v0, v0, ((SCREEN_W/2)-48) //Fix X Position of Golf Ground Icon

.org 0x80085B54
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Boo Wings

.org 0x8008658C
li.u at, -((((SCREEN_W_FLOAT/2)-20)*240)/140) //Fix X Position of Flag

.org 0x80086AB8
addiu v1, v1, - (SCREEN_W/2) //Fix X Offset of Glow Effect

.org 0x80087F18
addiu v0, t0, (SCREEN_W-40) //Fix X Position of Aim Dot

.org 0x80087F48
addiu t0, t0, (SCREEN_W-56) //Fix X Position of Aim Dot

.org 0x8008810C
li.u at, ((SCREEN_W_FLOAT/2)-64) //Fix X Position of Mode Icon

.org 0x80088984
li a3, (0xE4000000|((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Bottom Rectangle for Bars

.org 0x800889B4
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Top Rectangle for Black Bars

.org 0x80089228
addiu v1, v1, (SCREEN_W-74) //Fix X Position of Golf UI

.org 0x8008B928
addiu a1, a1, (SCREEN_W-80) //Fix X Position of Golf Roughness Value

.org 0x8008BC20
addiu a1, r0, ((SCREEN_W/2)-28) //Fix X Position of Yardage

.org 0x8008CED4
addiu a1, r0, ((SCREEN_W/2)+8) //Fix X Position of Speed Golf Record

.org 0x8008CFD8
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Course Name in Intro

.org 0x8008D048
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Hole Number in Intro

.org 0x8008D200
li.u at, (SCREEN_W_FLOAT-16) //Fix Max X Position of Sun Ray

.org 0x8008D268
addiu v0, r0, SCREEN_W //Load Screen Pitch
multu v0, v1 //Calculate Row Offset
mflo v0 //Get Row Offset

.org 0x8008D308
li.u at, (SCREEN_W_FLOAT+120) //Fix Max X Position of Sun Ray

.org 0x8008D4D8
li.u at, (SCREEN_W_FLOAT-16) //Fix Max X Position of Sun Ray

.org 0x8008D5AC
li.u at, SCREEN_W_FLOAT //Fix Right X Position of Sun Rays

.org 0x8008D5BC
li.u at, (SCREEN_W_FLOAT/2) //Fix Center X Position of Sun Rays

.org 0x8008D99C
li.u at, (SCREEN_W_FLOAT/2) //Fix Center X Position of Sun Rays

.org 0x8008D57C
li.u at, (SCREEN_W_FLOAT+120) //Fix Max X Position of Sun Ray

.org 0x80090668
li.u at, (SCREEN_W_FLOAT+64) //Fix Maximum X Position of Sun

.org 0x8009299C
lui v0, (((SCREEN_W/2)-152) >> 2) //Fix Left Edge of Transitions

.org 0x800929AC
//Fix Offset of Right Edge of Transitions
j 0x800929C4
addiu v1, v1, (((SCREEN_W/2)-152)*4)

.org 0x80092A4C
lui v0, (0xE400|(((SCREEN_W/2)+152) >> 2)) //Fix Right Edge of Transitions

.org 0x80092A58
addiu v0, r0, ((SCREEN_W/2)+160) //Fix Offset of Right Transition Edge

.org 0x80092D0C
lui v1, (0xE400|(((SCREEN_W/2)+152) >> 2)) //Fix Right Edge of Dissolve Fades

.org 0x80092D20
lui v1, (((SCREEN_W/2)-152) >> 2) //Fix Left Edge of Dissolve Fades

.org 0x800931B0
addiu a0, a2, ((SCREEN_W/2)-114) //Fix X Offset Of Right of Circle Square

.org 0x800931D8
addiu a2, a2, ((SCREEN_W/2)-152) //Fix X Offset Of Left of Circle Square

.org 0x800933E8
addiu a0, a3, ((SCREEN_W/2)-114) //Fix X Offset Of Right of Circle Fade

.org 0x80093414
addiu a3, a3, ((SCREEN_W/2)-152) //Fix X Offset Of Left of Circle Fade

.org 0x80093740
ori a3, a3, (SCREEN_W-1) //Fix Pause Framebuffer Copy Width

.org 0x80093750
lui t5, hi(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Pause Background Rect Load Hi
addiu t5, t5, lo(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Pause Background Rect Load Lo

.org 0x800937C8
ori v0, v0, (SCREEN_W-1) //Fix Pause Framebuffer Copy Width

.org 0x80093808
lui v0, hi(0x07000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Hi
addiu v0, v0, lo(0x07000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Lo

.org 0x8009385C
lui v0, hi(((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Hi
addiu v0, v0, lo(((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Lo

.org 0x80093814
//Fix Row Height
addiu v1, r0, FBCOPY_ROW_H
j 0x8009382C
addiu a0, v1, 7

.org 0x80093884
lui a0, hi(0xE4000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Hi
addiu a0, a0, lo(0xE4000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Lo

.org 0x80093948
lui v0, (FBCOPY_ROW_H*4) //Fix Row Tile Advance

.org 0x80093950
//Fix Row Advance
addiu t1, t1, (FBCOPY_ROW_H*4)
addiu t3, t3, FBCOPY_ROW_H
addiu a3, a3, (SCREEN_W*FBCOPY_ROW_H*2)

.org 0x80093960
addiu v0, r0, FBCOPY_ROW_NUM

.org 0x8009398C
ori a1, a1, (SCREEN_W-1) //Fix Pause Old Framebuffer Copy Width

.org 0x80093BA4
li s2, (0xE4000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Top-Down View Camera

.org 0x80093E28
lui t7, hi(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Pause Background Rect Load Hi
addiu t7, t7, lo(0xF5100000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Pause Background Rect Load Lo

.org 0x80093E50
ori v0, v0, (SCREEN_W-1) //Fix Pause Background Pitch

.org 0x80093E5C
lui a0, hi(0x07000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Hi
addiu a0, a0, lo(0x07000000|((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Lo

.org 0x80093E6C
lui a2, hi(((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Hi
addiu a2, a2, lo(((SCREEN_W-9) << 14)) //Fix Pause Background Rect Load Lo

.org 0x80093EC0
//Fix Row Height
addiu v0, r0, FBCOPY_ROW_H
j 0x80093ED8
addiu v1, v0, 7

.org 0x80093F44
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Pause Background Rect

.org 0x80093FD4
lui v0, (FBCOPY_ROW_H*4) //Fix Row Tile Advance

.org 0x80093FDC
//Fix Row Advance
addiu t2, t2, (FBCOPY_ROW_H*4)
addiu t5, t5, FBCOPY_ROW_H
addiu t4, t4, (SCREEN_W*FBCOPY_ROW_H*2)

.org 0x80093FEC
addiu v0, r0, FBCOPY_ROW_NUM

.org 0x80094014
lui t7, hi(0xF5700000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Sepia Pause Background Rect Load Hi
addiu t7, t7, lo(0xF5700000|((((SCREEN_W-16)+3)/4) << 9)) //Fix Sepia Pause Background Rect Load Lo

.org 0x80094048
ori v0, v0, (SCREEN_W-1) //Fix Sepia Pause Background Pitch

.org 0x80094054
lui a0, hi(0x07000000|((SCREEN_W-9) << 14)) //Fix Sepia Pause Background Rect Load Hi
addiu a0, a0, lo(0x07000000|((SCREEN_W-9) << 14)) //Fix Sepia Pause Background Rect Load Lo

.org 0x800940B8
//Fix Row Height
addiu v0, r0, FBCOPY_ROW_H
j 0x800940D0
addiu v1, v0, 7

.org 0x80094064
lui a2, hi(((SCREEN_W-9) << 14)) //Fix Sepia Pause Background Rect Load Hi
addiu a2, a2, lo(((SCREEN_W-9) << 14)) //Fix Sepia Pause Background Rect Load Lo

.org 0x8009413C
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Pause Background Rect

.org 0x800941CC
lui v0, (FBCOPY_ROW_H*4) //Fix Row Tile Advance

.org 0x800941D4
//Fix Row Advance
addiu t2, t2, (FBCOPY_ROW_H*4)
addiu t5, t5, FBCOPY_ROW_H
addiu t4, t4, (SCREEN_W*FBCOPY_ROW_H*2)

.org 0x800941E4
addiu v0, r0, FBCOPY_ROW_NUM


.org 0x800951AC
addiu a2, r0, ((SCREEN_W/2)*8)+((SCREEN_W/4)-80) //Fix Tile Framebuffer Copy Offset

.org 0x800951F0
addiu a2, a2, (SCREEN_W/2) //Fix Tile Framebuffer Copy Row Pitch

.org 0x80095210
addiu t4, t4, (32*(SCREEN_W/2)) //Fix Tile Framebuffer Copy Tile Pitch

.org 0x80095318
addiu a2, r0, ((SCREEN_W/4)+76) //Fix Framebuffer Copy Row End

.org 0x80095320
addiu a1, r0, ((SCREEN_W/2)*8) //Fix CPU FB Copy Offset

.org 0x80095324
addiu a0, r0, ((SCREEN_W/4)-76) //Fix Framebuffer Copy Row Start

.org 0x8009535C
addiu a1, a1, (SCREEN_W/2) //Fix CPU FB Copy Pitch

.org 0x800B6688
//CFB Addresses
.dw CFB_ADDR
.dw (CFB_ADDR+(SCREEN_W*SCREEN_H*2))
.dw (CFB_ADDR+(2*(SCREEN_W*SCREEN_H*2)))

.org 0x800B66EC
.dw ((SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Reset Scissor

.org 0x800B67D8
//CFB Addresses
.dw CFB_ADDR
.dw (CFB_ADDR+(SCREEN_W*SCREEN_H*2))
.dw (CFB_ADDR+(2*(SCREEN_W*SCREEN_H*2)))

.org 0x800B6814
.dw (ZBUF_ADDR+(SCREEN_W*SCREEN_H*2)) //Fix Z Buffer Copy Address

.org 0x800C5EE0
.dw (ZBUF_ADDR+(SCREEN_W*SCREEN_H*2)) //Fix Z Buffer Pause Copy Address

.org 0x800B7790
.dh (SCREEN_W*2) //Fix Viewport 1 Width

.org 0x800B7798
.dh (SCREEN_W*2) //Fix Viewport 1 X Position

.org 0x800B77A0
.dh (SCREEN_W*2) //Fix Viewport 2 Width

.org 0x800B77A8
.dh (SCREEN_W*2) //Fix Viewport 2 X Position

.org 0x800C8318
.dw SCREEN_W //VI Framebuffer Width

.org 0x800C8330
.dw ((SCREEN_W*512)/320) //VI Framebuffer Width

.org 0x800C8338
.dw (SCREEN_W*2) //VI Field 1 Framebuffer Offset

.org 0x800C834C
.dw (SCREEN_W*2) //VI Field 2 Framebuffer Offset

.org 0x800C8BD8
.dw SCREEN_W //VI Framebuffer Width

.org 0x800C8BF0
.dw ((SCREEN_W*512)/320) //VI Framebuffer Width

.org 0x800C8BF8
.dw (SCREEN_W*2) //VI Field 1 Framebuffer Offset

.org 0x800C8C0C
.dw (SCREEN_W*2) //VI Field 2 Framebuffer Offset

.headersize 0x801F4A30-0xADD30 //Game Segment

.org 0x801F4ACC
addiu v0, r0, SCREEN_W //Fix Start X Position of Final Results

.org 0x801F7960
addiu a3, a3, (SCREEN_W/2) //Fix X Position of Course Icon Course Icon

.org 0x801F7A78
addiu a1, a3, ((SCREEN_W/2)-80) //Fix X Position of Course Open Icon

.org 0x801F7A88
addiu a3, a3, ((SCREEN_W/2)+80) //Fix X Position of Course Open Icon

.org 0x801F7C14
addiu a1, a3, ((SCREEN_W/2)-80) //Fix X Position of Course Open Icon Glow

.org 0x801F7C24
addiu a3, a3, ((SCREEN_W/2)+80) //Fix X Position of Course Open Icon Glow

.org 0x801F7EEC
addiu a1, a3, ((SCREEN_W/2)-80) //Fix X Position of Course Open Icon Glow

.org 0x801F7F00
addiu a3, a3, ((SCREEN_W/2)+80) //Fix X Position of Course Open Icon Glow

.org 0x801F8294
addiu a3, a3, (SCREEN_W/2) //Fix X Position of Got Character Box

.org 0x801F8390
addiu a3, a3, (SCREEN_W/2) //Fix X Position of Got Character Icon

.org 0x801F8534
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Got Character Text

.org 0x801F8558
addiu a3, a3, -(SCREEN_W/2) //Fix X Position of Got Character Text

.org 0x801F8728
addiu a3, a3, (SCREEN_W/2) //Fix X Position of Got Character Glow

.org 0x801F899C
addiu a1, a3, ((SCREEN_W/2)-72) //Fix X Position of Got Character Icon Glow

.org 0x801F89AC
addiu a3, a3, ((SCREEN_W/2)+72) //Fix X Position of Got Character Icon Glow

.org 0x801F8B9C
addiu v0, r0, SCREEN_W //Fix Slide In of Golf Textbox

.org 0x801F8CA4
slti v0, v0, -SCREEN_W //Fix Slide Out of Golf Textbox

.org 0x801F8D78
addiu a0, a0, ((SCREEN_W/2)-94) //Fix X Position of Golf Trophy Text

.org 0x801F8E6C
addiu a0, a0, ((SCREEN_W/2)-94) //Fix X Position of Golf Trophy Rank Text

.org 0x801F8EE0
addiu a0, a0, ((SCREEN_W/2)+8) //Fix X Position of Golf Trophy Experience Text

.org 0x801F90BC
addiu a1, a3, ((SCREEN_W/2)-136) //Fix X Position of Trophy Window

.org 0x801F90CC
addiu a3, a3, ((SCREEN_W/2)+136) //Fix X Position of Trophy Window

.org 0x801F9104
addiu a1, a3, ((SCREEN_W/2)-136) //Fix X Position of Trophy Window

.org 0x801F9114
addiu a3, a3, ((SCREEN_W/2)+136) //Fix X Position of Trophy Window

.org 0x801F94EC
addiu a1, v1, -((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy

.org 0x801F94F8
addiu v1, v1, ((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy

.org 0x801F97D4
addiu a1, v1, -((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy Glow

.org 0x801F97E0
addiu v1, v1, ((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy Glow

.org 0x801F9A28
addiu a1, v1, -((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy Glow

.org 0x801F9A44
addiu v1, v1, ((SCREEN_W/2)-112) //Fix X Offset of Gold Trophy Glow

.org 0x801FAD6C
addiu a1, a1, ((SCREEN_W/2)-120) //Fix X Position of Results Rank

.org 0x801FADE8
addiu a1, a1, ((SCREEN_W/2)-60) //Fix X Position of Results Icon

.org 0x801FAE0C
addiu a1, a1, ((SCREEN_W/2)-16) //Fix X Position of Results Score Text

.org 0x801FAE30
addiu a1, a1, ((SCREEN_W/2)+72) //Fix X Position of Results Experience Text

.org 0x801FAE88
addiu a0, a0, ((SCREEN_W/2)-128) //Fix X Position of All Courses Text

.org 0x801FAEB8
addiu a1, a1, ((SCREEN_W/2)-131) //Fix X Position of Extra Experience Number

.org 0x801FAF00
addiu a0, a0, ((SCREEN_W/2)-94) //Fix X Position of Extra Experience Text

.org 0x801FAFC8
addiu a1, a1, ((SCREEN_W/2)-8) //Fix X Position of Results Score Number

.org 0x801FB004
addiu a1, a1, ((SCREEN_W/2)+72) //Fix X Position of Results Experience Number

.org 0x801FB078
addiu a1, a1, ((SCREEN_W/2)-120) //Fix X Position of Time Result Player Icon

.org 0x801FB0E4
addiu a1, a1, ((SCREEN_W/2)-78) //Fix X Position of Time Result Score Text

.org 0x801FB108
addiu a1, a1, ((SCREEN_W/2)+72) //Fix X Position of Time Result Experience Text

.org 0x801FB160
addiu a0, a0, ((SCREEN_W/2)-128) //Fix X Position of All Courses Text

.org 0x801FB190
addiu a1, a1, ((SCREEN_W/2)-131) //Fix X Position of Extra Experience Number

.org 0x801FB1D8
addiu a0, a0, ((SCREEN_W/2)-94) //Fix X Position of Extra Experience Text

.org 0x801FB2A0
addiu a1, a1, ((SCREEN_W/2)-70) //Fix X Position of Time Result Stroke Number

.org 0x801FB3B8
addiu a1, a1, ((SCREEN_W/2)-70) //Fix X Position of Time Result Time Number

.org 0x801FB3F4
addiu a1, a1, ((SCREEN_W/2)+68) //Fix X Position of Time Result Experience Number

.org 0x801FB444
addiu a1, a1, ((SCREEN_W/2)-74) //Fix X Position of Time Result Stroke Text

.org 0x801FB484
addiu a1, a1, ((SCREEN_W/2)-74) //Fix X Position of Time Result Time Text

.org 0x801FB600
addiu a1, a1, ((SCREEN_W/2)-72) //Fix X Position of Course Get Score Text 1

.org 0x801FB624
addiu a1, a1, ((SCREEN_W/2)+32) //Fix X Position of Course Get Between Text 1

.org 0x801FB648
addiu a1, a1, ((SCREEN_W/2)+88) //Fix X Position of Course Get Experience Text 1

.org 0x801FB69C
addiu a1, a1, ((SCREEN_W/2)-142) //Fix X Position of Course Get Rank 1

.org 0x801FB6C8
addiu a1, a1, ((SCREEN_W/2)-110) //Fix X Position of Course Get Player Icon 1

.org 0x801FB704
addiu a1, a1, ((SCREEN_W/2)-16) //Fix X Position of Course Get Score Text 2

.org 0x801FB728
addiu a1, a1, ((SCREEN_W/2)+74) //Fix X Position of Course Get Experience Text 2

.org 0x801FB77C
addiu a1, a1, ((SCREEN_W/2)-128) //Fix X Position of Course Get Rank 2

.org 0x801FB7A8
addiu a1, a1, ((SCREEN_W/2)-96) //Fix X Position of Course Get Player Icon 2

.org 0x801FB844
addiu s6, s4, ((SCREEN_W/2)-4) //Fix X Position of Course Get Between 1

.org 0x801FB8E4
addiu a1, a1, ((SCREEN_W/2)-64) //Fix X Position of Course Get Score 1

.org 0x801FB97C
addiu a1, a1, ((SCREEN_W/2)+82) //Fix X Position of Course Get Experience 1

.org 0x801FBA54
addiu a1, a1, ((SCREEN_W/2)-8) //Fix X Position of Course Get Score 2

.org 0x801FBAA8
addiu a1, a1, ((SCREEN_W/2)+72) //Fix X Position of Course Get Experience 2

.org 0x801FBB18
addiu a0, a0, ((SCREEN_W/2)-128) //Fix X Position of All Courses Text

.org 0x801FBB38
addiu a1, a1, ((SCREEN_W/2)-131) //Fix X Position of Extra Experience Number

.org 0x801FBB7C
addiu a0, a0, ((SCREEN_W/2)-96) //Fix X Position of Extra Experience Text

.org 0x801FBCD0
addiu a1, a1, ((SCREEN_W/2)-8) //Fix X Position of Between Header

.org 0x801FBCF4
addiu a1, a1, ((SCREEN_W/2)+80) //Fix X Position of Experience Header

.org 0x801FBD1C
addiu a1, a1, ((SCREEN_W/2)-120) //Fix X Position of P1 Rank

.org 0x801FBD44
addiu a1, a1, ((SCREEN_W/2)-120) //Fix X Position of P2 Rank

.org 0x801FBD6C
addiu a1, a1, ((SCREEN_W/2)-98) //Fix X Position of P1 Player Icon

.org 0x801FBD98
addiu a1, a1, ((SCREEN_W/2)-98) //Fix X Position of P2 Player Icon

.org 0x801FBDB8
addiu a1, a1, ((SCREEN_W/2)+60) //Fix X Position of Experience Header

.org 0x801FBDE0
addiu a1, a1, ((SCREEN_W/2)-104) //Fix X Position of P1 Rank

.org 0x801FBE08
addiu a1, a1, ((SCREEN_W/2)-104) //Fix X Position of P2 Rank

.org 0x801FBE30
addiu a1, a1, ((SCREEN_W/2)-82) //Fix X Position of P1 Player Icon

.org 0x801FBE58
addiu a1, a1, ((SCREEN_W/2)-82) //Fix X Position of P2 Player Icon

.org 0x801FBFBC
addiu a1, v1, ((SCREEN_W/2)-80) //Fix X Position of Player Points Up

.org 0x801FC004
addiu a1, v1, ((SCREEN_W/2)-64) //Fix X Position of Player Points Up

.org 0x801FC144
addiu a1, a1, ((SCREEN_W/2)-112) //Fix X Position of Player Points Number

.org 0x801FC18C
addiu v0, t1, ((SCREEN_W/2)-32) //Fix X Position of Player Between Number

.org 0x801FC1E0
addiu a1, a1, ((SCREEN_W/2)+74) //Fix X Position of Player Experience Number

.org 0x801FC238
addiu a1, a1, ((SCREEN_W/2)-96) //Fix X Position of Player Points Number

.org 0x801FC29C
addiu a1, a1, ((SCREEN_W/2)+58) //Fix X Position of Player Experience Number

.org 0x801FC31C
addiu a0, a0, ((SCREEN_W/2)-128) //Fix X Position of All Courses Text

.org 0x801FC344
addiu a1, a1, ((SCREEN_W/2)-131) //Fix X Position of Extra Experience Number

.org 0x801FC388
addiu a0, a0, ((SCREEN_W/2)-96) //Fix X Position of Extra Experience Text

.org 0x801FC518
addiu a1, a3, ((SCREEN_W/2)-132) //Fix X Position of Cup Results Icon

.org 0x801FC55C
addiu a3, a3, ((SCREEN_W/2)-68) //Fix X Position of Cup Results Icon

.org 0x801FC594
addiu a1, a1, ((SCREEN_W/2)-64) //Fix X Position of Cup Results Player Icon

.org 0x801FC628
addiu a1, a3, ((SCREEN_W/2)-72) //Fix X Position of Cup Results Cup Name

.org 0x801FC638
addiu a3, a3, ((SCREEN_W/2)+72) //Fix X Position of Cup Results Cup Name

.org 0x801FC68C
addiu a1, a1, ((SCREEN_W/2)-64) //Fix X Position of Cup Results Player Icon

.org 0x801FC6C0
addiu a1, a1, (SCREEN_W/2) //Fix X Position of Cup Results Ranking

.org 0x801FC77C
addiu a0, a0, (SCREEN_W/2) //Fix X Position of Cup Results Text Name

.org 0x801FC7D4
addiu a0, a0, (SCREEN_W/2) //Fix X Position of Cup Results Course Name

.org 0x801FC828
addiu a0, a0, (SCREEN_W/2) //Fix X Position of Cup Results Type Name

.org 0x801FC900
addiu a1, a1, ((SCREEN_W/2)-16) //Fix X Position of Cup Results Score Text

.org 0x801FC97C
addiu a1, a1, ((SCREEN_W/2)+32) //Fix X Position of Cup Results Score Number

.org 0x801FCAC0
addiu a1, a1, ((SCREEN_W/2)-16) //Fix X Position of Cup Results Time Text

.org 0x801FCB18
addiu a1, a1, ((SCREEN_W/2)+32) //Fix X Position of Cup Results Time Number

.org 0x801FCB94
addiu a1, a1, ((SCREEN_W/2)-44) //Fix X Position of Cup Results Experience Text

.org 0x801FCC00
addiu a1, a1, ((SCREEN_W/2)-44) //Fix X Position of Cup Results Experience Text

.org 0x801FCDDC
addiu a1, a3, ((SCREEN_W/2)-144) //Fix X Position of Tall Final Results Window

.org 0x801FCDF0
addiu a3, a3, ((SCREEN_W/2)+144) //Fix X Position of Tall Final Results Window

.org 0x801FCEA4
addiu a1, a3, ((SCREEN_W/2)-144) //Fix X Position of Final Results Window

.org 0x801FCEB8
addiu a3, a3, ((SCREEN_W/2)+144) //Fix X Position of Final Results Window

.org 0x801FCFE0
addiu a1, a3, ((SCREEN_W/2)+112) //Fix X Position of Final Results A Button

.org 0x801FCFF0
addiu a3, a3, ((SCREEN_W/2)+136) //Fix X Position of Final Results A Button

.org 0x80210130
li.u at, (SCREEN_W_FLOAT+64) //Fix X Position of Lakitu Start

.org 0x802114F8
addiu a3, s0, (SCREEN_W/2) //Fix X Offset of Best Drive Left Sprite

.org 0x80211550
addiu a1, r0, (SCREEN_W/2) //Fix X Offset of Best Drive Right Sprite

.org 0x80211564
addiu a3, s0, -(SCREEN_W/2) //Fix X Offset of Best Drive Right Sprite

.org 0x8021161C
addiu a1, r0, ((SCREEN_W/2)-24) //Fix X Position of Best Drive Value

.org 0x80211C50
addiu a3, s0, (SCREEN_W/2) //Fix Right Side Birdie Putt 

.org 0x80211CA8
addiu a1, r0, (SCREEN_W/2) //Fix Left Side Birdie Putt Left Edge 

.org 0x80211CBC
addiu a3, s0, -(SCREEN_W/2) //Fix Left Side Birdie Putt Right Edge 

.org 0x802130FC
//Fix Speed of Lakitu
li.u at, (((SCREEN_W_FLOAT*192)/320)/30)
li.l at, (((SCREEN_W_FLOAT*192)/320)/30)

.org 0x80213A40
addiu a1, r0, (((SCREEN_W/2)-56)*4) //Fix X Position of Left Edge of OB Toad

.org 0x80213A48
addiu a3, r0, (((SCREEN_W/2)+56)*4) //Fix X Position of Right Edge of OB Toad

.org 0x8021634C
li.u at, (SCREEN_W_FLOAT/2) //Fix Default X Position of Shy Guy 

.org 0x80216420
li.u at, (SCREEN_W_FLOAT/2) //Fix Center X Position of Shy Guy Wind

.org 0x80217854
li.u at, (SCREEN_W_FLOAT/2) //Fix X Offset of Club Effects
 
.org 0x8021EE70
addiu v0, v1, ((SCREEN_W/2)-100) //Fix Power Bar Separator Right

.org 0x80219418
li.u at, ((SCREEN_W_FLOAT/2)+64) //Fix End X Offset of Top-Right Boo
 
.org 0x80219E98
addiu a1, r0, (((SCREEN_W/2)-128)*4) //Fix X Position of Pause Cloud Left

.org 0x80219EA0
addiu a3, r0, (((SCREEN_W/2)+128)*4) //Fix X Position of Pause Cloud Right

.org 0x80219F0C
addiu a1, r0, (((SCREEN_W/2)-128)*4) //Fix X Position of Pause Cloud Bottom Left

.org 0x80219F14
addiu a3, r0, (((SCREEN_W/2)+128)*4) //Fix X Position of Pause Cloud Bottom Right

.org 0x8021A10C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix Default X Position of Menu

.org 0x8021A120
addiu a0, r0, ((SCREEN_W/2)-80) //Fix Default X Position of Menu

.org 0x8021A1E4
addiu a1, r0, ((SCREEN_W/2)+52) //Fix X Position of Grid Color
addiu a1, r0, ((SCREEN_W/2)+52) //Fix X Position of Grid Color

.org 0x8021A228
addiu a1, r0, ((SCREEN_W/2)+52) //Fix X Position of Weather

.org 0x8021A234
addiu a1, r0, ((SCREEN_W/2)+52) //Fix X Position of Weather

.org 0x8021A53C
addi a1, r0, (((SCREEN_W/2)-104)*4) //Fix X Position of Pause Stick Cursor Left

.org 0x8021A554
addi a3, r0, (((SCREEN_W/2)-80)*4) //Fix X Position of Pause Stick Cursor Right

.org 0x8021A588
addi a1, r0, ((SCREEN_W/2)-104) //Fix X Position of Pause Cursor Left

.org 0x8021A5A8
addi a3, r0, ((SCREEN_W/2)-80) //Fix X Position of Pause Cursor Right

.org 0x8021AB98
addiu v0, r0, (SCREEN_W/2) //Fix X Position of Ring Cloud Left

.org 0x8021ABA0
addiu s5, s2, (SCREEN_W/2) //Fix X Position of Ring Cloud Right

.org 0x8021AD58
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Ring Cloud Text

.org 0x8021AEC4
addiu s0, s0, ((SCREEN_W/2)-36) //Fix X Position of Ring Cloud Cursor

.org 0x8021EE84
addiu v1, v1, ((SCREEN_W/2)-104) //Fix Power Bar Separator Left

.org 0x8021EF3C
addiu v0, v1, ((SCREEN_W/2)-100) //Fix Power Bar End Separator Right

.org 0x8021EF50
addiu v1, v1, ((SCREEN_W/2)-104) //Fix Power Bar End Separator Left

.org 0x8021EFA8
addiu t0, r0, ((SCREEN_W*2)-416) //Fix Right Edge of End Separator
addiu a3, r0, ((SCREEN_W*2)-400) //Fix Left Edge of End Separator

.org 0x8021F054
addiu t0, r0, ((SCREEN_W*2)-276) //Fix Right Edge of Dot Separator
addiu a3, r0, ((SCREEN_W*2)-260) //Fix Left Edge of Dot Separator

.org 0x8021F30C
lui a0, (0xE400|(((SCREEN_W/2)+40) >> 2)) //Fix Right X Position of Power Bar Color

.org 0x8021F364
addiu v1, r0, ((SCREEN_W/2)+36) //Fix X Position of Power Bar Color

.org 0x8021F550
lui v1, (0xE400|(((SCREEN_W/2)+40) >> 2)) //Fix Right X Position of Power Bar End

.org 0x8021F5B4
lui v0, (((SCREEN_W/2)+36) >> 2) //Fix Left X Position of Power Bar End

.org 0x8021F7F8
addiu v1, r0, ((SCREEN_W/2)+40) //Fix Right X Position of Power Bar Start

.org 0x8021F838
addiu v0, r0, ((SCREEN_W/2)+36) //Fix Left X Position of Power Bar Start

.org 0x8021F990
addiu v1, r0, ((SCREEN_W/2)+40) //Fix Right X Position of Power Bar Aim

.org 0x8021F9D8
addiu v0, r0, ((SCREEN_W/2)+36) //Fix Left X Position of Power Bar Aim

.org 0x80224764
.float ((SCREEN_W_FLOAT/2)-60) //Fix X Position of Vertex 2 of Shy Guy Wind

.org 0x80224770
.float ((SCREEN_W_FLOAT/2)-0) //Fix X Position of Vertex 3 of Shy Guy Wind

.org 0x8022477C
.float ((SCREEN_W_FLOAT/2)+20) //Fix X Position of Vertex 4 of Shy Guy Wind

.org 0x80224788
.float ((SCREEN_W_FLOAT/2)+20) //Fix X Position of Vertex 5 of Shy Guy Wind

.org 0x80224794
.float ((SCREEN_W_FLOAT/2)+10) //Fix X Position of Vertex 6 of Shy Guy Wind

.org 0x802247A0
.float ((SCREEN_W_FLOAT/2)-10) //Fix X Position of Vertex 7 of Shy Guy Wind

.org 0x802247AC
.float ((SCREEN_W_FLOAT/2)-30) //Fix X Position of Vertex 8 of Shy Guy Wind

.org 0x802247B8
.float ((SCREEN_W_FLOAT/2)-45) //Fix X Position of Vertex 9 of Shy Guy Wind

.org 0x802247C4
.float ((SCREEN_W_FLOAT/2)-60) //Fix X Position of Vertex 10 of Shy Guy Wind

.org 0x802247D0
.float ((SCREEN_W_FLOAT/2)-65) //Fix X Position of Vertex 11 of Shy Guy Wind

.org 0x802247DC
.float ((SCREEN_W_FLOAT/2)-60) //Fix X Position of Vertex 12 of Shy Guy Wind

.org 0x802247E8
.float ((SCREEN_W_FLOAT/2)-40) //Fix X Position of Vertex 13 of Shy Guy Wind

.org 0x802247F4
.float ((SCREEN_W_FLOAT/2)-15) //Fix X Position of Vertex 14 of Shy Guy Wind

.org 0x80224800
.float ((SCREEN_W_FLOAT/2)+40) //Fix X Position of Vertex 15 of Shy Guy Wind

.org 0x8022480C
.float (SCREEN_W_FLOAT-35) //Fix X Position of Vertex 16 of Shy Guy Wind

.org 0x80224818
.float (SCREEN_W_FLOAT+10) //Fix X Position of Vertex 17 of Shy Guy Wind

.org 0x80224824
.float (SCREEN_W_FLOAT+40) //Fix X Position of Vertex 18 of Shy Guy Wind

.org 0x80224830
.float (SCREEN_W_FLOAT+60) //Fix X Position of Vertex 19 of Shy Guy Wind

.org 0x8022483C
.float (SCREEN_W_FLOAT+60) //Fix X Position of Vertex 20 of Shy Guy Wind

.headersize 0x801F4A30-0xDE9B0 //Menu Segment

.org 0x801F8B08
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Play Mode Textbox

.org 0x801F8B28
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Play Mode Textbox

.org 0x801F8B4C
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Play Mode Textbox

.org 0x801FB75C
lui t5, (155648/(SCREEN_W-16)) //Fix Course Select Background Scale

.org 0x801FB79C
lui a1, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Course Select Background Top Row

.org 0x801FB8E4
lui v1, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Course Select Background Bottom Row

.org 0x801FB930
lui v1, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Course Select Background Bottom Row

.org 0x801FB9F4
lui t6, (155648/(SCREEN_W-16)) //Fix Main Menu Background Scale

.org 0x801FBA44
lui a2, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Main Menu Background Top Row

.org 0x801FBBFC
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Main Menu Background

.org 0x801FBEF8
lui v1, (0xE400|(((SCREEN_W/2)+128) >> 2)) //Fix Right Edge of Main Menu

.org 0x801FBF18
lui v1, (((SCREEN_W/2)-128) >> 2) //Fix Left Edge of Main Menu

.org 0x801FC4F4
lui v0, (0xE400|(((SCREEN_W/2)+100) >> 2)) //Fix Right Edge of Main Menu Header

.org 0x801FC524
lui v1, (((SCREEN_W/2)-100) >> 2) //Fix Left Edge of Main Menu Header

.org 0x801FC7B0
lui s5, (155648/(SCREEN_W-16)) //Fix Continue Background Scale

.org 0x801FC8B0
lui a2, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Continue Background Top Row

.org 0x801FCA94
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Continue Background

.org 0x801FD630
//Fix Rectangle for Tournament Window
lui a2, hi(((SCREEN_W/2)-134) << 14)
addiu a2, a2, lo(((SCREEN_W/2)-134) << 14)

.org 0x801FD6D8
//Fix Rectangle for Tournament Window
lui v1, (0xE400|(((SCREEN_W/2)+136) >> 2))

.org 0x801FD960
lui v1, (0xE400|(((SCREEN_W/2)+100) >> 2)) //Fix Right Edge of Character Select Header

.org 0x801FD980
lui v1, (((SCREEN_W/2)-100) >> 2) //Fix Left Edge of Character Select Header

.org 0x801FDAB4
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Point of Menu Game Number

.org 0x801FDB04
addiu a1, r0, ((SCREEN_W/2)-128) //Fix X Point of Menu Stat Number

.org 0x801FE53C
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x801FF57C
lui v1, (0xE400|(((SCREEN_W/2)+100) >> 2)) //Fix Right Edge of Play Mode Box

.org 0x801FF59C
lui v1, (((SCREEN_W/2)-80) >> 2) //Fix Left Edge of Play Mode Box

.org 0x801FF738
lui v1, (0xE400|(((SCREEN_W/2)+80) >> 2)) //Fix Right Edge of Play Mode Box

.org 0x801FF758
lui v1, (((SCREEN_W/2)-80) >> 2) //Fix Left Edge of Play Mode Box

.org 0x801FF998
andi a1, a1, 0xA //Fix Bitmask for Tournament Sprite Position
addiu a1, a1, (SCREEN_W/2) //Fix Offset for Tournament Sprite Position

.org 0x802002F8
addiu a2, s1, (SCREEN_W-96) //Fix X Position of Coin Icon on Play Mode Screen

.org 0x80200308
addiu a1, s1, (SCREEN_W-70) //Fix X Position of Coin Number on Play Mode Screen

.org 0x80200400
addiu a1, s1, (SCREEN_W-96) //Fix X Position of Star Icon on Play Mode Screen

.org 0x80200418
addiu a1, s1, (SCREEN_W-70) //Fix X Position of Star Number on Play Mode Screen

.org 0x802010C0
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Player Projection
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Player Projection

.org 0x80201DD0
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Player Projection
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Player Projection

.org 0x802020F4
li.u at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x802031B4
addiu a2, s2, (SCREEN_W-94) //Fix X Position of Course Select Coin Icon

.org 0x80204010
addiu a1, s2, (SCREEN_W-68) //Fix X Position of Course Select Coin Number

.org 0x802040C0
li t2, (0xE4000000|(((SCREEN_W/2)+52) << 14)|(160 << 2)) //Fix Rectangle for Next Course Window

.org 0x802040C8
li t1, ((((SCREEN_W/2)-52) << 14)|(100 << 2)) //Fix Rectangle for Next Course Window

.org 0x802041DC
addiu a0, r0, ((SCREEN_W/2)-49) //Fix X Position of Next Course Text

.org 0x80204930
lui a3, hi(0xE4000000|(((SCREEN_W/2)+117) << 14)) //Fix Rectangle Right for Stroke Play Window
addiu a3, a3, lo(0xE4000000|(((SCREEN_W/2)+117) << 14)) //Fix Rectangle Right for Stroke Play Window

.org 0x80204938
lui t0, hi((((SCREEN_W/2)-113) << 14)) //Fix Rectangle Left for Next Course Window

.org 0x80204948
addiu t0, t0, lo((((SCREEN_W/2)-113) << 14)) //Fix Rectangle Left for Next Course Window

.org 0x80204AEC
addiu v0, r0, ((SCREEN_W/2)+97) //Fix X Position of Left Edge of Course Name Window

.org 0x80204B20
addiu a1, a1, ((SCREEN_W/2)-93) //Fix X Position of Left Edge of Course Name Window

.org 0x80204ED8
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Course Names

.org 0x80204F74
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Course Game Type

.org 0x80206B44
addiu a1, r0, ((SCREEN_W-106)*4) //Fix X Position of Left of Menu Mario Shadow

.org 0x80206B50
addiu a3, r0, ((SCREEN_W-2)*4) //Fix X Position of Right of Menu Mario Shadow

.org 0x80206CE8
addiu a1, r0, ((SCREEN_W-112)*4) //Fix X Position of Left of Menu Mario

.org 0x80206CF0
addiu a3, r0, ((SCREEN_W-12)*4) //Fix X Position of Right of Menu Mario

.org 0x80207C20
addiu a3, r0, (SCREEN_W/2) //Fix X Position of Erase Window

.org 0x80207C4C
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Erase Warning

.org 0x8020B810
addiu a0, r0, ((SCREEN_W/2)+78) //Fix X Position of Character Name

.org 0x8020B8B4
addiu a1, r0, ((SCREEN_W/2)+86) //Fix X Position of Character Drive Distance

.org 0x8020B8DC
addiu a0, r0, ((SCREEN_W/2)-135) //Fix X Position of Character Select Text

.org 0x8020B978
addiu a0, r0, ((SCREEN_W/2)-135) //Fix X Position of Character Select Text

.org 0x8020B990
addiu a0, r0, ((SCREEN_W/2)-135) //Fix X Position of Character Select Text

.org 0x8020BCAC
addiu v0, a0, ((SCREEN_W/2)-104) //Fix X Position of Right Edge of Characters

.org 0x8020BCC8
andi v1, v1, 0xFFC //Fix Bitmask for Character Right Edge

.org 0x8020BCD4
addiu a0, a0, ((SCREEN_W/2)-136) //Fix X Position of Left Edge of Characters

.org 0x8020BCF4
andi v1, v1, 0xFFC //Fix Bitmask for Character Left Edge

.org 0x8020BF04
addiu v0, a0, ((SCREEN_W/2)-104) //Fix X Position of Right Edge of Characters

.org 0x8020BF20
andi v1, v1, 0xFFC //Fix Bitmask for Character Right Edge

.org 0x8020BF2C
addiu a0, a0, ((SCREEN_W/2)-136) //Fix X Position of Left Edge of Characters

.org 0x8020BF4C
andi v1, v1, 0xFFC //Fix Bitmask for Character Left Edge

.org 0x8020C578
lui v1, (0xE400|(((SCREEN_W/2)+144) >> 2)) //Fix Right Edge of Character Select Box

.org 0x8020C598
lui v1, (((SCREEN_W/2)-144) >> 2) //Fix Left Edge of Character Select Box

.org 0x8020C688
addiu a1, r0, (((SCREEN_W/2)+40)*4) //Fix X Position of Drive Text Left Edge

.org 0x8020C690
addiu a3, r0, (((SCREEN_W/2)+80)*4) //Fix X Position of Drive Text Right Edge

.org 0x8020CAF8
addiu a1, a1, ((SCREEN_W/2)-132) //Fix X Position of Player Numbers

.org 0x8020CE54
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Cursor Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Cursor Ortho

.org 0x8020D3FC
li t3, (0xE4000000|((SCREEN_W-18) << 14)|(44 << 2)) //Fix Rectangle for COM Button

.org 0x8020D408
li t2, (((SCREEN_W-50) << 14)|(20 << 2)) //Fix Rectangle for COM Button

.org 0x8020DD6C
addiu t5, v1, (((SCREEN_W/2)+44)*4) //Fix X Position of Left Edge of Stat Bar

.org 0x8020DD78
addiu t3, v1, (((SCREEN_W/2)+52)*4) //Fix X Position of Right Edge of Stat Bar

.org 0x8020DFAC
addiu a1, r0, (((SCREEN_W/2)+50)*4) //Fix X Position of Left Edge of Stat Icon

.org 0x8020DFB4
addiu a3, r0, (((SCREEN_W/2)+114)*4) //Fix X Position of Right Edge of Stat Icon

.org 0x8020E8F8
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x8020F220
addiu v0, r0, (SCREEN_W/2) //Fix X Position of Tournament Data Arrows

.org 0x8020F584
lui v1, (0xE400|(((SCREEN_W/2)+100) >> 2)) //Fix Right Edge of Course Name Box

.org 0x8020F5A4
lui v1, (((SCREEN_W/2)-100) >> 2) //Fix Left Edge of Course Name Box

.org 0x8020F748
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Course Name

.org 0x8020F800
li t3, (0xE4000000|(((SCREEN_W/2)+140) << 14)|(230 << 2)) //Fix Rectangle for Tournament Data

.org 0x8020F808
li t2, ((((SCREEN_W/2)-136) << 14)|(138 << 2)) //Fix Rectangle for Tournament Data

.org 0x8020F924
addiu a1, r0, ((SCREEN_W/2)-130) //Fix X Position of Rows in Tournament Data

.org 0x8020FA64
addiu a1, r0, ((SCREEN_W/2)-64) //Fix X Position of Round Number in Tournament Data

.org 0x8020FAE8
addiu a1, r0, ((SCREEN_W/2)-16) //Fix X Position of 1-Digit Best Score in Tournament Data

.org 0x8020FB14
addiu a1, r0, ((SCREEN_W/2)-32) //Fix X Position of 2-Digit Best Score in Tournament Data

.org 0x8020FB38
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of 3-Digit Best Score in Tournament Data

.org 0x8020FB74
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Average in Tournament Data

.org 0x8020FB7C
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Best Drive Number in Tournament Data

.org 0x8020FBC0
addiu a1, r0, ((SCREEN_W/2)+18) //Fix X Position of Best Drive Unit in Tournament Data

.org 0x8020FBE8
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Average Drive Number in Tournament Data

.org 0x8020FC18
addiu a1, r0, ((SCREEN_W/2)+18) //Fix X Position of Average Drive Unit in Tournament Data

.org 0x8020FC4C
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Fairway Percentage in Tournament Data

.org 0x8020FC54
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Average Putt in Tournament Data

.org 0x8020FCA8
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Par Saves Number in Tournament Data

.org 0x8020FCCC
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Par Ons Number in Tournament Data

.org 0x8020FCD4
addiu a1, r0, ((SCREEN_W/2)-48) //Fix X Position of Sand Saves Number in Tournament Data

.org 0x8020FD04
addiu a1, r0, ((SCREEN_W/2)+18) //Fix X Position of Bottom Number Unit in Tournament Data

.org 0x80210148
addiu a2, s0, ((SCREEN_W/2)+62) //Fix X Position of Coin Icon in Tournament Data

.org 0x80210158
addiu a1, s0, ((SCREEN_W/2)+90) //Fix X Position of Coin Number in Tournament Data

.org 0x80210448
lui v1, (0xE400|(((SCREEN_W/2)-112) >> 2)) //Fix Right Edge of Arrow in Tournament Data

.org 0x80210458
lui v1, (((SCREEN_W/2)-128) >> 2) //Fix Left Edge of Arrow in Tournament Data

.org 0x8021056C
addiu a0, r0, ((SCREEN_W/2)+30) //Fix X Position of Point Number in Tournament Data

.org 0x8021058C
addiu a0, r0, ((SCREEN_W/2)+32) //Fix X Position of Point Number in Tournament Data

.org 0x802137B0
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x80214134
addiu v0, r0, (SCREEN_W/2) //Fix X Position of Speed Golf Cursor

.org 0x8021418C
li t2, (0xE4000000|(((SCREEN_W/2)+142) << 14)|(230 << 2)) //Fix Rectangle for Speed Golf Data

.org 0x80214194
li t1, ((((SCREEN_W/2)-136) << 14)|(138 << 2)) //Fix Rectangle for Speed Golf Data

.org 0x80214248
addiu a1, r0, ((SCREEN_W/2)-138) //Fix X Position of Speed Golf Rank

.org 0x8021429C
addiu a1, r0, ((SCREEN_W/2)-88) //Fix X Position of Speed Golf Time

.org 0x802142D8
addiu a1, r0, ((SCREEN_W/2)+30) //Fix X Position of Speed Golf Score

.org 0x802143C8
addiu a1, r0, ((SCREEN_W/2)+100) //Fix X Position of Speed Golf Face

.org 0x8021443C
addiu a1, a1, ((SCREEN_W/2)-88) //Fix X Position of Speed Golf Empty Score

.org 0x80215AD0
addiu a0, r0, ((SCREEN_W/2)+4) //Fix X Position of Bottom Right VS Match

.org 0x80215B04
addiu v0, r0, ((SCREEN_W/2)-92) //Fix X Position of Top Left VS Match

.org 0x80215B28
addiu v0, r0, ((SCREEN_W/2)-92) //Fix X Position of Top Left VS Match

.org 0x80215B4C
addiu a0, r0, ((SCREEN_W/2)+4) //Fix X Position of Bottom Right VS Match

.org 0x80215E40
li t1, (0xE4000000|(((SCREEN_W/2)+142) << 14)|(230 << 2)) //Fix Rectangle for VS Data

.org 0x80215E48
li t0, ((((SCREEN_W/2)-136) << 14)|(50 << 2)) //Fix Rectangle for VS Data

.org 0x80216084
addiu a3, r0, ((SCREEN_W/2)-132) //Fix X Position of Left Column Icons

.org 0x8021614C
addiu a3, a3, ((SCREEN_W/2)-98) //Fix X Position of Top Row Icons

.org 0x80216198
addiu a1, a1, ((SCREEN_W/2)-98) //Fix X Position of VS Record Stars

.org 0x802161CC
addiu a1, a1, ((SCREEN_W/2)-93) //Fix X Position of VS Record Cross

.org 0x802161FC
addiu a1, a1, ((SCREEN_W/2)-93) //Fix X Position of VS Record Number

.org 0x80216224
addiu a1, a1, ((SCREEN_W/2)-93) //Fix X Position of VS Record Dash

.org 0x80216290
addiu v0, r0, ((SCREEN_W/2)-120) //Fix X Position of Top VS Arrow

.org 0x802162C8
addiu v0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bottom VS Arrow

.org 0x802162FC
addiu v0, r0, ((SCREEN_W/2)-96) //Fix X Position of Left VS Arrow

.org 0x80216334
addiu v0, r0, ((SCREEN_W/2)+136) //Fix X Position of Right VS Arrow

.org 0x80216540
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of VS Cursor Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of VS Cursor Ortho

.org 0x80216CB8
addiu v0, r0, ((SCREEN_W/2)+4) //Fix X Position of Bottom Right VS Match

.org 0x80216CD0
addiu v0, r0, ((SCREEN_W/2)-92) //Fix X Position of Top Left VS Match

.org 0x80216D04
addiu v0, r0, ((SCREEN_W/2)-92) //Fix X Position of Bottom Left VS Match

.org 0x80216D30
addiu v0, r0, ((SCREEN_W/2)+4) //Fix X Position of Top Right VS Match

.org 0x80218170
addiu a0, r0, ((SCREEN_W/2)-124) //Fix X Position of Default Bet Mode Text

.org 0x80218FB8
//Fix Rectangle for Bet Window
lui t0, hi(((SCREEN_W/2)-134) << 14)
addiu t0, t0, lo(((SCREEN_W/2)-134) << 14)

.org 0x802190C0
//Fix Rectangle for Bet Window
lui v0, (0xE400|(((SCREEN_W/2)+136) >> 2))

.org 0x802192B4
lui v0, (0xE400|(((SCREEN_W/2)+80) >> 2)) //Fix Right Edge of Play Mode Box

.org 0x802192DC
lui v0, (((SCREEN_W/2)-80) >> 2) //Fix Left Edge of Play Mode Box

.org 0x8021937C
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Play Mode Icon

.org 0x802193DC
addiu a0, r0, ((SCREEN_W/2)-124) //Fix X Position of Default Bet Mode Text

.org 0x80219C58
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Handicap Player Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Handicap Player Ortho

.org 0x8021A388
//Fix Rectangle for Handicap Window
lui a3, hi(((SCREEN_W/2)-134) << 14)

.org 0x8021A430
addiu a3, a3, lo(((SCREEN_W/2)-134) << 14)

.org 0x8021A460
//Fix Rectangle for Handicap Window
lui v0, (0xE400|(((SCREEN_W/2)+136) >> 2))

.org 0x8021B14C
addiu a0, r0, ((SCREEN_W/2)-124) //Fix X Position of P3 Handicap Text

.org 0x8021B164
addiu a0, r0, ((SCREEN_W/2)-124) //Fix X Position of Other Handicap Text

.org 0x8021BC30
slti v0, v0, (SCREEN_W+1) //Fix Maximum X Position of Brick Transitions

.org 0x8021BC38
addiu v0, r0, SCREEN_W //Fix Maximum X Position of Brick Transitions

.org 0x8021BC54
slti v0, v0, -SCREEN_W //Fix Minimum X Position of Brick Transitions

.org 0x8021BC5C
addiu v0, r0, -SCREEN_W //Fix Minimum X Position of Brick Transitions

.org 0x8021BC78
addiu v0, v0, SCREEN_W //Fix Brick Transition Width

.org 0x8021BD28
//Scale Texrect Texture Offset by DSDX/128
addiu v0, r0, (155520/SCREEN_W)
multu v0, v1
mflo v0
sra v0, v0, 7
//Reverse Direction of Texrect Texture Offset
subu v0, r0, v0
j 0x8021BD60 //Jump to New Code
sll a0, v0, 16 //Move Texrect Texture Offset to High Bits

.org 0x8021BE28
lui v0, (155520/SCREEN_W) //Fix DSDX for Brick Transition

.org 0x8021C430
addiu a2, s3, (SCREEN_W/2) //Fix X Position of Right Arrow

.org 0x8021C4A0
addiu v0, r0, ((SCREEN_W/2)-32) //Fix X Position of Left Arrow

.org 0x8021CDD8
addiu s0, r0, ((SCREEN_W/2)-8) //Fix X Position of Top Arrow

.org 0x8021CDF0
addiu s0, r0, ((SCREEN_W/2)-8) //Fix X Position of Bottom Arrow

.org 0x8021EAB0
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Best Shot Cursor Ortho
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Best Shot Cursor Ortho

.org 0x8021C0C8
addiu a2, r0, ((SCREEN_W/2)-84) //Fix X Position of Course Scroll Left Arrow

.org 0x8021C054
addiu a2, r0, ((SCREEN_W/2)+52) //Fix X Position of Course Scroll Right Arrow

.org 0x8021D42C
li t0, (0xE4000000|(((SCREEN_W/2)+142) << 14)|(166 << 2)) //Fix Rectangle for Best Shot Data

.org 0x8021D434
li a3, ((((SCREEN_W/2)-136) << 14)|(48 << 2)) //Fix Rectangle for Best Shot Data

.org 0x8021D660
//Fix Rectangle for Best Shot Window
lui t0, hi(0xE4000000|(((SCREEN_W/2)+138) << 14))
addiu t0, t0, lo(0xE4000000|(((SCREEN_W/2)+138) << 14))

.org 0x8021D790
//Fix Rectangle for Best Shot Window
lui v1, (((SCREEN_W/2)-132) >> 2)

.org 0x8021D8EC
addiu a3, a3, ((SCREEN_W/2)-26) //Fix X Position of Best Shot Faces

.org 0x8021D904
addiu a1, a1, ((SCREEN_W/2)-36) //Fix X Position of Best Shot Faces

.org 0x8021DCE8
lui v0, (0xE400|(((SCREEN_W/2)-64) >> 2)) //Fix Right Edge of Course Icon

.org 0x8021DD18
lui v1, (((SCREEN_W/2)-120) >> 2) //Fix Left Edge of Course Icon

.org 0x8021DE3C
addiu a1, r0, ((SCREEN_W/2)-128) //Fix X Position of Best Shots Column

.org 0x8021DF28
addiu a1, r0, ((SCREEN_W/2)-40) //Fix X Position of Best Shots Course Name

.org 0x8021DF6C
addiu a0, r0, ((SCREEN_W/2)+40) //Fix X Position of Best Shots Hole

.org 0x8021DFAC
addiu a0, r0, (SCREEN_W/2) //Fix X Position of No Replay Data Recorded

.org 0x8021FCE8
li t0, (0xE4000000|(((SCREEN_W/2)+142) << 14)|(202 << 2)) //Fix Rectangle for Ring Shot Data

.org 0x8021FCF0
li a3, ((((SCREEN_W/2)-136) << 14)|(70 << 2)) //Fix Rectangle for Ring Shot Data

.org 0x8021FF1C
//Fix Rectangle for Ring Shot Window
lui t0, hi(0xE4000000|(((SCREEN_W/2)+138) << 14))
addiu t0, t0, lo(0xE4000000|(((SCREEN_W/2)+138) << 14))

.org 0x80220044
//Fix Rectangle for Ring Shot Window
lui v1, (((SCREEN_W/2)-132) >> 2)

.org 0x80220190
addiu a2, r0, ((SCREEN_W/2)-138) //Fix X Position of Left Ring Shot Icon

.org 0x802201A8
addiu a2, r0, ((SCREEN_W/2)+108) //Fix X Position of Right Ring Shot Icon

.org 0x802201AC
addiu a2, s2, ((SCREEN_W/2)-142) //Fix X Position of Left Ring Shot Icon

.org 0x80220224
addiu v0, r0, ((SCREEN_W/2)-120) //Fix X Position of Ring Shot Course Cursor

.org 0x80220250
addiu v0, r0, ((SCREEN_W/2)+124) //Fix X Position of Ring Shot Replay Cursor

.org 0x8022027C
addiu v0, v0, ((SCREEN_W/2)-124) //Fix X Position of Ring Shot Cursor

.org 0x802202DC
addiu a1, a1, ((SCREEN_W/2)-112) //Fix X Position of Ring Shot Number Row

.org 0x802203DC
addiu a3, s1, ((SCREEN_W/2)-114) //Fix X Position of Ring Shot Icons

.org 0x802203F0
addiu a1, s1, ((SCREEN_W/2)-108) //Fix X Position of Ring Shot Cross

.org 0x80220488
addiu v0, v0, ((SCREEN_W/2)-124) //Fix X Position of Ring Shot Top Arrow

.org 0x802204E8
addiu v0, v0, ((SCREEN_W/2)-124) //Fix X Position of Ring Shot Bottom Arrow

.org 0x80220584
addiu a3, r0, ((SCREEN_W/2)-116) //Fix X Position of Ring Shot Face

.org 0x802205E0
addiu a2, r0, ((SCREEN_W/2)-84) //Fix X Position of Course Number Icon

.org 0x80220620
addiu a1, a1, ((SCREEN_W/2)-108) //Fix X Position of Course Number

.org 0x80220650
addiu a1, r0, ((SCREEN_W/2)-134) //Fix X Position of Course Number Film

.org 0x802206B4
addiu a0, r0, ((SCREEN_W/2)-124) //Fix X Position of Ring Shot Instruction

.org 0x8022090C
addiu a0, r0, ((SCREEN_W/2)-36) //Fix X Position of Ring Shot Name

.org 0x80220964
addiu a0, r0, ((SCREEN_W/2)-36) //Fix X Position of Ring Shot Name

.org 0x802231CC
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x802241C4
addiu t1, r0, ((SCREEN_W/2)-80) //Fix X Position of Tournament Window

.org 0x802241D4
addiu t1, r0, ((SCREEN_W/2)-80) //Fix X Position of Tournament Window

.org 0x802241D8
addiu t1, r0, ((SCREEN_W/2)-90) //Fix X Position of Tournament Window

.org 0x80224618
andi a1, a1, 0xA //Fix Bitmask for Tournament Sprite Position
addiu a1, a1, (SCREEN_W/2) //Fix Offset for Tournament Sprite Position

.org 0x80224734
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of No Saved Data Message

.org 0x80224800
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Course Name

.org 0x80224890
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Course Name

.org 0x802248B0
addiu a0, r0, ((SCREEN_W/2)+20) //Fix X Position of Hole Number

.org 0x802248F4
addiu a0, r0, ((SCREEN_W/2)-106) //Fix X Position of Restart Message

.org 0x802249DC
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Choose Controller Message

.org 0x802249F4
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Choose Controller Message

.org 0x802254B0
li.u a1, -(SCREEN_W_FLOAT/2) //Load Left Edge of Player Projection
li.u a2, (SCREEN_W_FLOAT/2) //Load Right Edge of Player Projection

.org 0x80226368
lui v1, (0xE400|(((SCREEN_W/2)-68) >> 2)) //Fix Right Edge of Course Icon

.org 0x80226388
lui v1, (((SCREEN_W/2)-120) >> 2) //Fix Left Edge of Course Icon

.org 0x8022660C
lui v1, (0xE400|(((SCREEN_W/2)-68) >> 2)) //Fix Right Edge of Course Icon Overlay

.org 0x8022662C
lui v1, (((SCREEN_W/2)-120) >> 2) //Fix Left Edge of Course Icon Overlay

.org 0x8022F940
.dw ((SCREEN_W/2)-50) //Fix X Position of Main Menu Header

.org 0x8022F948
.dw ((SCREEN_W/2)-120) //Fix X Position of Main Menu One Player

.org 0x8022F950
.dw ((SCREEN_W/2)-70) //Fix X Position of Main Menu Two Player

.org 0x8022F958
.dw ((SCREEN_W/2)-13) //Fix X Position of Main Menu Three Player

.org 0x8022F960
.dw ((SCREEN_W/2)+57) //Fix X Position of Main Menu Four Player

.org 0x8022F968
.dw ((SCREEN_W/2)-64) //Fix X Position of Main Menu Continue

.org 0x8022F970
.dw ((SCREEN_W/2)-64) //Fix X Position of Main Menu Clubhouse

.org 0x8022F97C
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Play Mode Screen

.org 0x8022F99C
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Play Mode Screen

.org 0x8022F9A4
.dw ((SCREEN_W/2)+88) //Fix X Position of P2 on Play Mode Screen

.org 0x8022F9BC
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Play Mode Screen

.org 0x8022F9C4
.dw ((SCREEN_W/2)-84) //Fix X Position of P2 on Play Mode Screen

.org 0x8022F9CC
.dw ((SCREEN_W/2)+51) //Fix X Position of P3 on Play Mode Screen

.org 0x8022F9DC
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Play Mode Screen

.org 0x8022F9E4
.dw ((SCREEN_W/2)-84) //Fix X Position of P2 on Play Mode Screen

.org 0x8022F9EC
.dw ((SCREEN_W/2)+51) //Fix X Position of P3 on Play Mode Screen

.org 0x8022F9F4
.dw ((SCREEN_W/2)+88) //Fix X Position of P4 on Play Mode Screen

.org 0x8022FC20
.dh (SCREEN_W-68) //Fix X Position of C-Up on Course Select

.org 0x8022FC24
.dh (SCREEN_W-90) //Fix X Position of C-Left on Course Select

.org 0x8022FC28
.dh (SCREEN_W-46) //Fix X Position of C-Right on Course Select

.org 0x8022FC2C
.dh (SCREEN_W-68) //Fix X Position of C-Down on Course Select

.org 0x8022FE14
.dw ((SCREEN_W/2)-64) //Fix X Position of Clubhouse Status

.org 0x8022FE1C
.dw ((SCREEN_W/2)-64) //Fix X Position of Clubhouse How To Play

.org 0x8022FE24
.dw ((SCREEN_W/2)-64) //Fix X Position of Clubhouse Options

.org 0x8022FE2C
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Tournament

.org 0x8022FE34
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Vs Records

.org 0x8022FE3C
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Speed Golf

.org 0x8022FE44
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Ring Shot

.org 0x8022FE4C
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Best Shots

.org 0x8022FE44
.dw ((SCREEN_W/2)-84) //Fix X Position of Status Tournament

.org 0x80230100
.dw ((SCREEN_W/2)+70) //Fix X Position of Tournament Trophy 1 in Tournament Data

.org 0x80230108
.dw ((SCREEN_W/2)+70) //Fix X Position of Tournament Trophy 2 in Tournament Data

.org 0x80230110
.dw ((SCREEN_W/2)+70) //Fix X Position of Tournament Trophy 3 in Tournament Data

.org 0x80230118
.dw ((SCREEN_W/2)+76) //Fix X Position of Tournament Trophy 4 in Tournament Data

.org 0x80230120
.dw ((SCREEN_W/2)+66) //Fix X Position of Tournament Trophy 5 in Tournament Data

.org 0x80230128
.dw ((SCREEN_W/2)+70) //Fix X Position of Tournament Trophy 6 in Tournament Data

.org 0x80230248
.dw ((SCREEN_W/2)-136) //Fix Left X Position of Line 1 in VS Data

.org 0x80230250
.dw ((SCREEN_W/2)+140) //Fix Right X Position of Line 1 in VS Data

.org 0x80230258
.dw ((SCREEN_W/2)-136) //Fix Left X Position of Line 2 in VS Data

.org 0x80230260
.dw ((SCREEN_W/2)+140) //Fix Right X Position of Line 2 in VS Data

.org 0x80230268
.dw ((SCREEN_W/2)-136) //Fix Left X Position of Line 3 in VS Data

.org 0x80230270
.dw ((SCREEN_W/2)+140) //Fix Right X Position of Line 3 in VS Data

.org 0x80230278
.dw ((SCREEN_W/2)-136) //Fix Left X Position of Line 4 in VS Data

.org 0x80230280
.dw ((SCREEN_W/2)+140) //Fix Right X Position of Line 4 in VS Data

.org 0x80230288
.dw ((SCREEN_W/2)-136) //Fix Left X Position of Line 5 in VS Data

.org 0x80230290
.dw ((SCREEN_W/2)+140) //Fix Right X Position of Line 5 in VS Data

.org 0x80230298
.dw ((SCREEN_W/2)-104) //Fix Left X Position of Line 6 in VS Data

.org 0x802302A0
.dw ((SCREEN_W/2)-103) //Fix Right X Position of Line 6 in VS Data

.org 0x802302A8
.dw ((SCREEN_W/2)-69) //Fix Left X Position of Line 7 in VS Data

.org 0x802302B0
.dw ((SCREEN_W/2)-68) //Fix Right X Position of Line 7 in VS Data

.org 0x802302B8
.dw ((SCREEN_W/2)-34) //Fix Left X Position of Line 8 in VS Data

.org 0x802302C0
.dw ((SCREEN_W/2)-33) //Fix Right X Position of Line 8 in VS Data

.org 0x802302C8
.dw ((SCREEN_W/2)+1) //Fix Left X Position of Line 9 in VS Data

.org 0x802302D0
.dw ((SCREEN_W/2)+2) //Fix Right X Position of Line 9 in VS Data

.org 0x802302D8
.dw ((SCREEN_W/2)+36) //Fix Left X Position of Line 10 in VS Data

.org 0x802302E0
.dw ((SCREEN_W/2)+37) //Fix Right X Position of Line 10 in VS Data

.org 0x802302E8
.dw ((SCREEN_W/2)+71) //Fix Left X Position of Line 11 in VS Data

.org 0x802302F0
.dw ((SCREEN_W/2)+72) //Fix Right X Position of Line 11 in VS Data

.org 0x802302F8
.dw ((SCREEN_W/2)+106) //Fix Left X Position of Line 12 in VS Data

.org 0x80230300
.dw ((SCREEN_W/2)+107) //Fix Right X Position of Line 12 in VS Data

.org 0x802304FC
.dw ((SCREEN_W/2)-92) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-52) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)-12) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+28) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+68) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+68) //Fix X Position of 6th Bet

.org 0x80230514
.dw ((SCREEN_W/2)-112) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-72) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)-32) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+8) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+48) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+88) //Fix X Position of 6th Bet

.org 0x8023052C
.dw ((SCREEN_W/2)-46) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-12) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)+24) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+56) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 6th Bet

.org 0x80230544
.dw ((SCREEN_W/2)-46) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-12) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)+24) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+56) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 6th Bet

.org 0x8023055C
.dw ((SCREEN_W/2)-46) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-12) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)+24) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)-16) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)-16) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)-16) //Fix X Position of 6th Bet

.org 0x80230574
.dw ((SCREEN_W/2)-46) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-12) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)+24) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+56) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+96) //Fix X Position of 6th Bet

.org 0x8023058C
.dw ((SCREEN_W/2)-73) //Fix X Position of 1st Bet
.dw ((SCREEN_W/2)-33) //Fix X Position of 2nd Bet
.dw ((SCREEN_W/2)+7) //Fix X Position of 3rd Bet
.dw ((SCREEN_W/2)+47) //Fix X Position of 4th Bet
.dw ((SCREEN_W/2)+68) //Fix X Position of 5th Bet
.dw ((SCREEN_W/2)+68) //Fix X Position of 6th Bet

.org 0x802306D8
.dw ((SCREEN_W/2)-32) //Fix X Position of P1 Handicap

.org 0x802306E8
.dw ((SCREEN_W/2)-64) //Fix X Position of P1 Handicap
.dw ((SCREEN_W/2)-0) //Fix X Position of P2 Handicap

.org 0x802306F8
.dw ((SCREEN_W/2)-96) //Fix X Position of P1 Handicap
.dw ((SCREEN_W/2)-32) //Fix X Position of P2 Handicap
.dw ((SCREEN_W/2)+32) //Fix X Position of P3 Handicap

.org 0x80230708
.dw ((SCREEN_W/2)-128) //Fix X Position of P1 Handicap
.dw ((SCREEN_W/2)-64) //Fix X Position of P2 Handicap
.dw ((SCREEN_W/2)+0) //Fix X Position of P3 Handicap
.dw ((SCREEN_W/2)+64) //Fix X Position of P4 Handicap

.org 0x802307A8
.dw SCREEN_W //Fix Start X Position of Brick Transition 1
.dw SCREEN_W //Fix Start X Position of Brick Transition 2
.dw SCREEN_W //Fix Start X Position of Brick Transition 3
.dw SCREEN_W //Fix Start X Position of Brick Transition 4
.dw SCREEN_W //Fix Start X Position of Brick Transition 5
.dw SCREEN_W //Fix Start X Position of Brick Transition 6
.dw SCREEN_W //Fix Start X Position of Brick Transition 7
.dw SCREEN_W //Fix Start X Position of Brick Transition 8
.dw SCREEN_W //Fix Start X Position of Brick Transition 9
.dw -SCREEN_W //Fix Start X Position of Brick Transition 1
.dw -SCREEN_W //Fix Start X Position of Brick Transition 2
.dw -SCREEN_W //Fix Start X Position of Brick Transition 3
.dw -SCREEN_W //Fix Start X Position of Brick Transition 4
.dw -SCREEN_W //Fix Start X Position of Brick Transition 5
.dw -SCREEN_W //Fix Start X Position of Brick Transition 6
.dw -SCREEN_W //Fix Start X Position of Brick Transition 7
.dw -SCREEN_W //Fix Start X Position of Brick Transition 8
.dw -SCREEN_W //Fix Start X Position of Brick Transition 9

.org 0x80230DE8
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Continue Screen

.org 0x80230E08
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Continue Screen

.org 0x80230E10
.dw ((SCREEN_W/2)+88) //Fix X Position of P2 on Continue Screen

.org 0x80230E28
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Continue Screen

.org 0x80230E30
.dw ((SCREEN_W/2)-84) //Fix X Position of P2 on Continue Screen

.org 0x80230E38
.dw ((SCREEN_W/2)+51) //Fix X Position of P3 on Continue Screen

.org 0x80230E48
.dw ((SCREEN_W/2)-118) //Fix X Position of P1 on Continue Screen

.org 0x80230E50
.dw ((SCREEN_W/2)-84) //Fix X Position of P2 on Continue Screen

.org 0x80230E58
.dw ((SCREEN_W/2)+51) //Fix X Position of P3 on Continue Screen

.org 0x80230E60
.dw ((SCREEN_W/2)+88) //Fix X Position of P4 on Continue Screen

.headersize 0x801F4A30-0x1370B0 //Intro Segment

.org 0x8020AD30
.dw (SCREEN_W-124) //Fix X Position of Baby Yoshi Text

.headersize 0x801F4A30-0x14EA70 //Title Screen Segment

.org 0x801F52AC
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Right Edge of Title Screen

.org 0x801F5310
lui a0, (311296/(SCREEN_W-16)) //Fix Title Screen Background Scale

.org 0x801F54FC
addiu a3, r0, (((SCREEN_W/2)+60)*4) //Fix X Position of Press Start Right Edge

.org 0x801F5548
addiu a1, r0, (((SCREEN_W/2)-60)*4) //Fix X Position of Press Start Left Edge

.headersize 0x801F4A30-0x14FB50 //Logo Segment

.org 0x801F4AD0
addiu v0, r0, (SCREEN_W-16) //Fix Scissor Width Reset

.org 0x801F5328
addiu a1, r0, (((SCREEN_W/2)-64)*4) //Fix X Position of N64 Logo

.org 0x801F5330
addiu a3, r0, (((SCREEN_W/2)+64)*4) //Fix X Position of N64 Logo Right Edge

.org 0x801F5464
addiu a1, r0, (((SCREEN_W/2)-94)*4) //Fix X Position of Nintendo Logo

.org 0x801F546C
addiu a3, r0, (((SCREEN_W/2)+94)*4) //Fix X Position of Nintendo Logo Right Edge

.org 0x801F5648
addiu a1, r0, (((SCREEN_W/2)-96)*4) //Fix X Position of Camelot Logo

.org 0x801F5650
addiu a3, r0, (((SCREEN_W/2)+96)*4) //Fix X Position of Camelot Logo Right Edge

.headersize 0x80241800-0x150990 //Score Card Menu Segment

.org 0x80243128
addiu at, r0, ((SCREEN_W/2)-160) //Load Constant for Score Card Menu Minimum X Position
slti v0, v0, ((SCREEN_W/2)-158) //Fix Stopping Point for Score Card Menu

.org 0x80243134
sw at, 0(a0) //Fix End Point for SCore Card Menu

.org 0x8024313C
subu v1, v1, at //Center Inwards Calculation
sra v1, v1, 1 //Move Score Card Menu Inwards
addu v1, v1, at //Uncenter Inwards Calculation
nop //Add Padding Instruction

.org 0x802431B8
slti v0, a1, -(SCREEN_W-1) //Fix Exit X Position of Score Card Menu

.org 0x802431F8
addiu v0, r0, ((SCREEN_W*10)/320) //Fix Max Time for Score Card Slide Out

.org 0x8024857C
//Jump to code to Fix Leaderboard
j LeaderBoard3DFix
nop

.org 0x8024C5F0
LeaderBoard3DFix:
lw v1, 0(s2) //Load Offset of Score Board
addiu v1, v1, -((SCREEN_W/2)-160) //Fix Offset of Score Board 3D effect
mtc1 v1, f0 //Load Offset of Score Board 3D Effects
nop //Padding Instruction
j 0x80248584 //Load Padding Instruction
cvt.s.w f0, f0 //Convert Offset of Score Board 3D Effects

.headersize 0x80241800-0x15BB50 //Club Shot Overlay Segment

.org 0x802428D0
addiu a1, r0, 0 //Fix Club Shot Black Box X Position

.org 0x802428D8
addiu a2, r0, 0 //Fix Club Shot Black Box Y Position
addiu a3, r0, (SCREEN_W*4) //Fix Club Shot Black Box Width

.org 0x802429F4
addiu v0, r0, (SCREEN_H*4) //Fix Club Shot Black Box Heght

.org 0x80242D50
addiu a1, r0, (((SCREEN_W/2)-64)*4) //Fix X Position of Club Shot Cover

.org 0x80242D58
addiu a3, r0, (((SCREEN_W/2)+64)*4) //Fix X Position of Club Shot Cover

.org 0x802430F0
addiu a1, r0, (((SCREEN_W/2)-152)*4) //Fix X Position of Left Edge of Club Shot Background

.org 0x802430FC
addiu a3, r0, (((SCREEN_W/2)+151)*4) //Fix X Position of Right Edge of Club Shot Background

.org 0x8024317C
addiu s6, r0, ((SCREEN_W/2)-37) //Fix X Position of Club Shot Cover Right Edge

.org 0x80243228
addiu a1, t8, ((SCREEN_W/2)-96) //Fix X Position of Club Shot Cover Left Edge

.org 0x802434D8
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Club Shot Start Text

.org 0x80243A40
addiu a1, r0, (((SCREEN_W/2)+96)*4) //Fix X Position of Club Shot Active Player Icon

.org 0x80243A4C
addiu a3, r0, (((SCREEN_W/2)+128)*4) //Fix X Position of Club Shot Active Player Icon

.org 0x80243D20
addiu a1, r0, (((SCREEN_W/2)+104)*4) //Fix X Position of Club Shot Inactive Player Icon

.org 0x80243D40
addiu a3, r0, (((SCREEN_W/2)+136)*4) //Fix X Position of Club Shot Inactive Player Icon

.org 0x80243DAC
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Club Shot Text

.headersize 0x80241800-0x15F250 //Ring Shot Menu Segment

.org 0x802426A4
slti v0, s1, ((SCREEN_W/2)+1) //Fix Stop X Position of Club Shot Doors

.org 0x802426AC
addiu s1, r0, (SCREEN_W/2) //Fix Maximum X Position of Club Shot Doors

.org 0x80242764
addiu a1, r0, SCREEN_W //Fix X Offset of Club Shot Right Door

.org 0x80242774
addiu a3, r0, ((SCREEN_W-8)*4) //Fix X Position of Right Edge of Club Shot Mario Face

.org 0x80242844
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Ring Shot Name Window

.org 0x80242940
addiu a1, r0, (((SCREEN_W/2)-32)*4) //Fix X Position of Left Edge of Course Icon
addiu a3, r0, (((SCREEN_W/2)+32)*4) //Fix X Position of Right Edge of Course Icon

.org 0x80242B9C
addiu a1, r0, (((SCREEN_W/2)-8)*4) //Fix X Position of Left Edge of Up Arrow
addiu a3, r0, (((SCREEN_W/2)+8)*4) //Fix X Position of Right Edge of Up Arrow

.org 0x80242C28
addiu a1, r0, (((SCREEN_W/2)-8)*4) //Fix X Position of Left Edge of Down Arrow
addiu a3, r0, (((SCREEN_W/2)+8)*4) //Fix X Position of Right Edge of Down Arrow

.org 0x80242C74
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Ring Shot Bottom Stars

.org 0x80242CB4
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Ring Shot Name

.org 0x80242ECC
addiu a1, r0, (((SCREEN_W/2)-88)*4) //Fix X Position of Left Edge of Training Course Window
addiu a3, r0, (((SCREEN_W/2)+88)*4) //Fix X Position of Right Edge of Training Course Window

.org 0x80243050
addiu a1, r0, (((SCREEN_W/2)-32)*4) //Fix X Position of Left Edge of Training Course Icon
addiu a3, r0, (((SCREEN_W/2)+32)*4) //Fix X Position of Right Edge of Training Course Icon

.org 0x80243298
addiu a1, r0, (((SCREEN_W/2)-8)*4) //Fix X Position of Left Edge of Up Arrow
addiu a3, r0, (((SCREEN_W/2)+8)*4) //Fix X Position of Right Edge of Up Arrow

.org 0x8024332C
addiu a1, r0, (((SCREEN_W/2)-8)*4) //Fix X Position of Left Edge of Down Arrow
addiu a3, r0, (((SCREEN_W/2)+8)*4) //Fix X Position of Right Edge of Down Arrow

.org 0x80243388
addiu a1, r0, (((SCREEN_W/2)-56)*4) //Fix X Position of Left Scroll Arrow

.org 0x8024338C
addiu a1, r0, (((SCREEN_W/2)-60)*4) //Fix X Position of Left Active Scroll Arrow

.org 0x80243398
addiu a3, r0, (((SCREEN_W/2)-40)*4) //Fix X Position of Left Scroll Arrow

.org 0x802433AC
addiu a3, r0, (((SCREEN_W/2)-44)*4) //Fix X Position of Left Active Scroll Arrow

.org 0x80243404
andi a1, a3, 0x10 //Fix Offset of Right Active Scroll Arrow
addiu a1, a1, (((SCREEN_W/2)+40)*4) //Apply Offset of Right Active Scroll Arrow

.org 0x80243414
andi a3, a3, 0x10 //Fix Offset of Right Active Scroll Arrow
addiu a3, a3, (((SCREEN_W/2)+56)*4) //Apply Offset of Right Active Scroll Arrow

.org 0x80243508
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Course Name

.org 0x80243570
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Course Hole

.org 0x80243BB0
addiu t2, v0, ((SCREEN_W/2)-114) //Fix X Position of Ring Shot Stars

.headersize 0x80241800-0x1619A0 //Control Menu Segment

.org 0x80241DE8
addiu v0, r0, SCREEN_W //Fix Initial X Position of Save Menu

.org 0x8024258C
addiu a1, a3, ((SCREEN_W/2)-136) //Fix X Position of Left Edge of Save Menu Choices

.org 0x80242594
addiu a3, a3, ((SCREEN_W/2)+136) //Fix X Position of Right Edge of Save Menu Choices

.org 0x8024265C
addiu a1, a3, ((SCREEN_W/2)-80) //Fix X Position of Left Edge of Save Menu End Game

.org 0x80242664
addiu a3, a3, ((SCREEN_W/2)+80) //Fix X Position of Right Edge of Save Menu End Game

.org 0x80242850
addiu t7, s2, ((SCREEN_W/2)+70) //Fix X Position of Save Menu Text

.org 0x8024285C
addiu t6, s2, ((SCREEN_W/2)-90) //Fix X Position of Save Menu Text

.org 0x80242B6C
addiu a1, a3, ((SCREEN_W/2)-134) //Fix X Position of Trophy Left Edge

.org 0x80242B74
addiu a3, a3, ((SCREEN_W/2)-102) //Fix X Position of Trophy Left Edge

.org 0x80242D64
addiu a1, a3, ((SCREEN_W/2)+80) //Fix X Position of Save Menu Face

.org 0x80242D84
addiu a3, a3, ((SCREEN_W/2)+112) //Fix X Position of Save Menu Face Right Edge

.org 0x80242F98
addiu v0, v0, (SCREEN_W/2) //Fix X Position of Save Menu Top Line

.org 0x80243010
addiu t0, t0, (SCREEN_W/2) //Fix X Position of Save Menu Bottom Line

.org 0x80243094
addiu a3, a3, (SCREEN_W/2) //Fix X Position of Save Menu Left Line

.org 0x80243114
addiu a1, a1, (SCREEN_W/2) //Fix X Position of Save Menu Right Line

.org 0x8024328C
addiu a1, a1, ((SCREEN_W/2)-98) //Fix X Position of Save Menu Game Mode

.org 0x8024342C
addiu a1, a1, ((SCREEN_W/2)-98) //Fix X Position of Save Menu Game Name

.org 0x8024348C
addiu a1, a1, ((SCREEN_W/2)+80) //Fix X Position of Save Menu Hole Number

.org 0x80243514
addiu a1, a1, (SCREEN_W/2) //Fix X Position of Save Menu No Saved Data Text

.org 0x802435BC
addiu a1, a1, ((SCREEN_W/2)-44) //Fix X Position of Save Menu End Game Text

.org 0x80243D9C
addiu v0, v1, -6 //Fix Speed of Save Menu Slide Out

.org 0x80244438
addiu a1, a3, ((SCREEN_W/2)-136) //Fix X Position of Left Edge of Replay Choices

.org 0x80244440
addiu a3, a3, ((SCREEN_W/2)+136) //Fix X Position of Right Edge of Replay Choices

.org 0x80244524
addiu a1, a3, ((SCREEN_W/2)-80) //Fix X Position of Left Edge of Replay Hole Out Choice

.org 0x8024452C
addiu a3, a3, ((SCREEN_W/2)+80) //Fix X Position of Right Edge of Replay Hole Out Choice

.org 0x8024471C
addiu a1, a3, ((SCREEN_W/2)-96) //Fix X Position of Left Edge of Replay Course Icon

.org 0x80244724
addiu a3, a3, ((SCREEN_W/2)-56) //Fix X Position of Right Edge of Replay Course Icon

.org 0x80244754
addiu a1, a3, ((SCREEN_W/2)-56) //Fix X Position of Left Edge of Replay Course Icon

.org 0x8024475C
addiu a3, a3, ((SCREEN_W/2)-40) //Fix X Position of Right Edge of Replay Course Icon

.org 0x80244934
addiu v0, s2, ((SCREEN_W/2)-32) //Fix X Position of Left Edge of Replay Hole In One

.org 0x80244944
addiu a1, a3, ((SCREEN_W/2)-32) //Fix X Position of Right Edge of Replay Hole In One

.org 0x80244AF0
addiu a1, a3, ((SCREEN_W/2)-128) //Fix X Position of Left Edge of Replay Player Icon

.org 0x80244AF8
addiu a3, a3, ((SCREEN_W/2)-96) //Fix X Position of Right Edge of Replay Player Icon

.org 0x80244C60
addiu a1, v0, -(SCREEN_W/2) //Fix X Position of Left Edge of Replay Box Top Line

.org 0x80244C6C
addiu v0, v0, (SCREEN_W/2) //Fix X Position of Right Edge of Replay Box Top Line

.org 0x80244CC0
addiu a1, t0, -(SCREEN_W/2) //Fix X Position of Left Edge of Replay Box Bottom Line

.org 0x80244CDC
addiu t0, t0, (SCREEN_W/2) //Fix X Position of Right Edge of Replay Box Bottom Line

.org 0x80244D40
addiu t0, t0, -(SCREEN_W/2) //Fix X Position of Replay Box Left Line

.org 0x80244DB4
addiu t0, t0, (SCREEN_W/2) //Fix X Position of Replay Box Right Line

.org 0x80244F70
addiu a1, a3, ((SCREEN_W/2)-64) //Fix X Position of Left Edge of Save Menu Box

.org 0x80244F78
addiu a3, a3, ((SCREEN_W/2)+64) //Fix X Position of Right Edge of Save Menu Box

.org 0x802450B0
addiu a1, a1, (SCREEN_W/2) //Fix X Position of No Replay Data Text

.org 0x80245118
addiu a0, a0, ((SCREEN_W/2)-96) //Fix X Position of Replay Goal Text

.org 0x8024518C
addiu a1, a1, ((SCREEN_W/2)-32) //Fix X Position of Replay Hole Out Text

.org 0x802451D8
addiu a1, a1, ((SCREEN_W/2)-40) //Fix X Position of Replay Save Menu Text

.org 0x80245510
addiu a1, r0, (((SCREEN_W/2)-144)*4) //Fix Centering of Controls Menu Left Edge

.org 0x8024551C
addiu a3, r0, (((SCREEN_W/2)+144)*4) //Fix Centering of Controls Menu Right Edge

.headersize 0x801F4A30-0x16D650 //Credits Menu Segment

.org 0x801F6FA0
//Fix Viewport Size Speed in Ending
li.u at, (SCREEN_W_FLOAT/64)
li.l at, (SCREEN_W_FLOAT/64)

.org 0x801F6FDC
//Fix Viewport Size Speed in Ending
li.u at, (SCREEN_W_FLOAT/60)
li.l at, (SCREEN_W_FLOAT/60)

.org 0x801F6FF4
//Fix Viewport Size in Ending
li.u at, (SCREEN_W_FLOAT-17)
li.l at, (SCREEN_W_FLOAT-17)

.org 0x801F7574
li a0, (((SCREEN_W-8) << 14)|((SCREEN_H-8) << 2)) //Fix Credits Scissor

.org 0x801F77F8
li a3, (0xE4000000|((SCREEN_W-8) << 14)|(160 << 2)) //Fix Credits Fading

.org 0x801F7F38
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Rectangle for Credits Final Background

.org 0x801F7F9C
lui v1, (311296/(SCREEN_W-16)) //DSDX for Credits Final Background

.org 0x801F8894
lui v0, (0xE400|((SCREEN_W-8) >> 2)) //Fix Rectangle for Credits Initial Background

.org 0x801F88FC
lui v1, (311296/(SCREEN_W-16)) //DSDX for Credits Initial Background


.close