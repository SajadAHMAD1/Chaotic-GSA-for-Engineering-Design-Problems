
function [child1 , child2] = crossover_continious(parent1 , parent2, Pc, Benchmark_Function_ID,dim,up,low)

child1.Gene = zeros(1,dim);
child2.Gene = zeros(1,dim);
for k = 1 : dim
    beta = rand();
    child1.Gene(k) = beta .* parent1.Gene(k) + (1-beta)*parent2.Gene(k); 
    child2.Gene(k) = (1-beta) .* parent1.Gene(k) + beta*parent2.Gene(k);
    
    if child1.Gene(k) > up(k) 
        child1.Gene(k)  =  up(k);
    end
    if child1.Gene(k) < low(k)
        child1.Gene(k) = low(k);
    end
    
    if child2.Gene(k) > up(k) 
        child2.Gene(k)  =  up(k);
    end
    
    if child2.Gene(k) < low(k)
        child2.Gene(k) = low(k);
    end
end

R1 = rand();

if R1 <= Pc
    child1 = child1;
else
    child1 = parent1;
end

R2 = rand();

if R2 <= Pc
    child2 = child2;
else
    child2 = parent2;
end

end