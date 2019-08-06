
                      
%              Chaotic GSA for Engineering Design Problems
% 
%                  E-Mail: sajad.win8@gmail.com                   
%                                                                         
%              Homepage: https://github.com/SajadAHMAD1.                            
%                                                                         
%   Main paper: R.A., Rather, P.S., Bala,     
%               Department of Computer Science and Engineering
%               School of Engineering and Technology
%               Pondicherry University- 605014, India
%               
%            Application of Chaotic Gravitational Search Algorithm for Solving Mechanical and Civil Engineering Design Problems (July-2019)
%                                    King Saud Journal of Engineering Sciences (Elsevier)
%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 


% This function calculates the value of objective function.
function PHI=benchmark_functions(x,Benchmark_Function_ID,dim)

%You can insert your own objective function with a new Benchmark_Function_ID.
% dim=30;
if Benchmark_Function_ID==1
PHI=sum(x.^2);
end

if Benchmark_Function_ID==2
PHI=sum(abs(x))+prod(abs(x));
end

if Benchmark_Function_ID==3
    PHI=0;
    for i=1:dim
    PHI=PHI+sum(x(1:i))^2;
    end
end

if Benchmark_Function_ID==4
    PHI=max(abs(x));
end

if Benchmark_Function_ID==5
    PHI=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end

if Benchmark_Function_ID==6
    PHI=sum(abs((x+.5)).^2);
end

if Benchmark_Function_ID==7
    PHI=sum([1:dim].*(x.^4))+rand;
end

if Benchmark_Function_ID==8
    PHI=sum(-x.*sin(sqrt(abs(x))));
end

if Benchmark_Function_ID==9
    PHI=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

if Benchmark_Function_ID==10
    PHI=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end

if Benchmark_Function_ID==11
    PHI=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

if Benchmark_Function_ID==12
    PHI=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
        (1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
end
if Benchmark_Function_ID==13
    PHI=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
        ((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
end

if Benchmark_Function_ID==14
aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
-32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
    for j=1:25
        bS(j)=sum((x'-aS(:,j)).^6);
    end
    PHI=(1/500+sum(1./([1:25]+bS))).^(-1);
end

if Benchmark_Function_ID==15
    aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
    bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
    PHI=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

if Benchmark_Function_ID==16
    PHI=4*(x(1)^2)-2.1*(x(1)^4)+(x(1)^6)/3+x(1)*x(2)-4*(x(2)^2)+4*(x(2)^4);
end

if Benchmark_Function_ID==17
    PHI=(x(2)-(x(1)^2)*5.1/(4*(pi^2))+5/pi*x(1)-6)^2+10*(1-1/(8*pi))*cos(x(1))+10;
end

if Benchmark_Function_ID==18
    PHI=(1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
        (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

if Benchmark_Function_ID==19
    aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
    pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
    PHI=0;
    for i=1:4
    PHI=PHI-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
    end
end

if Benchmark_Function_ID==20
    aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
    PHI=0;
    for i=1:4
    PHI=PHI-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
    end
end

aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

if Benchmark_Function_ID==21
    PHI=0;
  for i=1:5
    PHI=PHI-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
  end
end

if Benchmark_Function_ID==22
    PHI=0;
  for i=1:7
    PHI=PHI-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
  end
end

if Benchmark_Function_ID==23
    PHI=0;
  for i=1:10
    PHI=PHI-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
  end
end
if Benchmark_Function_ID==24 %welded design
%     fit=PrWf(L);
%% WELDED BEAM DESIGN PROBLEM DEFINITION (all units are in british system) 
P = 6000; % APPLIED TIP LOAD
E = 30e6; % YOUNGS MODULUS OF BEAM
G = 12e6; % SHEAR MODULUS OF BEAM
tem = 14; % LENGTH OF CANTILEVER PART OF BEAM
PCONST = 100000; % PENALTY FUNCTION CONSTANT
TAUMAX = 13600; % MAXIMUM ALLOWED SHEAR STRESS
SIGMAX = 30000; % MAXIMUM ALLOWED BENDING STRESS
DELTMAX = 0.25; % MAXIMUM ALLOWED TIP DEFLECTION
M =  P*(tem+x(2)/2); % BENDING MOMENT AT WELD POINT
R = sqrt((x(2)^2)/4+((x(1)+x(3))/2)^2); % SOME CONSTANT
J =  2*(sqrt(2)*x(1)*x(2)*((x(2)^2)/4+((x(1)+x(3))/2)^2)); % POLAR MOMENT OF INERTIA
PHI =  1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14+x(2)); % OBJECTIVE FUNCTION
SIGMA = (6*P*tem)/(x(4)*x(3)^2); % BENDING STRESS
DELTA = (4*P*tem^3)/(E*x(3)^3*x(4)); % TIP DEFLECTION
PC = 4.013*E*sqrt((x(3)^2*x(4)^6)/36)*(1-x(3)*sqrt(E/(4*G))/(2*tem))/(tem^2); % BUCKLING LOAD
TAUP =  P/(sqrt(2)*x(1)*x(2)); % 1ST DERIVATIVE OF SHEAR STRESS
TAUPP = (M*R)/J; % 2ND DERIVATIVE OF SHEAR STRESS
TAU = sqrt(TAUP^2+2*TAUP*TAUPP*x(2)/(2*R)+TAUPP^2); % SHEAR STRESS
G1 = TAU-TAUMAX; % MAX SHEAR STRESS CONSTRAINT
G2 =  SIGMA-SIGMAX; % MAX BENDING STRESS CONSTRAINT
%G3 = L(1)-L(4); % WELD COVERAGE CONSTRAINT
G3=DELTA-DELTMAX;
G4=x(1)-x(4);
G5=P-PC;
G6=0.125-x(1); 
%G4 = 0.10471*L(1)^2+0.04811*L(3)*L(4)*(14+L(2))-5; % MAX COST CONSTRAINT
%G5 =  0.125-L(1); % MAX WELD THICKNESS CONSTRAINT
%G6 =  DELTA-DELTMAX; % MAX TIP DEFLECTION CONSTRAINT
%G7 =  P-PC; % BUCKLING LOAD CONSTRAINT
G7=1.10471*x(1)^2+0.04811*x(3)*x(4)*(14+x(2))-5;
PHI = PHI + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+...
    max(0,G6)^2+max(0,G7)^2); % PENALTY FUNCTION
end

if Benchmark_Function_ID==25 %Spring design
    
%% TENSION/COMPRESSION SPRING DESIGN PROBLEM DEFINITION (all units are in british system) 

PCONST = 100; % PENALTY FUNCTION CONSTANT

fit=(x(3)+2)*x(2)*(x(1)^2);
G1=1-(x(2)^3*x(3))/(71785*x(1)^4);
G2=(4*x(2)^2-x(1)*x(2))/(12566*(x(2)*x(1)^3-x(1)^4))+1/(5108*x(1)^2);
G3=1-(140.45*x(1))/(x(2)^2*x(3));
G4=((x(1)+x(2))/1.5)-1;

PHI = fit + PCONST*(max(0,G1)^2++max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end

if Benchmark_Function_ID==26 %Pressure vessel design
%% Pressure Vessel design

PCONST=10000;  % PENALTY FUNCTION CONSTANT
fit= 0.6224*x(1)*x(3)*x(4)+ 1.7781*x(2)*x(3)^2 + 3.1661 *x(1)^2*x(4) + 19.84 * x(1)^2*x(3);
G1= -x(1)+ 0.0193*x(3);
G2=  -x(3) + 0.00954* x(3);
G3=  -pi*x(3)^2*x(4)-(4/3)* pi*x(3)^3 +1296000;
G4= x(4) - 240;
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end
if Benchmark_Function_ID==27 %Speed Reducer design
%% Speed Reducer design
PCONST=10000;  % PENALTY FUNCTION CONSTANT
fit=0.7854*x(1)*x(2)^2*(3.3333*x(3)^2-14.9334*x(3)-43.0934)-1.508*x(1)*(x(6)^2+x(7)^2)+7.4777*(x(6)^3+x(7)^3)+0.7854*(x(4)*x(6)^2+x(5)*x(7)^2);
G1=27/(x(1)*x(2)^2*x(3))-1;
G2=397.5/(x(1)*x(2)^2*x(3)^2);
G3=1.93*x(4)^3/(x(2)*x(3)*x(6)^4);
G4=1.93*x(5)^3/(x(2)*x(3)*x(7)^4);
G5=1.0/(110*x(6)^3)*((745.0*x(4)/x(2)*x(3))^2+16.9*(10)^6)^(1/2)-1;
G6=1.0/(85*x(7)^3)*((745.0*x(5)/x(2)*x(3))^2+157.5*(10)^6)^1/2-1;
G7=x(2)*x(3)/40;
G8=5*x(2)/(x(1))-1;
G9=x(1)/(12*x(2))-1;
G10=(1.5*x(6)+1.9)/(x(4))-1;
G11=(1.1*x(7)+1.9)/(x(5))-1;
PHI =fit+ PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2+max(0,G7)^2+max(0,G8)^2+max(0,G9)^2+max(0,G10)^2+max(0,G11)^2); % PENALTY FUNCTION
end
if Benchmark_Function_ID==28 %Gear Train design
%% gear train design
%PCONST=10000;  % PENALTY FUNCTION CONSTANT
fit=((1/6.931)- floor (x(1))*floor (x(2))/floor (x(3))*floor (x(4)))^2;
PHI=fit;
end

if Benchmark_Function_ID==29 %Himmelblau's Problem
    %% Himmelblau's Problem
PCONST=10000;  % PENALTY FUNCTION CONSTANT
fit= 5.3578547* x(3)^2 + 0.8356891 *x(1)*x(5)+ 37.293239*x(1)-40792.141;
G1= 85.334407 +0.0056858*x(1)*x(5)+0.0006262*x(1)*x(4)-0.0022053*x(3)*x(5);
G2= 80.51249+ 0.0071317*x(2)*x(5)+0.0029955*x(1)*x(2)-0.0021813*x(3)^2;
G3= 9.300961+0.0047026*x(3)*x(5)+0.0012547*x(1)*x(3)-0.0019085*x(3)*x(4);
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+ max(0,G3)^2);
end
if Benchmark_Function_ID==30 %Three Bar Truss Design
    %% Three Bar Truss Design
PCONST=10000;  % PENALTY FUNCTION CONSTANT
P=2;
RU=2;
L=100;
fit=(2*(2*x(1))^1/2+x(2))*L;
G1=((2)^1/2*x(1)+ x(2))/ ((2)^1/2*x(1)^2+ 2*x(1)*x(2))*P-RU;
G2= (x(2))/ ((2)^1/2*x(1)^2+2*x(1)*x(2))*P-RU;
G3= (1)/(x(1)+ (2)^1/2*x(2))*P-RU;
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+ max(0,G3)^2);

end
if Benchmark_Function_ID==31 %Stepped Cantilever Beam Design
    %% Stepped Cantilever Beam Design
PCONST=10000;  % PENALTY FUNCTION CONSTANT
L=100;
P=50000;
E=2*107;
fit=(x(1)*x(6)+x(2)*x(7)+x(3)*x(8)+x(4)*x(9)+x(5)*x(10))*L;
G1= ((600*P)/(x(5)*x(10)^2))-14000;
G2= ((6*P*2*L)/(x(4)*x(9)^2))-14000;
G3= ((6*P*3*L)/(x(3)*x(8)^2))-14000;
G4= ((6*P*4*L)/(x(2)*x(7)^2))-14000;
G5= ((6*P*5*L)/(x(1)*x(6)^2))-14000;
G6= (((P*L^3)/(3*E))*(125/L))-2.7;
G7=(x(10)/x(5))-20;
G8=(x(9)/x(4))-20;
G9=(x(8)/x(3))-20;
G10=(x(7)/x(2))-20;
G11=(x(6)/x(1))-20;
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2+max(0,G7)^2+max(0,G8)^2+max(0,G9)^2+max(0,G10)^2+max(0,G11)^2); % PENALTY FUNCTION

end
if Benchmark_Function_ID==32 %Multiple Disc Clutch Brake Design
    %% Multiple Disc Clutch Brake Design
PCONST=100000;  % PENALTY FUNCTION CONSTANT
DR=20;
% T=3;
L=30;
% Z=10;
VSR=10;
MU=0.5;
S=1.5;
MS=40;
MF=3;
n=250;
P=1;
I=55;
T=15;
% F=1000;
% RI=80;
% % RO=110;
MH=(2/3)*MU*x(4)*x(5)*((x(2)^3-x(1)^3)/(x(2)^2-x(1)^2));
PRZ=x(4)/pi*(x(2)^2-x(1)^2);
VSR1= (2/90)*pi*n*((x(2)^3-x(1)^3)/(x(2)^2-x(1)^2));
T1= (I*pi*n)/(30*(MH+MF));
fit=pi*x(3)*( x(2)^2-x(1)^2)*(x(5)+1)*8*P;
G1= x(2)-x(1)-DR;
G2= L-(x(5)+1)*x(3);
G3= P-PRZ;
G4= P*VSR-PRZ*VSR;
G5=VSR-VSR1;
G6= T-T1;
G7= MH-S*MS;
G8= T1;
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2+max(0,G7)^2+max(0,G8)^2);
end
if Benchmark_Function_ID==33 %Hydrodynamic Thrust Bearing Design 
    %% Hydrodynamic Thrust Bearing Design 
PCONST=100000;  % PENALTY FUNCTION CONSTANT
WS=101000;
PMAX=1000;
DTM=50;
HM=0.001;
Y=0.0307;
C=0.5;
C1=10.04;
n=-3.55;
Ne=750;
Ge=386.4;
P= (log10(log10(8.1222*1e6*x(3)+0.8)-C1))/n;
DT= 2*(10^P-560);
EF= 9336* x(4)*Y*C*DT;
H= ((2*pi*Ne)/60)^2*((2*pi*x(3))/EF)*((x(1)^4/4)-((x(2)^4)/4));
P0= (6*x(3)*x(4)/pi*H^3)* log(x(1)/x(2));
W=((pi*P0)/2)*((x(1)^2*x(2)^2)/log(x(1)/x(2)));
fit=((x(4)*P0)/0.7)+EF;
G1= W-WS;
G2=PMAX-P0;
G3= DTM-DT;
G4= H-HM;
G5=x(1)-x(2);
G6= 0.001- (Y/(Ge*P0))*(x(4)/2*pi*x(1)*H);
G7= 5000- W/(pi*(x(1)^2*x(2)^2));
PHI =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2+max(0,G7)^2);
end
% function y=Ufun(x,a,k,m)
% y=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
% return