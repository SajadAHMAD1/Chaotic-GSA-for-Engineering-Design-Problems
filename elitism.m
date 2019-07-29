
function [ newPopulation2 ] = elitism(population , newpopulation, Er)
 
M = length(newpopulation.Chromosomes); % number of individuals 
Elite_no = round(M * Er);

[max_val , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');

 
    
for k = 1 : Elite_no
    newPopulation2.Chromosomes(k).Gene  = population.Chromosomes(indx(k)).Gene;
    newPopulation2.Chromosomes(k).fitness  = population.Chromosomes(indx(k)).fitness;
end

for k = Elite_no + 1 :  length(newpopulation.Chromosomes)
    newPopulation2.Chromosomes(k).Gene  = newpopulation.Chromosomes(k).Gene;
    newPopulation2.Chromosomes(k).fitness  = newpopulation.Chromosomes(k).fitness;
end

end