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



function [cgCurve,GBEST] = pso( Benchmark_Function_ID, N, Max_Iteration)


% dim=30;
 

% Define the details of the objective function 
%get allowable range and dimension of the test function.
 [down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);
% PSO parameters 
% noP = 5;
% maxIter = 100;
% visFlag = 0;
% 
% RunNo  = 30; 
%  
% 
% for k = [ 1 : 1 : RunNo ]
%    fit=benchmark_functions(currentX,Benchmark_Function_ID,dim);
    
    % PSO 1
%     [ GBEST  , cgcurve1] = PSO( Benchmark_Function_ID, N, Max_Iteration) ;
%     BestSolutions1(k) = GBEST.O;
%     
%    disp(['Run # ' , num2str(k), 'GBEST.O:  ' , num2str( GBEST.O)]);
% end
% % Define the details of the objective function 
% %get allowable range and dimension of the test function.
%  [down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);


% Define the PSO's paramters 
wMax = 0.9;
wMin = 0.2;
c1 = 2;
c2 = 2;
if size(up,1)==1
    current_position=rand(dim,N).*(up-down)+down;
    VelMax=0.1*(up-down);
    VelMin=-up;
end
if size(up,1)>1
    for i=1:dim
    high=up(i);ll=down(i);
    current_position(i,:)=rand(1,N).*(high-ll)+ll;
    VelMax=0.1*(high-ll);
    VelMin=-high;
    end
end
vMax = (up - down) .* 0.2; 
vMin  = -vMax;


% The PSO algorithm 

% Initialize the particles 
for k = 1 :N
%     Swarm.Particles(k).X = (up-down) .* rand(1,dim) + down; 
    Swarm.Particles(k).X = (high-ll) .* rand(1,dim) + ll; 
    
    Swarm.Particles(k).V = zeros(1, dim); 
    Swarm.Particles(k).PBEST.X = zeros(1,dim); 
    Swarm.Particles(k).PBEST.O = inf; 
    
    Swarm.GBEST.X = zeros(1,dim);
    Swarm.GBEST.O = inf;
end


% Main loop
for t = 1 : Max_Iteration
    
    % Calcualte the objective value
    for k = 1 : N
        currentX = Swarm.Particles(k).X;
        Swarm.Particles(k).O = benchmark_functions(currentX,Benchmark_Function_ID,dim);
        
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O 
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vectors 
    w = wMax - t .* ((wMax - wMin) / Max_Iteration);
    
    for k = 1 : N
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V + c1 .* rand(1,dim) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
                                                                                     + c2 .* rand(1,dim) .* (Swarm.GBEST.X - Swarm.Particles(k).X);
                                                                                 
           %  Apply Velocity Limits
        Swarm.Particles(k).V= max(Swarm.Particles(k).V,VelMin);
        Swarm.Particles(k).V = min(Swarm.Particles(k).V,VelMax);
%         % Check velocities 
%         index1 = find(Swarm.Particles(k).V > vMax);
%         index2 = find(Swarm.Particles(k).V < vMin);
% %         
%         Swarm.Particles(k).V(index1) = vMax(index1);
%         Swarm.Particles(k).V(index2) = vMin(index2);
        
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        %  Velocity Mirror Effect
%         IsOutside=(Swarm.Particles(k).X<down| Swarm.Particles(k).X>up);
%         Swarm.Particles(k).V (IsOutside)=-Swarm.Particles(k).V (IsOutside);
         %  Velocity Mirror Effect
        IsOutside=(Swarm.Particles(k).X<ll| Swarm.Particles(k).X>high);
        Swarm.Particles(k).V (IsOutside)=-Swarm.Particles(k).V (IsOutside);
% %  Apply Position Limits
       Swarm.Particles(k).X = max(Swarm.Particles(k).X,ll);
       Swarm.Particles(k).X= min(Swarm.Particles(k).X,high);
%         %  Apply Position Limits
%        Swarm.Particles(k).X = max(Swarm.Particles(k).X,down);
%        Swarm.Particles(k).X= min(Swarm.Particles(k).X,up);
        % Check positions 
%         index1 = find(Swarm.Particles(k).X > high);
%         index2 = find(Swarm.Particles(k).X < ll);
%         
%         Swarm.Particles(k).X(index1) = high(index1);
%         Swarm.Particles(k).X(index2) = ll(index2);
%         
    end
    
%     if dataVis == 1
%         outmsg = ['Iteration# ', num2str(t) , ' Swarm.GBEST.O = ' , num2str(Swarm.GBEST.O)];
%         disp(outmsg);
%     end
%     
    cgCurve(t) = Swarm.GBEST.O;
end

GBEST = Swarm.GBEST;
 
% if dataVis == 1
%     semilogy(cgCurve);
%     xlabel('Iteration#')
%     ylabel('Weight')
% end