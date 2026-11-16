function [k]=elementStiffnessTorsion(lg,xl,nel,ndf)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stiffness
%---
Edof=nel*ndf;       % the size of element stiffness matrix
k=zeros(Edof,Edof); % element stiffness
%... position of integration point and its weight
    r(1)=-1; r(2)=1; r(3)=1; r(4)=-1;
    s(1)=-1; s(2)=1; s(3)=1; s(4)=-1;