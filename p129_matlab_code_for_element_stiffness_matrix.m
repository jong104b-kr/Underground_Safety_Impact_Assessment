function [s] = elementStiffnessPlane(xl,nel,ndf,ee,xnu,th,ntype)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stiffness
%---
Edof=nel*ndf; % the size of element stiffness matrix

s=zeros(Edof,Edof); % element stiffness
%
xi=xl(1,1);
xj=x1(1,2);
xk=xl(1,3);
yi=xl(2,1);
yj=xl(2,2);
yk=xl(2,3);
%
Area=(xi*(yj-yk)+xj*(yk-yi)+xk*(yi-yk))/2;
%
betai = yj-yk;
betaj = yk-yi;
betam = yi-yj;
gammai = xk-xj;
gammaj = xi-xk;
gammam = xj-xi;
B = [betai 0 betaj 0 betam 0; ...
        0 gammai gammaj gammam ; ...
    gammai betai gammaj betaj gammam betam ]/(2*Area);
%
[dmat] = dmatPlane(ntype,ee,xnu);
%
thickness=th;
s=thickness*Area*B'*dmat*B;
end