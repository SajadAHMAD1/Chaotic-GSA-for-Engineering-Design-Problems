                                            %

                      
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
%                                    King Saud Journal of Informational Sciences (Elsevier)
%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 


sz = 40;
c = linspace(1,10,length(BestSolutions1));

% c = linspace(1,10,length(x));
% h=scatter(BestSolutions1,BestSolutions2,sz,c,'filled','d')
scatter(BestSolutions1,BestSolutions2,sz,'MarkerEdgeColor',[0 .3 .3],...
              'MarkerFaceColor',[0 .6 .6],...
              'LineWidth',2.5)
%  h=scatter(BestSolutions1,BestSolutions2,[],c)
% scatter3(BestSolutions1,BestSolutions2,c)
title ('\fontsize{12}\bf Welded Beam Design')
%  h.MarkerFaceColor = [0 0.5 0.5];
legend('\fontsize{10}\bf CGSA vs CPSOGSA ',1);