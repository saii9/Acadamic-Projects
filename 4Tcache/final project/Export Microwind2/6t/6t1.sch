DSCH 2.7f
VERSION 2/27/2013 10:39:45 AM
BB(25,-5,180,75)
SYM  #clock3
BB(25,32,40,38)
TITLE 30 35  #clock
MODEL 69
PROP   0.157 0.157                                                                                                                               
REC(27,33,6,4,r)
VIS 1
PIN(40,35,1.500,0.140)clk3
LIG(35,35,40,35)
LIG(30,33,28,33)
LIG(34,33,32,33)
LIG(35,32,35,38)
LIG(25,38,25,32)
LIG(30,37,30,33)
LIG(32,33,32,37)
LIG(32,37,30,37)
LIG(28,37,26,37)
LIG(28,33,28,37)
LIG(35,38,25,38)
LIG(35,32,25,32)
FSYM
SYM  #vdd
BB(90,-5,100,5)
TITLE 93 1  #vdd
MODEL 1
PROP                                                                                                                                   
REC(0,0,0,0, )
VIS 0
PIN(95,5,0.000,0.000)vdd
LIG(95,5,95,0)
LIG(95,0,90,0)
LIG(90,0,95,-5)
LIG(95,-5,100,0)
LIG(100,0,95,0)
FSYM
SYM  #pmos
BB(100,5,120,25)
TITLE 115 10  #pmos
MODEL 902
PROP   2.0u 0.12u MP                                                                                                                              
REC(101,10,19,15,r)
VIS 2
PIN(120,5,0.000,0.000)s
PIN(100,15,0.000,0.000)g
PIN(120,25,0.030,0.280)d
LIG(100,15,106,15)
LIG(108,15,108,15)
LIG(110,21,110,9)
LIG(112,21,112,9)
LIG(120,9,112,9)
LIG(120,5,120,9)
LIG(120,21,112,21)
LIG(120,25,120,21)
VLG  pmos pmos(drain,source,gate);
FSYM
SYM  #nmos
BB(100,40,120,60)
TITLE 115 45  #nmos
MODEL 901
PROP   1.0u 0.12u MN                                                                                                                              
REC(101,45,19,15,r)
VIS 2
PIN(120,60,0.000,0.000)s
PIN(100,50,0.000,0.000)g
PIN(120,40,0.030,0.280)d
LIG(110,50,100,50)
LIG(110,56,110,44)
LIG(112,56,112,44)
LIG(120,44,112,44)
LIG(120,40,120,44)
LIG(120,56,112,56)
LIG(120,60,120,56)
VLG  nmos nmos(drain,source,gate);
FSYM
SYM  #nmos
BB(75,40,95,60)
TITLE 80 45  #nmos
MODEL 901
PROP   1.0u 0.12u MN                                                                                                                              
REC(75,45,19,15,r)
VIS 2
PIN(75,60,0.000,0.000)s
PIN(95,50,0.000,0.000)g
PIN(75,40,0.030,0.280)d
LIG(85,50,95,50)
LIG(85,56,85,44)
LIG(83,56,83,44)
LIG(75,44,83,44)
LIG(75,40,75,44)
LIG(75,56,83,56)
LIG(75,60,75,56)
VLG  nmos nmos(drain,source,gate);
FSYM
SYM  #pmos
BB(75,5,95,25)
TITLE 80 10  #pmos
MODEL 902
PROP   2.0u 0.12u MP                                                                                                                              
REC(75,10,19,15,r)
VIS 2
PIN(75,5,0.000,0.000)s
PIN(95,15,0.000,0.000)g
PIN(75,25,0.030,0.280)d
LIG(95,15,89,15)
LIG(87,15,87,15)
LIG(85,21,85,9)
LIG(83,21,83,9)
LIG(75,9,83,9)
LIG(75,5,75,9)
LIG(75,21,83,21)
LIG(75,25,75,21)
VLG  pmos pmos(drain,source,gate);
FSYM
SYM  #nmos
BB(40,15,60,35)
TITLE 55 30  #nmos
MODEL 901
PROP   1.0u 0.12u MN                                                                                                                              
REC(40,16,15,19,r)
VIS 2
PIN(40,35,0.000,0.000)s
PIN(50,15,0.000,0.000)g
PIN(60,35,0.030,0.280)d
LIG(50,25,50,15)
LIG(44,25,56,25)
LIG(44,27,56,27)
LIG(56,35,56,27)
LIG(60,35,56,35)
LIG(44,35,44,27)
LIG(40,35,44,35)
VLG  nmos nmos(drain,source,gate);
FSYM
SYM  #nmos
BB(140,15,160,35)
TITLE 155 30  #nmos
MODEL 901
PROP   1.0u 0.12u MN                                                                                                                              
REC(140,16,15,19,r)
VIS 2
PIN(140,35,0.000,0.000)s
PIN(150,15,0.000,0.000)g
PIN(160,35,0.030,0.070)d
LIG(150,25,150,15)
LIG(144,25,156,25)
LIG(144,27,156,27)
LIG(156,35,156,27)
LIG(160,35,156,35)
LIG(144,35,144,27)
LIG(140,35,144,35)
VLG  nmos nmos(drain,source,gate);
FSYM
SYM  #vss
BB(95,62,105,70)
TITLE 99 67  #vss
MODEL 0
PROP                                                                                                                                    
REC(95,60,0,0,b)
VIS 0
PIN(100,60,0.000,0.000)vss
LIG(100,60,100,65)
LIG(95,65,105,65)
LIG(95,68,97,65)
LIG(97,68,99,65)
LIG(99,68,101,65)
LIG(101,68,103,65)
FSYM
SYM  #clock4
BB(35,-3,50,3)
TITLE 40 0  #clock
MODEL 69
PROP   0.625 0.625                                                                                                                               
REC(37,-2,6,4,r)
VIS 1
PIN(50,0,1.500,0.140)clk4
LIG(45,0,50,0)
LIG(40,-2,38,-2)
LIG(44,-2,42,-2)
LIG(45,-3,45,3)
LIG(35,3,35,-3)
LIG(40,2,40,-2)
LIG(42,-2,42,2)
LIG(42,2,40,2)
LIG(38,2,36,2)
LIG(38,-2,38,2)
LIG(45,3,35,3)
LIG(45,-3,35,-3)
FSYM
SYM  #inv
BB(145,55,180,75)
TITLE 160 65  #~
MODEL 101
PROP                                                                                                                                   
REC(0,0,0,0, )
VIS 0
PIN(145,65,0.000,0.000)in
PIN(180,65,0.030,0.070)out
LIG(145,65,155,65)
LIG(155,55,155,75)
LIG(155,55,170,65)
LIG(155,75,170,65)
LIG(172,65,172,65)
LIG(174,65,180,65)
VLG  not not1(out,in);
FSYM
CNC(75 35)
CNC(100 35)
CNC(75 35)
CNC(120 30)
CNC(95 30)
CNC(120 30)
LIG(100,15,100,35)
LIG(150,-5,150,15)
LIG(120,40,120,30)
LIG(50,-5,150,-5)
LIG(75,40,75,35)
LIG(95,50,95,30)
LIG(60,35,75,35)
LIG(75,35,75,25)
LIG(75,35,100,35)
LIG(100,35,100,50)
LIG(95,30,120,30)
LIG(120,30,120,25)
LIG(95,30,95,15)
LIG(120,30,140,30)
LIG(140,30,140,35)
LIG(75,60,120,60)
LIG(75,5,120,5)
LIG(50,15,50,-5)
LIG(40,35,40,65)
LIG(40,65,145,65)
LIG(180,65,180,35)
LIG(180,35,160,35)
FFIG C:\Users\SUNNY\simulations\work\6t1.sch
