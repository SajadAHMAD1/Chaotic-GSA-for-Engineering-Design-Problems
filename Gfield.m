
function a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,Max_Iteration);

[dim,N]=size(X);
 final_per=2; %In the last iteration, only 2 percent of agents apply force to the others.

%%%%total force calculation
 if ElitistCheck==1
     kbest=final_per+(1-iteration/Max_Iteration)*(100-final_per); %kbest in eq. 21.
     kbest=round(N*kbest/100);
 else
     kbest=N; %eq.9.
 end
    [Ms ds]=sort(M,'descend');

 for i=1:N
     E(:,i)=zeros(1,dim);
     for ii=1:kbest
         j=ds(ii);
         if j~=i
            R=norm(X(:,i)-X(:,j),Rnorm); %Euclidian distanse.
         for k=1:dim 
             E(k,i)=E(k,i)+rand*(M(j))*((X(k,j)-X(k,i))/(R^Rpower+eps));
              %note that Mp(i)/Mi(i)=1
         end
         end
     end
 end

%%acceleration
a=E.*G; %note that Mp(i)/Mi(i)=1


