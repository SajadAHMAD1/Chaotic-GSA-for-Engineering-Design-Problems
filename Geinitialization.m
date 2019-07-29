

function [ population ] = Geinitialization(N, dim, Benchmark_Function_ID,up,low)

for i = 1 : N
    for j = 1 : dim
        population.Chromosomes(i).Gene(j) = (up(j) - low(j)) * rand() +low(j);
    end
end

