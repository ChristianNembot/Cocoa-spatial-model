%%% calcul du maximum de vraisemblance par methode deterministe fmincon

clear all
close all

%%%% initialisation du random %%%%
rand('state',sum(100*clock));
randn('state',sum(100*clock));

%%%% bornes pour les parametres  (Lambda, beta1, beta2, rho, delta, D1, D2, sigma, d1, d2, alpha1, alpha2)

bl=[0.5 1e-5 1e-5 0.0005 0.0005 0.01 0.01 0.005 0.005 0.005 -10 -10]; % lower bound
bm=[3 9e-4 9e-4 0.3 0.2 0.1 0.3 2.5 0.5 0.2 10 10]; % upper bound



%[1.52385402582444 1.07923487235092e-05 0.000516662451579860 0.148489045688792 0.100469744065928 0.0507721710765813 0.151871333641343 1.56619882751735 0.285066327160450 0.0860700190443494]

%%% intial guess
%load('theta10_opt','X0'); % charge X0 optimise avec un P20 fixe

for k=1:15
try
        X0=bl+rand(1,12).*(bm-bl);
        options = optimset('Display','iter');
        [xopt , fopt , exitflag] = fmincon('fun_vrai12',[X0],[],[],[],[],[bl],[bm],[],options);
        nom=['result_estim_12_' num2str(k)];
        save(nom,'xopt','fopt','exitflag');
end
end