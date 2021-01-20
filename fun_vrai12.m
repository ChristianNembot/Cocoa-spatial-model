function VL=comput_cacao(X)

% fonction qui calcule la log-vraisemblance associee a un jeu de parametres
% X de longueur 22 (Lambda, beta1, beta2, rho, delta, D1, D2, sigma, d1,
% d2) + parametres de la donnee initiale liee a l'ombrage


% Lambda=Theta(1);
% beta1=Theta(2);
% beta2=Theta(3);
% rho=Theta(4);
% delta=Theta(5);
% D1=Theta(6);
% D2=Theta(7);
% sigma=Theta(8);
% d1=Theta(9);
% d2=Theta(10);
% % parametres de la donne initiale exp(alpha1+alpha2*ombre_ini)
% alpha1=Theta(11); 
% alpha2=Theta(12);

% inputs :
% X = vecteur contenant les parametres a estimer

% output VL = -log vraisemblance


% 

Tmax=294;

% coefficient Theta conteannt tous les parametres du modele


Theta(1:12) =X(1:12); 


% lance le programme, calcule la solution
load positions POS_ARB
tic
cacao3
toc
% charge les positions d'observation
load positions POS_OBS 

X1=POS_OBS(:,1)';
Y1=POS_OBS(:,2)';

% charge les observations
I_OBS=importdata('I_OBS.txt');

% calcul de la log-vraisemblance
Inf=mphinterp(model,'I','coord',[X1; Y1],'t',[1:7:294]);
Dyn_I=Inf';
VL = -sum(sum(log(poisspdf(I_OBS,Dyn_I))));

try 
    load resultats_vrais12
    XX(end+1,:)=X;
    VLL(end+1)=VL;
    save resultats_vrais12 XX VLL
catch
    XX(1,:)=X;
    VLL(1)=VL;
    save resultats_vrais12 XX VLL
end

