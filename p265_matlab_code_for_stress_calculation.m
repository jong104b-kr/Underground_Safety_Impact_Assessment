function [sig,TorsionalConst,Torsion]=elementStressTorsionT3(e,xl,nel,ndf,ul,G)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stress
%---
%... calculate the element stress
%
Edof=nel*ndf;   % the size of element stiffness matrix
uv=zeros(Edof,1);
%

xi=xl(1,1); xj=x1(1,2); xk=xl(1,3);
yi=xl(2,1); xj=x1(2,2); xk=xl(2,3);
%
% 생략, 추후 첨언