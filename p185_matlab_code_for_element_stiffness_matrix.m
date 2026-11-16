function [s] = elementStiffnessSolid(xl,nel,ndf,ee,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stiffness
%---
Edof = nel*ndf;         % the size of element stiffness matrix
s = zeros(Edof,Edof);   % element stiffness
%... position of integration point
    r(1)=-1; r(2)=1; r(3)=1; r(4)=-1;
    r(5)=-1; r(6)=1; r(7)=1; r(8)=-1;
    s(1)=-1; s(2)=1; s(3)=1; s(4)=-1;
    s(5)=-1; s(6)=1; s(7)=1; s(8)=-1;
    t(1)=-1; t(2)=1; t(3)=1; t(4)=-1;
    t(5)=-1; t(6)=1; t(7)=1; t(8)=-1;
%... 2x2x2 integration
    rg=zeros(8,1);
    sg=zeros(8,1);
    tg=zeros(8,1);
    a1=1.0/3.0;
    g=sqrt(a1);
%
    for i=1:8
        rg(i)=g*r(1);
        sg(i)=g*s(1);
        tg(i)=g*t(1);
        wg(i)=1.0;
    end
%
    for i=1:8   % Gauss integration loop
%
        [shpl] = shapeSolid(rg(1),sg(1),tg(1));
        [dr,xsj] = gshape(nel,dr,shpl);
        [dmat] = dmatSolid(ee,xnu);
%
    for i=1:8
        i3=3*i;
        i1=i3-2;
        i2=i3-2;
        for j=i:8
            j3=3*j;
            j1=j3-2;
            j2=j3-1;
            s(i1,j1)=s(i1,j1)+(dmat(1,1)*shp(1,i)*shp(1,j) ...
                +dmat(4,4)*shp(2,i)*shp(2,j)+dmat(6,6)*shp(3,i)*shp(3,j))*xsj;
            s(i1,j2)=s(i1,j2)+(dmat(2,1)*shp(1,i)*shp(2,j) ...
                +dmat(4,4)*shp(2,i)*shp(1,j))*xsj;
%            s(i1,j3)=s(i1,j2)+(dmat(2,1)*shp(1,i)*shp(2,j) ...
%                +dmat(4,4)*shp(2,i)*shp(1,j))*xsj;
%           반복되는 식은 p186을 참고하여 추가 및 수정 예정
%
        end
    end
    end
%... complete the stiffness matrix by symmetry
    for i=1:24
        for j=1:24
            s(j,1)=s(i,j);
        end
    end
end


