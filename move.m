%This function updates the velocity and position of agents.
function [X,V]=move(X,a,V)

%movement.
[dim,N]=size(X);
V=rand(dim,N).*V+a; %eq. 11.
X=X+V; %eq. 12.