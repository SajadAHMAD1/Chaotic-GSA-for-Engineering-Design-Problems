
function   fitness=evaluateF(X,Benchmark_Function_ID)

[dim,N]=size(X);
for i=1:N 
    L=X(:,i)';
    %calculation of objective function
    fitness(i)=benchmark_functions(L,Benchmark_Function_ID,dim);
end