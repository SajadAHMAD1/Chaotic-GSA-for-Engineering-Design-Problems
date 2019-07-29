% The code has been taken from:
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
function [BestCost,BestSol] = bbo( Benchmark_Function_ID, N, Max_Iteration)
%% Problem Definition

% CostFunction=@(x) Sphere(x);        % Cost Function

% nVar=5;             % Number of Decision Variables
% 
% VarSize=[1 nVar];   % Decision Variables Matrix Size
% 
% VarMin=-10;         % Decision Variables Lower Bound
% VarMax= 10;         % Decision Variables Upper Bound
[down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);
%% BBO Parameters

% MaxIt=1000;          % Maximum Number of Iterations
VarSize=[1 dim];
% N=50;            % Number of Habitats (Population Size)

KeepRate=0.2;                   % Keep Rate
nKeep=round(KeepRate*N);     % Number of Kept Habitats

nNew=N-nKeep;                % Number of New Habitats

% Migration Rates
mu=linspace(1,0,N);          % Emmigration Rates
lambda=1-mu;                    % Immigration Rates

alpha=0.9;

pMutation=0.1;



%% Initialization
if size(up,1)==1
    current_position=rand(dim,N).*(up-down)+down;
        sigma=0.02*(up-down);
end
if size(up,1)>1
    for i=1:dim
        high=up(i);ll=down(i);
        sigma=0.02*(high-ll);
    end
end
% Empty Habitat
habitat.Position=[];
habitat.Cost= [];
% benchmark_functions(currentX,Benchmark_Function_ID,dim);

% Create Habitats Array
pop=repmat(habitat,N,1);

% Initialize Habitats
for i=1:N
   pop(i).Position= (high-ll).* rand(1,dim) + ll;
%     pop(i).Position=unifrnd(down,up,VarSize);
%     pop(i).Position=unifrnd(ll,high,VarSize);
    pop(i).Cost=benchmark_functions(pop(i).Position,Benchmark_Function_ID,dim);
end

% Sort Population
[~, SortOrder]=sort([pop.Cost]);
pop=pop(SortOrder);

% Best Solution Ever Found
BestSol=pop(1);

% Array to Hold Best Costs
BestCost=zeros(Max_Iteration,1);

%% BBO Main Loop

for it=1:Max_Iteration
    
    newpop=pop;
    for i=1:N
        for k=1:dim
            % Migration
            if rand<=lambda(i)
                % Emmigration Probabilities
                EP=mu;
                EP(i)=0;
                EP=EP/sum(EP);
                
                % Select Source Habitat
                j=RouletteWheelSelection(EP);
                
                % Migration
                newpop(i).Position(k)=pop(i).Position(k) ...
                    +alpha*(pop(j).Position(k)-pop(i).Position(k));
                
            end
            
            % Mutation
            if rand<=pMutation
                newpop(i).Position(k)=newpop(i).Position(k)+sigma*randn;
            end
        end
        
        % Apply Lower and Upper Bound Limits
%         newpop(i).Position = max(newpop(i).Position, down);
%         newpop(i).Position = min(newpop(i).Position, up);
%          % Apply Lower and Upper Bound Limits
        newpop(i).Position = max(newpop(i).Position, ll);
        newpop(i).Position = min(newpop(i).Position, high);
        
        % Evaluation
        newpop(i).Cost=benchmark_functions(newpop(i).Position,Benchmark_Function_ID,dim);
    end
    
    % Sort New Population
    [~, SortOrder]=sort([newpop.Cost]);
    newpop=newpop(SortOrder);
    
    % Select Next Iteration Population
    pop=[pop(1:nKeep)
         newpop(1:nNew)];
     
    % Sort Population
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);
    
    % Update Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
%     % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

% %% Results
% 
% figure;
% %plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;


