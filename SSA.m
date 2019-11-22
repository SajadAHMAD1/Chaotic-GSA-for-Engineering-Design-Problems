%_________________________________________________________________________________
%  Salp Swarm Algorithm (SSA) source codes version 1.0
%
%  Developed in MATLAB R2016a
%
%  Author and programmer: Seyedali Mirjalili
%
%         e-Mail: ali.mirjalili@gmail.com
%                 seyedali.mirjalili@griffithuni.edu.au
%
%       Homepage: http://www.alimirjalili.com
%
%   Main paper:
%   S. Mirjalili, A.H. Gandomi, S.Z. Mirjalili, S. Saremi, H. Faris, S.M. Mirjalili,
%   Salp Swarm Algorithm: A bio-inspired optimizer for engineering design problems
%   Advances in Engineering Software
%   DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.07.002
%____________________________________________________________________________________

function [FoodFitness,FoodPosition,Convergence_curve]=SSA(Benchmark_Function_ID, N, Max_Iteration)
% [FoodFitness,FoodPosition,Convergence_curve]=SSA(N,Max_iter,lb,ub,dim,fobj)
[down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);
if size(up,1)==1
    up=ones(dim,1)*up;
    down=ones(dim,1)*down;
end

Convergence_curve = zeros(1,Max_Iteration);

%Initialize the positions of salps
SalpPositions=initializationSSA(N,dim,up,down);
% pop(i).Cost=benchmark_functions(pop(i).Position,Benchmark_Function_ID,dim);

FoodPosition=zeros(1,dim);
FoodFitness=inf;


%calculate the fitness of initial salps

for i=1:size(SalpPositions,1)
    SalpFitness(1,i)=benchmark_functions(SalpPositions(i,:),Benchmark_Function_ID,dim);
end

[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);

for newindex=1:N
    Sorted_salps(newindex,:)=SalpPositions(sorted_indexes(newindex),:);
end

FoodPosition=Sorted_salps(1,:);
FoodFitness=sorted_salps_fitness(1);

%Main loop
l=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness of salps
while l<Max_Iteration+1
    
    c1 = 2*exp(-(4*l/Max_Iteration)^2); % Eq. (3.2) in the paper
    
    for i=1:size(SalpPositions,1)
        
        SalpPositions= SalpPositions';
        
        if i<=N/2
            for j=1:1:dim
                c2=rand();
                c3=rand();
                %%%%%%%%%%%%% % Eq. (3.1) in the paper %%%%%%%%%%%%%%
                if c3<0.5 
                    SalpPositions(j,i)=FoodPosition(j)+c1*((up(j)-down(j))*c2+down(j));
                else
                    SalpPositions(j,i)=FoodPosition(j)-c1*((up(j)-down(j))*c2+down(j));
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
        elseif i>N/2 && i<N+1
            point1=SalpPositions(:,i-1);
            point2=SalpPositions(:,i);
            
            SalpPositions(:,i)=(point2+point1)/2; % % Eq. (3.4) in the paper
        end
        
        SalpPositions= SalpPositions';
    end
    
    for i=1:size(SalpPositions,1)
        
        Tp=SalpPositions(i,:)>up';
        Tm=SalpPositions(i,:)<down';
        SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+up'.*Tp+down'.*Tm;
        
%         SalpFitness(1,i)=fobj(SalpPositions(i,:));
        SalpFitness(1,i)=benchmark_functions(SalpPositions(i,:),Benchmark_Function_ID,dim);
        if SalpFitness(1,i)<FoodFitness
            FoodPosition=SalpPositions(i,:);
            FoodFitness=SalpFitness(1,i);
            
        end
    end
    
    Convergence_curve(l)=FoodFitness;
    l = l + 1;
end



