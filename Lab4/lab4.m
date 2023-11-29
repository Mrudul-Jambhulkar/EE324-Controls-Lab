 freq = [40 , 50 , 60 , 90 , 100 , 120 , 140 , 200 , 600 , 700 , 900 , 1000 , 2000 , 2500 , 3000 , 3500 , 4000 , 4500 ,  5000 , 5500 , 6000 ,  6500 ];
vin = [4.32, 4.32, 4.4, 4.56, 4.4, 4.4, 4.72, 4.74,4.88, 4.72, 4.72, 4.72, 4.64, 4.56, 5.12, 4.96, 4.72, 4.96, 4.88, 5.11, 4.96, 5.12 ];
vout = [.56, .8, .96, 1.5, 1.64, 1.92, 2.48, 3.04, 4.8, 4.4, 5.52, 5.92, 12.6, 12.4, 11.6, 12, 12.2, 9.6, 6.8, 4.2, 6, 5.6];
ph = -[158-360, 179-360, -178, -154, -144, -125, -110, -89.2, -9.85, -9.59, -9.15, -9.38, 46.6, 95.8, 128, 154, -167+360, -132+360, -107+360, -95+360, -100+360, -68+360];
gain = 20* log10 ( abs ( vout ./ vin ) ) + 28.58;

figure (1) ;
subplot (2 ,1 ,1) ;
semilogx ( freq , gain ) ; ylabel ( ' Magnitude ( dB ) ') ; grid on ;
 subplot (2 ,1 ,2) ;
 semilogx ( freq , ph ) ; ylabel ( ' Phase (\ circ ) ') ; xlabel ( ' Freq ( Hz ) ') ; yticks (( -1260:180:0) ) ; grid on ;
 sgtitle ( 'Bode Diagram') ;

 z = -[6500 , 6000];
 p = -[100 , 90];
 k = 2.307/(10000) ;
 h = zpk (z ,p , k )
 figure (2) ;
 b = bodeoptions ;
 b . FreqUnits = 'Hz';
 bodeplot (h , b ) , grid ;

 s = 1i * freq ;
 num = s /6500; num1 = s /6000;
 den = s /100; den1 = s /90;
 g = 2.307*( num +1) .*( num1 +1) ./(( den +1) .*( den1 +1) ) ;
mag = 20* log10 ( abs ( g ) ) + gain ;
 a = angle ( g ) ;
 phase = rad2deg ( a ) + ph ;

figure (3) ;
 subplot (2 ,1 ,1) ;
semilogx ( freq , mag , 'r' , freq , gain , 'b') ; ylabel ( 'Magnitude ( dB ) ') ; grid on ; yticks ( -40:10:40 ) ;
 legend ( ' Compensated ' , ' Uncompensated ' , ' Location ' , ' southwest') ;
 subplot (2 ,1 ,2) ;
 semilogx ( freq , phase , 'r' , freq , ph , 'b') ; ylabel ( ' Phase') ; yticks(-360:90:360) ; grid on ;
legend ( ' Compensated ' , ' Uncompensated ' , ' Location ' , ' southwest ') ; xlabel ( ' Freq ( Hz ) ') ; sgtitle ( 'Bode Plot ') ;
 

C = 1e-9;   %1pF
R = 1/(sqrt(-p(1)*-p(2))*C)
Q = 1/(R*C*(-p(1)-p(2)))
R2 = 1/(k*-z(1)*-z(2)*C*C*R)
C1 = C*sqrt(k)

% x = 1/R1 - r/(R*R3)
x = C*k*(-z(1)-z(2))
R1 = 1e4;       % 10kOhm

% y = r/R3
y = 1/R1 - x
R3 = 1e7;       % 10MOhm
r = y*R3