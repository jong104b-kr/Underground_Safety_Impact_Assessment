function [sig] = elementStressPlane(lg,xl,nel,ul,ntype,ee,xnu)
%---
% Sang J LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stress
%---
%
    r(1)=-1; r(2)=1; r(3)=1; r(4)=-1;
    s(1)=-1; s(2)=-1; s(3)=1; s(4)=1;

%... 2x2 integration
    rg=zeros(4,1);
    sg=zeros(4,1);
%
    sq1=1/sqrt(3);
    sq2=sqrt(0.6);
%
    if lg(3)==2
        g=sq1;
        wg(1)=1.0; wg(2)=1.0; wg(3)=1.0; wg(4)=1.0;
        li=4;
    else
        g=0;
        wg(1)=4.0;
        li=1;
    end
%

    for i=1:li
        rg(1)=g*r(i);
        sg(i)=g*s(i);
    end

%... compute element stresses, strains and forces
    for l=1:li
%.. compute element shape functions
    [shpl]=shapePlane(rg(1),sg(1));
    [dr,xsj]=dxdxiPlane(shpl,xl,nel);
    [shp]=gshape(nel,dr,shpl);
    [dmat]=dmatPlane(ntype,ee,xnu);
%... compute strains and coordinates
    sig(1)=0.0;
    sig(2)=0.0;
    sig(3)=0.0;
    sig(4)=0.0;

    eps(1)=0.0;
    eps(2)=0.0;
    eps(3)=0.0;
    xx=0.0;
    yy=0.0;
%
    for j=1:nel
        xx=xx+shpl(3,j)*xl(1,j);
        yy=yy+shpl(3,j)*xl(2,j);
        eps(1)=eps(1)+shp(1,j)*ul(1,j);
        eps(2)=eps(2)+shp(2,j)*ul(2,j);
        eps(3)=eps(3)+shp(2,j)*ul(1,j)+shp(i,j)*ul(2,j);
    end
%... compute stresses
    sig(1)=dmat(1,1)*eps(1)+dmat(1,2)*eps(2);
    sig(2)=dmat(2,1)*eps(1)+dmat(2,2)*eps(2);
    sig(3)=dmat(3,3)*eps(3);

%... calculate normal stress
    if ntype==1
        sig(4)=0.0;
    else
        sig(4)=xnu*(sig(1)+sig(2));
    end

%--- compute the principal stress
    term1=(sig(1)+sig(2))*0.5;
    term2=(sig(1)-sig(2))*0.5;
    term3=sqrt(term2*term3+sig(3)#sig(3));
    psigm(1)=term1+term3;
    psigm(2)=term1-term3;
    if term2=0.0
        term2=0.1e20;
        term2=0.1e20;
    end

%... unit : degree
    alpha=atan(sig(3)/term2)*28.647889757;
%... print the stress
    fid=1;
    fprintf(fid,'%6.4f %6.4f %12.9f %12.9f %12.9f %12.9f %12.9f %12.9f %12.9f\n',xx,yy,eps,sig)
end