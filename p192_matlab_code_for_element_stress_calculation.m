function [sig] = elementStressSolid(xl,nel,ul,ee,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stress
%---

%... position of integration point and its weight
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

    for i=1:8
        rg(i)=g*r(i);
        sg(i)=g*s(i);
        tg(i)=g*t(i);
        wg(i)=1.0;
    end

%
    disp('Element')
%... compute element stresses,strains and forces
    for l=1:8
%... compute element shape functions
    [shpl]=shapeSolid(rg(1),sg(1),tg(1));
    [dr,xs]=dxdxiSolid(shpl,xl,nel);
    [shp]=gshape(nel,dr,shpl);
    [dmat]=dmatSolid(ee,xnu);
%... compute strains and coordinates
    for i=1:6
        eps(i)=0.0;
    end

    xx=0.0;
    yy=0.0;
    zz=0.0;
%
    for j=1:nel
        xx=xx+shpl(4,j)*xl(1,j);
        yy=yy+shpl(4,j)*xl(2,j);
        zz=zz+shpl(4,j)*xl(3,j);

        eps(1)=eps(1)+shp(1,j)*ul(1,j);
        eps(2)=eps(2)+shp(2,j)*ul(2,j);
        eps(3)=eps(3)+shp(3,j)*ul(3,j);

        eps(4)=eps(4)+shp(2,j)*ul(1,j)+shp(1,j)*ul(2,j);
        eps(5)=eps(5)+shp(3,j)*ul(2,j)+shp(2,j)*ul(3,j);
        eps(6)=eps(6)+shp(3,j)*ul(1,j)+shp(1,j)*ul(3,j);
    end

%... compute stresses
    sig(1)=dmat(1,1)*eps(1)+dmat(1,2)*eps(2)+dmat(1,3)*eps(3);
    sig(2)=dmat(2,1)*eps(1)+dmat(2,2)*eps(2)+dmat(2,3)*eps(3);
    sig(3)=dmat(3,1)*eps(1)+dmat(3,2)*eps(2)+dmat(3,3)*eps(3);
    
    sig(4)=dmat(3)*eps(4);
    sig(5)=dmat(3)*eps(5);
    sig(6)=dmat(3)*eps(6);

%... output stresses and strains
    fid=1;

% fprintf(fid,'%6.4f %6.4f %6.4f\n',xx,yy,zz)
    fprintf(fid,'%12.9f %12.9f %12.9f %12.9f %12.9f %12.9f\n',eps)
% fprintf(fid,'%6.4f %6.4f %6.4f %6.4f %6.4f\n',sig)
%
end
end
