%  Sine Cosine Algorithm (SCA)  
%
%  Source codes demo version 1.0                                                                      
%                                                                                                     
%  Developed in MATLAB R2011b(7.13)                                                                   
%                                                                                                     
%  Author and programmer: Seyedali Mirjalili                                                          
%                                                                                                     
%         e-Mail: ali.mirjalili@gmail.com                                                             
%                 seyedali.mirjalili@griffithuni.edu.au                                               
%                                                                                                     
%       Homepage: http://www.alimirjalili.com                                                         
%                                                                                                     
%  Main paper:                                                                                        
%  S. Mirjalili, SCA: A Sine Cosine Algorithm for solving optimization problems
%  Knowledge-Based Systems, DOI: http://dx.doi.org/10.1016/j.knosys.2015.12.022
%_______________________________________________________________________________________________
% You can simply define your cost function in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of iterations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single numbers

% To run SCA: [Best_score,Best_pos,cg_curve]=SCA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%______________________________________________________________________________________________


function [Destination_fitness,Destination_position,Convergence_curve]=SCA(Benchmark_Function_ID, N, Max_Iteration)
[down,up,dim]=benchmark_functions_details(Benchmark_Function_ID);
% display('SCA is optimizing your problem');

%Initialize the set of random solutions
X=initializationSCA(N,dim,up,down);

Destination_position=zeros(1,dim);
Destination_fitness=inf;

Convergence_curve=zeros(1,Max_Iteration);
Objective_values = zeros(1,size(X,1));

% Calculate the fitness of the first set and find the best one
for i=1:size(X,1)
Objective_values(1,i)=benchmark_functions(X(i,:),Benchmark_Function_ID,dim);
    if i==1
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    
    All_objective_values(1,i)=Objective_values(1,i);
end

%Main loop
t=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness
while t<=Max_Iteration
    
    % Eq. (3.4)
    a = 2;
    Max_Iteration = Max_Iteration;
    r1=a-t*((a)/Max_Iteration); % r1 decreases linearly from a to 0
    
    % Update the position of solutions with respect to destination
    for i=1:size(X,1) % in i-th solution
        for j=1:size(X,2) % in j-th dimension
            
            % Update r2, r3, and r4 for Eq. (3.3)
            r2=(2*pi)*rand();
            r3=2*rand;
            r4=rand();
            
            % Eq. (3.3)
            if r4<0.5
                % Eq. (3.1)
                X(i,j)= X(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-X(i,j)));
            else
                % Eq. (3.2)
                X(i,j)= X(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-X(i,j)));
            end
            
        end
    end
    
    for i=1:size(X,1)
         
        % Check if solutions go outside the search spaceand bring them back
        Flag4up=X(i,:)>up';
        Flag4down=X(i,:)<down';
        X(i,:)=(X(i,:).*(~(Flag4up+Flag4down)))+up'.*Flag4up+down'.*Flag4down;
        
        % Calculate the objective values
%         Objective_values(1,i)=fobj(X(i,:));
        Objective_values(1,i)=benchmark_functions(X(i,:),Benchmark_Function_ID,dim);
        % Update the destination if there is a better solution
        if Objective_values(1,i)<Destination_fitness
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
        end
    end
    
    Convergence_curve(t)=Destination_fitness;
    
    % Display the iteration and best optimum obtained so far
%     if mod(t,50)==0
%         display(['At iteration ', num2str(t), ' the optimum is ', num2str(Destination_fitness)]);
%     end
%     
    % Increase the iteration counter
    t=t+1;
end