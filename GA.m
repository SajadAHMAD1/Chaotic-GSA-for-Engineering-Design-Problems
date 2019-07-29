 
% The code has been taken from:
% www.alimirjalili.com

function [BestChrom , cgcurve]  = GA (N,Max_Iteration,Pc,Pm,Er,Benchmark_Function_ID);
[low,up,dim]=benchmark_functions_details(Benchmark_Function_ID);%define the boundary and dimension of the benchmark function
cgcurve = zeros(1,Max_Iteration);

%%  Initialization
[ population ] = Geinitialization(N, dim, Benchmark_Function_ID,up,low);
for i = 1 : N
    population.Chromosomes(i).fitness = benchmark_functions( population.Chromosomes(i).Gene(:),Benchmark_Function_ID,dim);
end

all_fitness_values = [ population.Chromosomes(:).fitness ];
[cgcurve(1) , ~ ] = max( all_fitness_values);

g = 1;
% disp(['In generation #' , num2str(g) , ' best fitness value = ', num2str(cgcurve(g))]);

%% Main loop
for g = 2 : Max_Iteration
    for k = 1: 2: N
        % Selection
        [ parent1, parent2] = selection(population);
        
        % Crossover
        [child1 , child2] = crossover_continious(parent1 , parent2, Pc, Benchmark_Function_ID,dim,up,low);
        
        % Mutation    
        [child1] = mutation_continious(child1, Pm, Benchmark_Function_ID,up,low);
        [child2] = mutation_continious(child2, Pm, Benchmark_Function_ID,up,low);
        
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
    end
    
    for i = 1 : N
       newPopulation.Chromosomes(i).fitness = benchmark_functions( newPopulation.Chromosomes(i).Gene(:),Benchmark_Function_ID,dim);
    end
    
    % Elitism
    [ newPopulation ] = elitism(population , newPopulation, Er);
    
    population = newPopulation;
    all_fitness_values = [ population.Chromosomes(:).fitness ];
    [cgcurve(g) , ~ ] = max( all_fitness_values);
    
%     disp(['In generation #' , num2str(g) , ' best fitness value = ', num2str(cgcurve(g))]);    
end

for i = 1 : N
    population.Chromosomes(i).fitness = benchmark_functions( population.Chromosomes(i).Gene(:),Benchmark_Function_ID,dim);
end


[max_val , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');

BestChrom.Gene    = population.Chromosomes(indx(1)).Gene;
BestChrom.Fitness = population.Chromosomes(indx(1)).fitness;

end