function [s] = elementStiffnessTetra(xl,nel,ndf,E,NU)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stiffness
%---
    Edof=nel*ndf;       % the size of element stiffness matrix
    s=zeros(Edof,Edof); % initialize element stiffness matrix
%...B matrix
    [B,V]=elementBmatrixTetra(xl);
%...D matrix
    D=elementDmatrixTetra(E,NU);
%...element stiffness matric
    s=V*B'*D*B;
end