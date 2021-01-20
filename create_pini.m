%%% construction d'une image pini pour cacao3 %%%

clear all

%%% on se base sur la position des arbres
load positions
m=min(POS_ARB)-20; M=max(POS_ARB)+20; 

% bornes du domaine
xmin=m(1); xmax=M(1); dx=abs(xmax-xmin)/200;
ymin=m(2); ymax=M(2); 

% maillage
[XX,YY]=meshgrid(xmin:dx:xmax,ymin:dx:ymax);

% charge positions et ombrage associes

load ombrage 

% interpolation
W=griddata(X,Y,OMB,XX,YY,'nearest');

% normalisation entre 0 et 1
W=W/max(max(W));
% suppression des valeurs < min(OMB)
%W=W+(W<min(OMB))*mean(OMB);


close all
pcolor(XX,YY,W)
shading flat


% creation image
W=flipud(W);
imwrite(W,'ombre_ini.png','png')