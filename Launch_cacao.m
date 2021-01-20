% A lancer avant d'executer les simus (annee 2006)

clear all

%%% chargement fichiers modeles

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\Comsol50\Cacao');

model.label('cacao2.mph');

model.modelNode.create('comp1');

%%% creation fonction matlab externe decrivant la densite d'arbres

model.func.create('extm1', 'MATLAB');
model.func('extm1').label('dens_arbres');
model.func('extm1').set('funcs', {'fun_alpha' 'x,y'});
model.func('extm1').set('plotargs', {'0' '100'; '0' '100'});

%%% creation geometrie (rectangle avec 20 de marge autour des arbres extremes)

load positions2006

m=min(POS2006)-20; M=max(POS2006)+20;

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1'); % maillage

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {num2str(M(1)-m(1)) num2str(M(2)-m(2))}); % dimensions
model.geom('geom1').feature('r1').set('pos', {num2str(m(1)) num2str(m(2))}); % angle sud ouest
model.geom('geom1').run;

model.mesh('mesh1').create('ftri1', 'FreeTri');

model.mesh('mesh1').feature('size').set('hauto', 3); % maillage
model.mesh('mesh1').run; % maillage

%%% physique (equations)


model.physics.create('c', 'CoefficientFormPDE', 'geom1');
model.physics('c').field('dimensionless').component({'S' 'I' 'P1' 'P2'});
model.physics('c').create('dir1', 'DirichletBoundary', 1);
model.physics('c').feature('dir1').selection.all;

model.physics('c').feature('cfeq1').set('c', {'1' '0' '0' '1'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0';  ...
'D1' '0' '0' 'D1'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; '0' '0' '0' '0'; 'D2' '0' '0' 'D2'}); % legere diffusion sur S pour des raisons numeriques
model.physics('c').feature('cfeq1').set('f', {'Lambda*fun_alpha(x,y)-(beta1*P1+beta2*P2)*S-rho*S'; '(beta1*P1+beta2*P2)*S-delta*I'; 'sigma*I-d1*P1'; 'd1*P1-d2*P2'});
model.physics('c').feature('init1').set('P2', 'P2_0');
model.physics('c').feature('dir1').set('useDirichletCondition', {'1'; '1'; '1'; '0'});


%%% creation etude 


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


