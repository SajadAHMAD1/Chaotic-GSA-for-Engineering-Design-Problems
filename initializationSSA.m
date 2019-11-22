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


% This function initialize the first population of search agents
function Positions=initializationSSA(N,dim,up,down)

Boundary_no= size(up,1); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=rand(N,dim).*(up-down)+down;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        up_i=up(i);
        down_i=down(i);
        Positions(:,i)=rand(N,1).*(up_i-down_i)+down_i;
    end
end