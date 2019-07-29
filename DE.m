% The code has been taken from:
% Project Code: YPEA107
% Project Title: Implementation of Differential Evolution (DE) in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)

%% Problem Definition

% CostFunction=@(x) Sphere(x);    % Cost Function
% 
% nVar=20;            % Number of Decision Variables
% 
% VarSize=[1 nVar];   % Decision Variables Matrix Size
% 
% VarMin=-5;          % Lower Bound of Decision Variables
% VarMax= 5;          % Upper Bound of Decision Variables

%% DE Parameters

% MaxIt=1000;      % Maximum Number of Iterations

% nPop=50;        % Population Size

% beta_min=0.2;   % Lower Bound of Scaling Factor
% beta_max=0.8;   % Upper Bound of Scaling Factor
% 
% pCR=0.2;        % Crossover Probability
function [BestSolDE,DBestSol,BestCostDE] = DE(Benchmark_Function_ID, N, Max_Iteration,beta_min,beta_max,pCR)

[low,up,dim]=benchmark_functions_details(Benchmark_Function_ID);%define the boundary and dimension of the benchmark function

% %     pop(i).Position=unifrnd(low,up,dim);
%     if size(up,1)>1
%     for i=1:dim
%     high=up(i);ll=low(i);
%     pop(i).Position=rand(1,N).*(high-ll)+ll;
%     end
%     end
%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

BestSolDE.Cost=inf;

pop=repmat(empty_individual,N,1);
if size(up,1)>1
    for i=1:dim
        high=up(i);ll=low(i);
    end
end
for i=1:N
    pop(i).Position=rand(1,dim).*(high-ll)+ll;
    pop(i).Cost=benchmark_functions(pop(i).Position,Benchmark_Function_ID,dim);
    
%     if pop(i).Cost<BestSolDE.Cost
%         BestSolDE=pop(i);
%     end
    
end
% Best Solution Ever Found
DBestSol=pop(1);

BestCostDE=zeros(Max_Iteration,1);

%% DE Main Loop

for it=1:Max_Iteration
    
    for i=1:N
%         for k=1:dim
        
        x=pop(i).Position;
        
        A=randperm(N);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        
        % Mutation
        %beta=unifrnd(beta_min,beta_max);
         beta=rand(1,dim).*(beta_max-beta_min)+beta_min;
%         beta=unifrnd(beta_min,beta_max,dim);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        y = max(y, ll);
		y = min(y, high);
%         end 
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end
        
        NewSol.Position=z;
%         NewSol.Cost=CostFunction(NewSol.Position);
       NewSol.Cost=benchmark_functions(NewSol.Position,Benchmark_Function_ID,dim);
        if NewSol.Cost<pop(i).Cost
            pop(i)=NewSol;
            
            if pop(i).Cost<BestSolDE.Cost
               BestSolDE=pop(i);
            end
        end
        
    end
   % Update Best Solution Ever Found
    DBestSol=pop(1);
    % Update Best Cost
    BestCostDE(it)=BestSolDE.Cost;
    
%     % Show Iteration Information
%      disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Show Results

% figure;
% %plot(BestCost);
% semilogy(BestCost, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;
