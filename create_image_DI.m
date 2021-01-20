% construit une image correspondant a la donnee initiale pour P2
% a partir de la fonction fun_DI
% en utilisant les points extremes definis dans le fichier de positions


load positions % chargement positions arbres (matrice POS_ARB)
m=min(POS_ARB)-20; M=max(POS_ARB)+20;


X=m(1):1:M(1); X=X'; % resolution = 1metre
j=0;
for y=m(2):1:M(2) % resolution = 1metre
    j=j+1;
    Y=y*ones(length(X),1);
    P2ini(j,:)=fun_DI(X,Y);
end
P2ini=flipud(P2ini);
imwrite(P2ini,'P2ini.png','png')