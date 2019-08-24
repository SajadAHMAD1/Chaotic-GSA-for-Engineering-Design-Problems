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

%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 


% Gravitational Search Algorithm.
% function BestChart=CHGSA(F_index,N,Max_Iteration,ElitistCheck,chaosIndex,chValueInitial)
function [Fbest,Lbest,BestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,chaosIndex,chValueInitial)
%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.
%  G_History=zeros(1,max_it);
  Rnorm=2; 
%  Rpower=1; 
%  min_flag=1; % 1: minimization, 0: maximization
 
%get allowable range and dimension of the test function.
% [low,up,dim]=test_functions_range(F_index); 
[down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);
%random initialization for agents.
% X=initialization(dim,N,up,low); 
X=initialization(dim,N,up,down); 
%create chart of best so far and average fitnesses.
BestChart=[];MeanChart=[];

V=zeros(dim,N);
wMax=chValueInitial;
wMin=1e-10;
for iteration=1:Max_Iteration
    chValue=wMax-iteration*((wMax-wMin)/Max_Iteration);

%     iteration
    
    %Checking allowable range. 
    X=space_bound(X,up,down); 

    %Evaluation of agents. 
    fitness=evaluateF(X,Benchmark_Function_ID); 
    
    [best best_X]=min(fitness); %min: minimization.  max: maximization.
    
    if iteration==1
       Fbest=best;Lbest=X(:,best_X);
    end
    if best<Fbest  % < : minimization. > : maximization
       Fbest=best;Lbest=X(:,best_X);
    end
      
BestChart=[BestChart Fbest];
MeanChart=[MeanChart mean(fitness)];

%Calculation of M. eq.14-20
[M]=massCalculation(fitness,min_flag); 

%Calculation of Gravitational constant. eq.13.
G=Gconstant(iteration,Max_Iteration);
%G=chaos(3,iteration,max_it,10);
switch chaosIndex
    case 1
        G=Gconstant(iteration,Max_Iteration); 
    case 2
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 3
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 4
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 5
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 6
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 7
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 8
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 9
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 10
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
    case 11
        G=G+chaos(chaosIndex-1,iteration,Max_Iteration,chValue);
end
G_History(iteration)=G;
test_G(iteration)=G;
if iteration==99
    alisop=0;
end
%Calculation of accelaration in gravitational field. eq.7-10,21.
a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,Max_Iteration);

%Agent movement. eq.11-12
[X,V]=move(X,a,V);


end %iteration

