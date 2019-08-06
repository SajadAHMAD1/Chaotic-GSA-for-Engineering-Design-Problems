
function G=Gconstant(iteration,Max_Iteration)
%%%here, make your own function of 'G'

  alfa=20;G0=100;
  G=G0*exp(-alfa*iteration/Max_Iteration); %eq. 28.
