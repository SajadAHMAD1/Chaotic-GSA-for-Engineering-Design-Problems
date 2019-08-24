
                      
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
%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 



% This function gives boundaries and dimension of search space for test functions.
function [down,up,dim]=benchmark_functions_details(Benchmark_Function_ID)

%If lower bounds of dimensions are the same, then 'down' is a value.
%Otherwise, 'down' is a vector that shows the lower bound of each dimension.
%This is also true for upper bounds of dimensions.

%Insert your own boundaries with a new Benchmark_Function_ID.

 dim=30;
 if Benchmark_Function_ID==1
     down=-100;up=100;
 end

if Benchmark_Function_ID==2
    down=-10;up=10;
end

if Benchmark_Function_ID==3
    down=-100;up=100;
end

if Benchmark_Function_ID==4
    down=-100;up=100;
end

if Benchmark_Function_ID==5
    down=-30;up=30;
end

if Benchmark_Function_ID==6
    down=-100;up=100;
end

if Benchmark_Function_ID==7
    down=-1.28;up=1.28;
end

if Benchmark_Function_ID==8
    down=-500;up=500;
end

if Benchmark_Function_ID==9
    down=-5.12;up=5.12;
end

if Benchmark_Function_ID==10
    down=-32;up=32;
end

if Benchmark_Function_ID==11
    down=-600;up=600;
end

if Benchmark_Function_ID==12
    down=-50;up=50;
end

if Benchmark_Function_ID==13
    down=-50;up=50;
end

if Benchmark_Function_ID==14
    down=-65.536;up=65.536;dim=2;
end

if Benchmark_Function_ID==15
    down=-5;up=5;dim=4;
end

if Benchmark_Function_ID==16
    down=-5;up=5;dim=2;
end

if Benchmark_Function_ID==17
    down=[-5;0];up=[10;15];dim=2;
end

if Benchmark_Function_ID==18
    down=-2;up=2;dim=2;
end

if Benchmark_Function_ID==19
    down=0;up=1;dim=3;
end

if Benchmark_Function_ID==20
    down=0;up=1;dim=6;
end

if Benchmark_Function_ID==21
    down=0;up=10;dim=4;
end

if Benchmark_Function_ID==22
    down=0;up=10;dim=4;
end

if Benchmark_Function_ID==23
    down=0;up=10;dim=4;
end
if Benchmark_Function_ID==24 %Welded Design
    down=[0.10;0.10;0.10;0.10];
    up=[2;10;10;2];
    dim=4;
end
if Benchmark_Function_ID==25 %Spring Design
    down=[0.05;0.25;2.00];
    up=[2.00;1.30;15.0];
    dim=3;

end
if Benchmark_Function_ID==26 %Pressure vessel

down=[0;0;10;10];         % Lower Bound of Variables
up= [99;99;200;200];    % Upper Bound of Variables
dim=4;
end
if Benchmark_Function_ID==27 %Speed Reducer design
down=[2.6;0.7;17;7.3;7.8;2.9;5];         % Lower Bound of Variables
up= [3.6;0.8;28;8.3;8.3;3.9;5.5];        % Upper Bound of Variables
dim=7;
end
if Benchmark_Function_ID==28 %Gear Train design
    down=[12;12;12;12]; % Lower Bound of Variables
    up=[60;60;60;60];   % Upper Bound of Variables
    dim=4;
end
if Benchmark_Function_ID==29 %Himmelblau's Problem
    down=[78;33;27;27;27]; % Lower Bound of Variables
    up=[102;45;45;45;45];   % Upper Bound of Variables
    dim=5;
end
if Benchmark_Function_ID==30 % Three Bar Truss Design
    down=[0;0]; % Lower Bound of Variables
    up=[1;1];   % Upper Bound of Variables
    dim=2;
end
if Benchmark_Function_ID==31 % Stepped Cantilever Beam Design
    down=[1;1;1;1;1;30;30;30;30;30]; % Lower Bound of Variables
    up=[5;5;5;5;5;65;65;65;65;65];   % Upper Bound of Variables
    dim=10;
end
if Benchmark_Function_ID==32 % Multiple Disc Clutch Brake Design
    down=[60;90;1.5;600;2]; % Lower Bound of Variables
    up=[80;110;3;1000;9];   % Upper Bound of Variables
    dim=5;
end
if Benchmark_Function_ID==33 % Hydrodynamic Thrust Bearing Design
    down=[1;1;1e6;1];        % Lower Bound of Variables
    up=[16;16;16e6;16];       % Upper Bound of Variables
    dim=4;
end








