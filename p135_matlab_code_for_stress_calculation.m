function [sigma] = elementStressPlane(xl,nel,ndf,ul,ntype,ee,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the elemnt stress
%---
%
Edof=nel*ndf; % size of element stiffness matrix
uv=zeros(Edof,1);
%
xi=xl(1,1);
xj=xl(1,2);
xk=xl(1,3);
yi=xl(2,1);
yj=xl(2,2);
yk=xl(2,3);
%
uv(1)=ul(1,1);
uv(2)=ul(2,1);
uv(3)=ul(1,2);
uv(4)=ul(2,2);
uv(5)=ul(1,3);
uv(6)=ul(2,3);
%
Area=(xi*(yj-yk)+xj*(yk-yi)+xk*(yi-yj))/2;
%
betai=yj-yk;
betaj=yk-yi;
betam=yi-yj;
gammai=xk-xj;
gammaj=xi-xk;
gammak=xj-xi;

B=[betai 0 betaj 0 betam 0 ; ...
    0 gammai 0 gammaj 0 gammam ; ...
    gammai betai gammaj betaj gammam betam]/(2*Area);
%
[dmat]=dmatPlane(ntype,ee,xnu);
%
thickness=1;

sigma=dmat*B*uv;
%... print the stress
% fid = fopen('stress_output.txt','w');
    fid=1;
    fprintf(fid,'%12.9f %12.9f %12.9f\n',sigma)
% fclose(fid)
end