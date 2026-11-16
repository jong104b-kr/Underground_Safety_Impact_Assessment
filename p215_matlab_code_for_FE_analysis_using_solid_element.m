%---
% MATLAB codes for Finite Element Analysis
% Static analysis using solid element
% Sang J. LEE, 2014
% Gyeongsang National University(GNU)
%---
clear memory
clear all
disp('---')
disp('FE Analysis using')
disp('ADOPT Research Group: lee@gnu.ac.kr')
disp('Department of Architectural Engineering')
disp('GNU')
disp('---')
disp('begin the job')
%% Read control data
disp('0. Read control data (0.txt)')
cont=load('0.txt');
numnp=cont(1,1);
numel=cont(1,2);
