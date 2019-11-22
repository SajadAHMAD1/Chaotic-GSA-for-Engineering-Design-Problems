
                      
%              Chaotic GSA for Engineering Design Problems
% 
%                  E-Mail: sajad.win8@gmail.com                   
%                                                                         
%              Homepage: https://github.com/SajadAHMAD1.                            
%                                                                             
%               Department of Computer Science and Engineering
%               School of Engineering and Technology
%               Pondicherry University- 605014, India
%               

%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 

 


clear all
close all
clc

N = 50;                              % Size of the swarm " no of objects "
Max_Iteration  = 100;              % Maximum number of "iterations"
Q=1;            % ACO Parameter
tau0=10;        % Initial Phromone             (ACO)
alpha=0.3;      % Phromone Exponential Weight  (ACO)
rho=0.1;        % Evaporation Rate             (ACO)
Pc = 0.95;      % GA Parameter
Pm = 0.001;     % GA Parameter
Er = 0.2;       % GA Parameter
beta_min=0.2;   % Lower Bound of Scaling Factor (DE)
beta_max=0.8;   % Upper Bound of Scaling Factor (DE)
pCR=0.2;        % Crossover Probability         (DE)
All_Convergence_curves=zeros(2,Max_Iteration);
 ElitistCheck=1; % GSA Parameter
 Rpower=1;       % GSA Parameter
 min_flag=1; % 1: minimization, 0: maximization (GSA)
 Algorithm_num=6;
 chValueInitial=20; % CGSA
%  chaosIndex=12; % CGSA
% subplot(3,2,1);
 Benchmark_Function_ID=26 %Benchmark function ID

    RunNo  = 20; 
for k = [ 1 : 1 : RunNo ]   
% % %   
[gBestScorePSOGSA,gBestPSOGSA,GlobalBestCostPSOGSA]=PSOGSA(Benchmark_Function_ID, N,Max_Iteration);
BestSolutions1(k) = gBestScorePSOGSA;
[gBestScore,gBest,GlobalBestCost]= CPSOGSA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions2(k) = gBestScore;
[Fbest,Lbest,BestChart]=GSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower);
BestSolutions3(k) = Fbest;
  [PcgCurve,GBEST]=pso(Benchmark_Function_ID,N,Max_Iteration);
     BestSolutions4(k) = GBEST.O;
 [BestCost,BestSol] = bbo( Benchmark_Function_ID, N, Max_Iteration);
     BestSolutions5(k) = BestSol.Cost;
[BestSolga,BestCostga] = ga(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions6(k) = BestSolga.Cost ;
[BestSolDE,DBestSol,BestCostDE] = DE(Benchmark_Function_ID, N, Max_Iteration,beta_min,beta_max,pCR);
BestSolutions7(k) = BestSolDE.Cost ;
  [BestSolACO,BestAnt,BestCostACO] = ACO(Benchmark_Function_ID, N, Max_Iteration,Q,tau0,alpha,rho);
BestSolutions8(k) = BestSolACO.Cost ;
[Best_score,Best_pos,SSA_cg_curve]=SSA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions9(k) = Best_score ;
% [TargetFitness,TargetPosition,Convergence_curve]=GOA(Benchmark_Function_ID, N, Max_Iteration);
% BestSolutions(k) = TargetFitness ;
[Best_scoreSCA,Best_pos,SCA_cg_curve]=SCA(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions10(k) = Best_scoreSCA ;
[Best_scoreGWO,Best_pos,GWO_cg_curve]=GWO(Benchmark_Function_ID, N, Max_Iteration);
BestSolutions11(k) = Best_scoreGWO ;
%  [CFbest,CLbest,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
 if Algorithm_num==6
    [CFbest,CLbest1,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
 end
 BestSolutions12(k) = CFbest ;
    Average= mean(BestSolutions1);
    StandDP=std(BestSolutions1);
    Med = median(BestSolutions1); 
    [BestValueP I] = min(BestSolutions1);
    [WorstValueP IM]=max(BestSolutions1);
% Wilcoxon rank sum test
% disp(' Wilcoxon RankSum Test ')
% [p,h,stats]=ranksum(GlobalBestCost,GlobalBestCost)  
       disp(['Run # ' , num2str(k), ' gBestScorePSOGSA:  ' , num2str( gBestScorePSOGSA)]);
%      disp(['Run # ' , num2str(k), ' gBestScore:  ' , num2str( gBestScore)]);
%      disp(['Run # ' , num2str(k), ' Fbest:  ' , num2str( Fbest)]);
%      disp(['Run # ' , num2str(k), '  GBEST.O: ' , num2str( GBEST.O)]);
%      disp(['Run # ' , num2str(k), ' BestSol.Cost:  ' , num2str( BestSol.Cost)]);
%      disp(['Run # ' , num2str(k), ' BestSolga.Cost :  ' , num2str( BestSolga.Cost)]);
%      disp(['Run # ' , num2str(k), ' BestSolDE.Cost :  ' , num2str( BestSolDE.Cost)]);
%      disp(['Run # ' , num2str(k), ' BestSolACO.Cost:  ' , num2str( BestSolACO.Cost )]);
%      disp(['Run # ' , num2str(k), ' Best_score :  ' , num2str( Best_score)]);
%      disp(['Run # ' , num2str(k), ' TargetFitness :  ' , num2str( TargetFitness)]);
%      disp(['Run # ' , num2str(k), ' Best_scoreSCA :  ' , num2str( Best_scoreSCA)]);
%        disp(['Run # ' , num2str(k), ' Best_scoreGWO :  ' , num2str( Best_scoreGWO)]);
       
%      disp(['Run # ' , num2str(k), ' CFbest :  ' , num2str( CFbest ),' Algorithm_num= ' , num2str(Algorithm_num)]);
% % %  disp(['Average=',num2str( Average),'Standard Deviation=',num2str( StandDP),'Median=',num2str(  Med )]);
% % %  disp(num2str( GBEST.O));

    end

figure
%  subplot(BestSolutions1)
%   boxplot(x,g)
%% Main Boxplot FUNCTION%%
   boxplot([BestSolutions1',BestSolutions2',BestSolutions3',BestSolutions4',BestSolutions5',BestSolutions6',BestSolutions7',BestSolutions8',BestSolutions9',BestSolutions10',BestSolutions11',BestSolutions12'],{'PSOGSA','CPSOGSA','GSA','PSO','BBO','GA','DE','ACO','GWO','SCA','SSA','CGSA'})
%%                      %%
% c = linspace(1,10,length(BestSolutions1));
% scatter(BestSolutions1,BestSolutions2,c)
%     title ('\fontsize{15}\bf Welded Beam Design');
% title ('\fontsize{15}\bf Compression Spring Design');
  title ('\fontsize{15}\bf Pressure Vessel Design');
%   title ('\fontsize{15}\bf Speed Reducer Design');
%  title ('\fontsize{15}\bf Gear Train Design');
% title ('\fontsize{15}\bf Himmelblaus Problem');
% title ('\fontsize{15}\bf Three Bar Truss Design');
% title ('\fontsize{15}\bf  Stepped Cantilever Beam Design');
% title ('\fontsize{15}\bf  Multiple Disc Clutch Brake Design');
% title ('\fontsize{15}\bf   Hydrodynamic Thrust Bearing Design');
 xlabel('\fontsize{15}\bf Algorithm');
 ylabel('\fontsize{15}\bf Best Fitness Value');



% for Algorithm_num=5
%      for i=1:RunNo
% %        
%          if Algorithm_num==1
%           [cg_curve,CLbest1,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%          end
%         if Algorithm_num==2
%           [cg_curve,CLbest2,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==3
%             [cg_curve,CLbest3,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==4
%           [cg_curve,CLbest4,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==5
%          [cg_curve,CLbest5,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==6
%            [cg_curve,CLbest6,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==7
%             [cg_curve,CLbest7,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==8
%           [cg_curve,CLbest8,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==9
%             [cg_curve,CLbest9,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==10
%            [cg_curve,CLbest10,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         if Algorithm_num==11
%            [cg_curve,CLbest11,CBestChart]=CHGSA(Benchmark_Function_ID,N,Max_Iteration,ElitistCheck,min_flag,Rpower,Algorithm_num,chValueInitial);
%         end
%         temp(i,:)=cg_curve;
%         BestSolutions1(i) = cg_curve ;



%     Average= mean(BestSolutions1);
%     StandDP=std(BestSolutions1);
%     Med = median(BestSolutions1); 
%     [BestValueP I] = min(BestSolutions1);
%     [WorstValueP IM]=max(BestSolutions1);
%      title(['\fontsize{12}\bf Benchmark Function: F',num2str(Benchmark_Function_ID)]);
%        disp(['Run # ' , num2str(i), ' cg_curve :  ' , num2str( cg_curve ),' Algorithm_num= ' , num2str(Algorithm_num)]);  
%      end

     disp([ 'Best=',num2str( BestValueP)]);
     disp(['Worst=',num2str(WorstValueP)]);
     disp(['Average=',num2str( Average)]);
     disp([ 'Standard Deviation=',num2str( StandDP)]);
     disp(['Median=',num2str(Med)]);



    figure
   semilogy(1:Max_Iteration,GlobalBestCost,'DisplayName','CPSOGSA', 'Color', 'r','Marker','diamond','LineStyle','-','LineWidth',2,...
       'MarkerEdgeColor','r','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   hold on
    semilogy(1:Max_Iteration,GlobalBestCostPSOGSA,'DisplayName','PSOGSA','Color','y','LineStyle','-');
   semilogy(1:Max_Iteration,BestChart,'DisplayName','GSA','Color','g','Marker','o','LineStyle','-','LineWidth',2,...
        'MarkerEdgeColor','g','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   semilogy(1:Max_Iteration,PcgCurve,'DisplayName','PSO','Color','c','Marker','square','LineStyle','-','LineWidth',2,...
       'MarkerEdgeColor','c','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   semilogy(1:Max_Iteration,BestCost,'DisplayName','BBO','Color','b','Marker','*','LineStyle','-','LineWidth',2,...
       'MarkerEdgeColor','b','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   semilogy(1:Max_Iteration,BestCostga,'DisplayName','GA','Color','m','Marker','<','LineStyle','-','LineWidth',2,...
       'MarkerEdgeColor','m','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   semilogy(1:Max_Iteration,BestCostDE,'DisplayName','DE','Color','y','Marker','+','LineStyle','-','LineWidth',2,...
       'MarkerEdgeColor','y','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
   semilogy(1:Max_Iteration,BestCostACO,'DisplayName','ACO','Color','m','LineStyle','-','LineWidth',2);
     semilogy(1:Max_Iteration,SSA_cg_curve,'DisplayName','SSA','Color','c','LineStyle','-','LineWidth',2);
%      semilogy(1:Max_Iteration,Convergence_curve,'DisplayName','GOA','Color','g','LineStyle','*','LineWidth',2); 
     semilogy(1:Max_Iteration,SCA_cg_curve,'DisplayName','SCA','Color','b','LineStyle','--','LineWidth',2);
     semilogy(1:Max_Iteration,GWO_cg_curve,'DisplayName','GWO','Color','r','LineStyle','--','LineWidth',2);
    semilogy(1:Max_Iteration,CBestChart,'DisplayName','CHGSA','Color','m','LineStyle',':','LineWidth',2);
% % % % % % figure
% %    title(['\fontsize{12}\bf Benchmark Function: F',num2str(Benchmark_Function_ID)]);
%   title ('\fontsize{15}\bf Welded Beam Design');
% title ('\fontsize{15}\bf Compression Spring Design');
  title ('\fontsize{15}\bf Pressure Vessel Design');
% %   title ('\fontsize{15}\bf Speed Reducer Design');
% %  title ('\fontsize{15}\bf Gear Train Design');
% % title ('\fontsize{15}\bf Himmelblaus Problem');
% % title ('\fontsize{15}\bf Three Bar Truss Design');
% % title ('\fontsize{15}\bf  Stepped Cantilever Beam Design');
% % title ('\fontsize{15}\bf  Multiple Disc Clutch Brake Design');
% title ('\fontsize{15}\bf   Hydrodynamic Thrust Bearing Design');
 xlabel('\fontsize{15}\bf Iteration');
 ylabel('\fontsize{15}\bf Fitness(Best-so-far)');
 legend('\fontsize{12}\bf PSOGSA','\fontsize{12}\bf CPSOGSA','\fontsize{12}\bf GSA','\fontsize{12}\bf PSO','\fontsize{12}\bf BBO','\fontsize{12}\bf GA',...
    '\fontsize{12}\bf DE','\fontsize{12}\bf ACO','\fontsize{12}\bf GWO','\fontsize{12}\bf SCA','\fontsize{12}\bf SSA','\fontsize{12}\bf CGSA',1);
% % %   
%     legend('\fontsize{15}\bf SCA');
% %   
  
%  Wilcoxon rank sum test
% disp(' Wilcoxon RankSum Test ')
% 
% [p,h]= signrank(BestSolutions1,BestSolutions2)
p= signrank(BestSolutions9,BestSolutions1)

