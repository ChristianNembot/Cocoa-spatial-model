# Cocoa-spatial-model
Simulation and estimation code comsol with matlab
%begin by importing data 

I_OBS=importdata('I_OBS.txt'); %import data

load positions POS_OBS  % load plot data

load ombrage  % load shade data

create_pini  % create plot

Theta=[0.665496614104672 0.000899776815518633 0.000389092332641240 0.127442978874677 0.0144708900795188 0.0365595419404198 0.218591188432422 0.251249946522700 0.00738531785698255 0.166678899790779 5.18283697865132 1.84846538753983];% parameter vector sample

Tmax=294; 

cacao3 % PDE system solving



