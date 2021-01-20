%%% importation des donnees

% donnees : fichiers csv avec 2 colonnes (x et y) seprateur ;

POS_ARB=importdata('pos_arbres.csv');
POS_OBS=importdata('pos_obs.csv');

 
save positions POS_ARB POS_OBS 