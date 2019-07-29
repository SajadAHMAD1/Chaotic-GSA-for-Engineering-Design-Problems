
function [child] = mutation_continious(child, Pm, Benchmark_Function_ID,up,low)

Gene_no = length(child.Gene);

for k = 1: Gene_no
    R = rand();
    if R < Pm
        child.Gene(k) = (up(k) - low(k)) * rand() +low(k);
    end
end

end