

% This function creates the first random population of moths

function X=initializationSCA(N,dim,up,down)

Boundary_no= size(up,1); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    X=rand(N,dim).*(up-down)+down;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=up(i);
        lb_i=down(i);
        X(:,i)=rand(N,1).*(ub_i-lb_i)+lb_i;
    end
end
