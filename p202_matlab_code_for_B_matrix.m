function [B,V]=elementBmatrixTetra(xl)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate B matrix
%---
%... initialize the B matrix
B=zeros(6,12);
%
x1=xl(1,1);
x2=xl(1,2);
x3=xl(1,3);
x4=xl(1,4);
%
y1=xl(2,1);
y2=xl(2,2);
y3=xl(2,3);
y4=xl(2,4);
%
z1=xl(3,1);
z2=xl(3,2);
z3=xl(3,3);
z4=xl(3,4);
%
xyz=[1 x1 y1 z1; ...
    1 x2 y2 z2; ...
    1 x3 y3 z3; ...
    1 x4 y4 z4];
%
V=det(xyz)/6;

method=1;
if method==1
    beta1=[1 y2 z2; 1 y3 z3; 1 y4 z4];
    beta2=[1 y1 z1; 1 y3 z3; 1 y4 z4];
    beta1=[1 y1 z1; 1 y2 z2; 1 y4 z4];
    beta1=[1 y1 z1; 1 y2 z2; 1 y3 z3];
    %
    gamma1=[1 y2 z2; 1 y3 z3; 1 y4 z4];
    gamma2=[1 y1 z1; 1 y3 z3; 1 y4 z4];
    gamma1=[1 y1 z1; 1 y2 z2; 1 y4 z4];
    gamma1=[1 y1 z1; 1 y2 z2; 1 y3 z3];
    

