function [sig]=elementStressTetra(xl,nel,ndf,ul,E,NU)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stress
%---
    Edof=nel*ndf;       % the size of element stiffness matrix
    uv=zeros(Edof,1);
%
    uv(1)=ul(1,1);
    uv(2)=ul(2,1);
    uv(3)=ul(3,1);
    uv(4)=ul(1,2);
    uv(5)=ul(2,2);
    uv(6)=ul(3,2);
    uv(7)=ul(1,3);
    uv(8)=ul(2,3);
    uv(9)=ul(3,3);
    uv(10)=ul(1,4);
    uv(11)=ul(2,4);
    uv(12)=ul(3,4);
%... B matrix for tetrahedron 3D element
    [B,V]=elementBmatrixTetra(xl);
%... D matrix for tetrahedron 3D element
    D=elementDmatrixTetra(E,NU);
%... tetrahedron 3D element stress
    sig=D*B*uv;
%... output stresses and strains
% fid=1;
% disp('Gauss point')
% fprintf(fid,'%6.4f %6.4f %6.4f %6.4f\n',xx,yy,zz)
% fprintf(fid,'%6.4f %6.4f %6.4f %6.4f\n',sig)
% fprintf(fid,'%12.9f %12.9f %12.9f %12.9f %12.9f %12.9f\n',eps)
end