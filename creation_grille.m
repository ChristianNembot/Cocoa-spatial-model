%Creation d une grille
 
seqy=1:40;
seqx=1:40;

[x y] = meshgrid(seqx,seqy);

grid=[x(:) y(:)];

plot([x y],'o');



x(:,1)% points de la colonne 1
x(:,2)% points de la colonne 2

% différence entre toute les coordonnées x
dx = bsxfun(@minus, grid(:,1), grid(:,1)');
% différence entre toute les coordonnées y
dy = bsxfun(@minus, grid(:,2), grid(:,2)');

%Calcul de distance entre toute les paires de points
dist=sqrt(dx.^2 + dy.^2);

% Calcul de la matrice de covariance SIGMA
 
% Rho=30;
% Sigma=0.5;
% 
% Sig=Sigma^2*exp(-dist/rho);
% 
% %Generation de la variable aléatoire Z
% 
% mu=zeros(1,size(grid,1));
% 
% Z=exp(mvnrnd(mu,Sig));
% 
% %Remplissage de P
% k=0
%  for i=1:1:40;
% for j=1:1:40;
%     k=k+1;
%     P(i,j)= Z(1,k);
% end;
% end;
% 
% surf(P,) 
% view(3); 
% colorbar;
% display(P);
% 
% 
% 
% 
