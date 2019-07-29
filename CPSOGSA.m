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




                              %-------------------------------------------%
                              %         Evaluate the population           %           
                              %-------------------------------------------%                                 %--%
 %%% Variables %%%

%current_position:  Position of particles
%velocity:          Velocity
%force:             The gravitational force between the particles
%acceleration:      Acceleration
%mass:              Mass 
%dim:               Dimension of test functions
%n:                 Number of particles
%G0                 Gravitational constant
%low:               The lower bound of the search space
%up:                The higher bound of the search space


function [gBestScore,gBest,GlobalBestCost]=CPSOGSA(Benchmark_Function_ID,n,iteration)

[low,up,dim]=benchmark_functions_details(Benchmark_Function_ID);%define the boundary and dimension of the benchmark function
                                %%%%
% % Constriction Coefficients
phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
C1=chi*phi1;    % Personal Learning Coefficient
C2=chi*phi2;    % Global Learning Coefficient

                                %%%%
current_fitness =zeros(n,1);
gBest=zeros(1,dim);
gBestScore=inf;
% w=1;
% wdamp=0.99;
% VelMax=0.1*(up-low);
% VelMin=-up;

for i=1:n
        pBestScore(i)=inf;
end
        pBest=zeros(n,dim);

G0=1;                                          % gravitational constant
if size(up,1)==1
    current_position=rand(dim,n).*(up-low)+low;
end
if size(up,1)>1
    for i=1:dim
    high=up(i);ll=low(i);
    current_position(i,:)=rand(1,n).*(high-ll)+ll;
    VelMax=0.1*(high-ll);
    VelMin=-high;
    end
end
% current_position = rand(n,dim).*(up-low)+low;  %initial positions in the problem's boundary
velocity = .3*randn(dim,n) ;
acceleration=zeros(dim,n);
mass(n)=0;
force=zeros(dim,n);

%C1=0.5; %C1 in Equation (9)
% C2=1.5; %C2 in Equation (9)

%%main loop
iter = 0 ;                  % Iterations’ counter
while  ( iter < iteration )

G=G0*exp(-23*iter/iteration); %Equation (4)
iter = iter + 1;
iter;
force=zeros(dim,n);
mass(n)=0;
acceleration=zeros(dim,n);
[dim,n]=size(current_position);
 for i = 1:n
   
%     %///Bound the search Space///
    Tp=current_position(:,i)>up;
    Tm=current_position(:,i)<low;
    current_position(:,i)=(current_position(:,i).*(~(Tp+Tm)))+up.*Tp+low.*Tm; 
%     %%
%     [N,dim]=size(X);
% for i=1:n 
% Tp=X(i,:)>up;Tm=X(i,:)<low;X(i,:)=(X(i,:).*(~(Tp+Tm)))+up.*Tp+low.*Tm;
%     %%Agents that go out of the search space, are reinitialized randomly .
%     Tp=current_position(i,:)>up;Tm=current_position(i,:)<low;current_position(i,:)=(current_position(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-low)+low).*(Tp+Tm));
    %%
    %////////////////////////////
    
                                 %-------------------------------------------%
                                 %         Evaluate the population           %           
                                 %-------------------------------------------% 
     fitness=0;
    fitness=benchmark_functions(current_position(:,i)',Benchmark_Function_ID,dim);
    current_fitness(i)=fitness;    
        
    if(pBestScore(i)>fitness)
        pBestScore(i)=fitness;
        pBest(i,:)=current_fitness(i,:);
    end
    if(gBestScore>fitness)
        gBestScore=fitness;
        gBest=current_position(:,i)';
    end
    
end

best=min(current_fitness);
% AVE=mean(current_fitness);
% STD=std(current_fitness);
 worst=max(current_fitness);

        GlobalBestCost(iter)=gBestScore;
        GlobalBestCost(iter);
        best;
        
%         AverageCost(iter)=gBestScore;
%         AverageCost(iter);
%         AVE;
%         
%         StandardDCost(iter)=gBestScore;
%         StandardDCost(iter);
%         STD;
        

    for pp=1:n
        if current_fitness(pp)==best
            break;
        end
        
    end
    
    bestIndex=pp;
            
    for pp=1:dim
        best_fit_position(iter,1)=best;
        best_fit_position(iter,pp+1)=current_position(pp,bestIndex);   
    end

%  disp(['Iteration ' num2str(iter) ': GlobalBestCost = ' num2str(GlobalBestCost)]);
                                               %-------------------%
                                               %   Calculate Mass  %
                                               %-------------------%
    for i=1:n
    mass(i)=(current_fitness(i)-0.99*worst)/(best-worst);    
end

for i=1:n
    mass(i)=mass(i)*5/sum(mass);    
    
end

                                               %-------------------%
                                               %  Force    update  %
                                               %-------------------%

for i=1:n
    for j=1:dim
        for k=1:n
            if(current_position(j,k)~=current_position(j,i))
                % Equation (3)
                force(j,i)=force(j,i)+ rand()*G*mass(k)*mass(i)*(current_position(j,k)-current_position(j,i))/abs(current_position(j,k)-current_position(j,i));
                
            end
        end
    end
end
                                               %------------------------------------%
                                               %  Accelations $ Velocities  UPDATE  %
                                               %------------------------------------%

for i=1:n
       for j=1:dim
            if(mass(i)~=0)
                %Equation (6)
                acceleration(j,i)=force(j,i)/mass(i);
            end
       end
end   

for i=1:n
        for j=1:dim
            %Equation(9)
            velocity(j,i)=w*rand()*velocity(j,i)+C1*rand()*acceleration(j,i) + C2*rand()*(gBest(j)-current_position(j,i));
%             size(velocity)
         % Apply Velocity Limits
%        velocity(j,i) = max(velocity(j,i),VelMin);
%        velocity(j,i) = min(velocity(j,i),VelMax);
        end

      
end
                                               %--------------------------%
                                               %   positions   UPDATE     %
                                               %--------------------------%
                                                        
%Equation (10) 
current_position = current_position + velocity ;

 % Velocity Mirror Effect
%         IsOutside=(current_position<ll | current_position>high);
%        velocity(IsOutside)=-velocity(IsOutside);
%    % Apply Position Limits     
% current_position = max(current_position,ll);
%  current_position = min(current_position,high);
 w=w*wdamp;
   % Show Iteration Information
%     disp(['Iteration ' num2str(iter) ': GlobalBestCost = ' num2str(GlobalBestCost)]);
end
end


