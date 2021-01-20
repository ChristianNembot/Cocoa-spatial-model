
% inputs :
% Theta = vecteur contenant les parametres
% tt = vecteur p ex tt=0:0.1:10, temps auxquels les observations sont effectuees
% Pobs= positions des observation : vecteur 2 lignes x N colonnes (N=nombre d'observations)
% prise en compte d'une donnee initiale liee a l'ombrage (image ombre_ini, cree avec creta_pini)

% faire cd D:\Comsol50\Cacao dans la fenetre matlab associee a Comsol

%%% chargement positions arbres

load positions

m=min(POS_ARB)-20; M=max(POS_ARB)+20;

%%% prise en compte des parametres

Lambda=Theta(1);
beta1=Theta(2);
beta2=Theta(3);
rho=Theta(4);
delta=Theta(5);
D1=Theta(6);
D2=Theta(7);
sigma=Theta(8);
d1=Theta(9);
d2=Theta(10);

% parametres de la donne initiale exp(alpha1+alpha2*ombre_ini)
alpha1=Theta(11); 
alpha2=Theta(12);

%%% chargement modele


import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Lionel\Desktop\Cacao');

model.label('cacao2.mph');

model.modelNode.create('comp1');


%%% creation fonction matlab externe

model.func.create('extm1', 'MATLAB');
model.func('extm1').label('dens_arbres');
model.func('extm1').set('funcs', {'fun_alpha' 'x,y'});
model.func('extm1').set('plotargs', {'0' '100'; '0' '100'});

%%% import de l'image correspondant a la position des arbres

model.func.create('im1', 'Image');
model.func('im1').label('Image_arbres');
model.func('im1').set('ymin', num2str(m(2)));
model.func('im1').set('ymax', num2str(M(2)));
model.func('im1').set('xmin', num2str(m(1)));
model.func('im1').set('xmax', num2str(M(1)));
model.func('im1').set('filename', 'D:\Comsol50\Cacao\arbres.png');
model.func('im1').set('funcname', 'im_arbres');

%%% import de l'image correspondant a la donnee initiale

model.func.create('im2', 'Image');
model.func('im2').label('Image_DI');
model.func('im2').set('ymin', num2str(m(2)));
model.func('im2').set('ymax', num2str(M(2)));
model.func('im2').set('xmin', num2str(m(1)));
model.func('im2').set('xmax', num2str(M(1)));
model.func('im2').set('filename', 'D:\Comsol50\Cacao\ombre_ini.png');
model.func('im2').set('funcname', 'im_DI');


%%% creation geometrie (rectangle avec 20 de marge autour des arbres extremes)


model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1'); % maillage

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {num2str(M(1)-m(1)) num2str(M(2)-m(2))}); % dimensions
model.geom('geom1').feature('r1').set('pos', {num2str(m(1)) num2str(m(2))}); % angle sud ouest
model.geom('geom1').run;

model.mesh('mesh1').create('ftri1', 'FreeTri');

model.mesh('mesh1').feature('size').set('hauto', 1); % maillage 2 = extra fine, 1=extremely fine
model.mesh('mesh1').run; % maillage


%%% valeurs des coefficients

model.variable.create('var1');
model.variable('var1').set('Lambda', num2str(Lambda));
model.variable('var1').set('beta1', num2str(beta1));
model.variable('var1').set('beta2',num2str(beta2));
model.variable('var1').set('rho', num2str(rho));
model.variable('var1').set('delta', num2str(delta));
model.variable('var1').set('D1', num2str(D1));
model.variable('var1').set('D2', num2str(D2));
model.variable('var1').set('sigma', num2str(sigma));
model.variable('var1').set('d1',num2str(d1) );
model.variable('var1').set('d2', num2str(d2));
model.variable('var1').set('alpha1',num2str(alpha1) );
model.variable('var1').set('alpha2', num2str(alpha2));


model.physics.create('c', 'CoefficientFormPDE', 'geom1');
model.physics('c').field('dimensionless').component({'S' 'I' 'P1' 'P2'});
model.physics('c').create('dir1', 'DirichletBoundary', 1);
model.physics('c').feature('dir1').selection.all;


%%% equations

model.physics('c').feature('cfeq1').set('c', {'1' '0' '0' '1'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '1' '0' '0' '1'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0';  ...
'D1' '0' '0' 'D1'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; 'D2' '0' '0' 'D2'}); % legere diffusion sur I et S pour des raisons numeriques
model.physics('c').feature('cfeq1').set('f', {'Lambda*(t<110)*im_arbres(x,y)-(beta1*P1+beta2*P2)*S-rho*S'; '(beta1*P1+beta2*P2)*S-delta*I'; 'sigma*I-d1*P1'; 'd1*P1-d2*P2'});
model.physics('c').feature('init1').set('P2', 'exp(alpha1+alpha2*im_DI(x,y))');
model.physics('c').feature('dir1').set('useDirichletCondition', {'1'; '1'; '1'; '0'});



model.study.create('std1');
model.study('std1').create('time', 'Transient');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature.remove('fcDef');

model.study('std1').feature('time').set('initstudyhide', 'on');
model.study('std1').feature('time').set('initsolhide', 'on');
model.study('std1').feature('time').set('solnumhide', 'on');
model.study('std1').feature('time').set('notstudyhide', 'on');
model.study('std1').feature('time').set('notsolhide', 'on');
model.study('std1').feature('time').set('notsolnumhide', 'on');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('descr', 'Dependent variable ***');
model.result('pg1').feature('surf1').set('expr', 'I');

model.study('std1').feature('time').set('tlist', ['range(0,0.1,' num2str(Tmax) ')' ]);

model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tlist', ['range(0,0.1,' num2str(Tmax) ')' ]); 
model.sol('sol1').runAll; % calcul de la solution

%model.result('pg1').set('looplevel', {'11'});

%%% dessin


