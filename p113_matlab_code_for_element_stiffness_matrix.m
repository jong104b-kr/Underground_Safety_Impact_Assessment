function [s] = elementStiffnessPlane(lg,xl,nel,ndf,ee,xnu)
%---
% Sang J. LEE 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the element stiffness
%---
Edof = nel*ndf; % size of element stiffness matrix
s = zeros(Edof,Edof); % initialize element matrix
%---

%... calculate the stiffness matrix
% for reduced integration
% if lg(2) = 2 choose 2x2 gauss point
% if lg(2) >=< 1 choose 1x1 gauss point
%---

%... position of integration point its weight
    lr(1)=-1; lr(2)=1; lr(3)=1; lr(4)=-1;
    ls(1)=-1; ls(2)=-1; ls(3)=1; ls(4)=1;

%... 2x2 integration
    rg = zeros(4,1);
    sg = zeros(4,1);

%... location of Gauss integration point
    sq1 = 1/sqrt(3);
    sq2 = sqrt(0.6);

%... Gauss integration points for plane stiffness matrix
    if lg(1) == 2
        g = sq1;
        wg(1)=1; wg(2)=1; wg(3)=1; wg(4)=1;
        li = 4;
    else
        g = 0;
        wg(1)=4.0;
        li=1;
    end
%

    for i=1:li
        rg(i)=g*lr(i);
        sg(i)=g*ls(i);
    end

%
%... plane stiffness term
%

    ntype=1;
    for l=1:li
        [shpl]=shapePlane(rg(1),sg(1));
        [dr,xsj]=dxdxiPlane(shpl,xl,nel);
        [shp]=gshape(nel,dr,shpl);
        [dmat]=dmatPlane(ntype,ee,xnu);

%... calculate K = B^t D B
        jj=1;

        for j=1:nel
            dv=xsj*wg(1);
            q11=dmat(1,1)*shp(1,j)*dv;
            q12=dmat(1,2)*shp(2,j)*dv;
            q21=dmat(2,1)*shp(1,j)*dv;
            q22=dmat(2,2)*shp(2,j)*dv;
            ii=1;

            for i=i:j
                s(ii,jj)=s(ii,jj)+shp(1,i)*q11;
                s(ii,jj+1)=s(ii,jj+1)+shp(1,i)*q12;
                s(ii+1,jj)=s(ii+1,jj)+shp(2,1)*q21;
                ss(ii+1,jj+1)=s(ii+1,jj+1)+shp(2,i)*q22;
                li=li+ndf;
            end
        end

%... Gauss integration points for shear stiffness matrix
    if lg(2)==2
        g=sq1;
        wg(1)=1; wg(2)=1; wg(3)=1; wg(4)=1;
        li=4;
    else
        g=0;
        wg(1)=4.0;
        li=1;
    end
%
    for i=1:li
        rg(i)=g*lr(1);
        sg(i)=g*ls(1);
    end
%... shear stiffness term
    for l=1:li
        [shpl] = shapePlane(rg(1),sg(1));
        [dr,xsj] = dxdxiplane(shpl,xl,nel);
        [shp] = gshpae(nel,dr,shpl);
        [dmat] = dmatPlane(ntype,ee,xnu);

%... calculate k = B^t D B
    jj=1;
    for j=1:nel
        dv=xsj*wg(1);
        q31=dmat(3,3)*shp(2,j)*dv;
        q32=dmat(3,3)*shp(1,j)*dv;
        ii=1;
        for i=1:j
            s(ii,jj)=s(ii,jj)+shp(2,i)*q31;
            s(ii,jj+1)=s(ii,jj+1)+shp(2,i)*q32;
            s(ii+1,jj)=s(ii+1,jj)+shp(1,i)*q31;
            s(ii+1,jj+1)=s(ii+1,jj+1)+shp(1,i)*q32;
            ii=ii+ndf;
        end
        jj=jj+ndf;
    end
end

%... complete all the stiffness components by symmetry
    for i=1:8
        for j=i:8
            s(j,i)=s(i,j)
        end
    end
end