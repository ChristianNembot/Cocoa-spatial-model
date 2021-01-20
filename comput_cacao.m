function IOUT=comput_cacao(X,P2ini)

% inputs :
% X = vecteur contenant les parametres a estimer
% P2_0 = matrice dont les dimensions sont donnees par taille_mat_P2_0
% P2_0 definit la donnee initiale pour P2
% outputs :
% IOUT = nombre d'infectes aux points/dates d'observation

imwrite(P2ini,'P2ini.png','png')

Theta=X; 
% Theta rassemble tous les parametres du modele
% mais le vecteur X peut etre de dimension inferieure a Theta, si certaines composantes de Theta sont connues

load positions POS_OBS % charge les positions d'observation
ns=42; % nombre de semaines d'observation
temps_OBS=7:7:ns*7;
%POS_OBS=[10 20 100; 30 50 0]; % exemple de deux points d'observations (10,30) et (20,50)


Tmax=temps_OBS(end);
cacao2 % lance le programme, calcule la solution


%%% extraction solution aux points d'observation

IOUT=max(mphinterp(model,'I','coord',POS_OBS','t',temps_OBS),0);

%%% dessin
% 
% for td=0:0.1:Tmax
%     pd=mpheval(model,{'I'},'t',td,'Smooth','everywhere','Refine',10);
%     mphplot(pd,'mesh','off','Rangenum',1)
%     pause(0.1)
% end