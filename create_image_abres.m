% construit une image correspondant aux positions des arbres
% a partir des positions et de la fonction fun_alpha
% permet de diviser par 3 les temps de calcul de comsol

load positions
m=min(POS_ARB)-20; M=max(POS_ARB)+20;
i=0;
% for x=m(1):1:M(1)
%     i=i+1;
%     j=0;
%     for y=m(2):1:M(2)
%         j=j+1;
%         ARBRES(j,i)=fun_alpha(x,y);
%     end
% end

X=m(1):1:M(1); X=X'; % resolution = 1metre
j=0;
for y=m(2):1:M(2) % resolution = 1metre
    j=j+1;
    Y=y*ones(length(X),1);
    ARBRES(j,:)=fun_alpha(X,Y);
end
ARBRES=flipud(ARBRES);
imwrite(ARBRES,'arbres.png','png')