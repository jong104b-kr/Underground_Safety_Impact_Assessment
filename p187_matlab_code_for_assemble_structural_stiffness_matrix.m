function [stiffness] = ...
    formStiffnessSolid(GDof,numberElements,...
    elementNodes,xx,yy,zz,nel,ndf,ee,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Assemble element stiffness matrix into structural stiffness
%---
stiffness=zeros(GDof);

%--- computation of the system stiffness matrix
for e=1:numberElements;
    indice=elementNodes(e,:);   % ndf=3: u_1 v_1 w_1 u_2 v_2 w_2 ...
    elementDof=[indice(1)ndf-2 indice(1)*ndf-1 indice(1)*ndf ...
        indice(2)*ndf-2 indice(2)*ndf-1 indice(2)*ndf ...
        indice(3)*ndf-2 indice(3)*ndf-1 indice(3)*ndf ...
        indice(4)*ndf-2 indice(4)*ndf-1 indice(4)*ndf ...
        indice(5)*ndf-2 indice(5)*ndf-1 indice(5)*ndf ...
        indice(6)*ndf-2 indice(6)*ndf-1 indice(6)*ndf ...
        indice(7)*ndf-2 indice(7)*ndf-1 indice(7)*ndf ...
        indice(8)*ndf-2 indice(8)*ndf-1 indice(8)*ndf];

%... coordinate of local nodes 1-8
    xl=zeros(3,8);
    xl(1,1)=xx(indice(1)); xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3)); xl(1,4)=xx(indice(4));
    xl(1,5)=xx(indice(5)); xl(1,6)=xx(indice(6));
    xl(1,7)=xx(indice(7)); xl(1,8)=xx(indice(8));

    xl(2,1)=yy(indice(1)); xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3)); xl(2,4)=yy(indice(4));
    xl(2,5)=yy(indice(5)); xl(2,6)=yy(indice(6));
    xl(2,7)=yy(indice(7)); xl(2,8)=yy(indice(8));

    xl(3,1)=zz(indice(1)); xl(3,2)=zz(indice(2));
    xl(3,3)=zz(indice(3)); xl(3,4)=zz(indice(4));
    xl(3,5)=zz(indice(5)); xl(3,6)=zz(indice(6));
    xl(3,7)=zz(indice(7)); xl(3,8)=zz(indice(8));

%... element stiffness
    kl=elementStiffnessSolid(xl,nel,ndf,ee,xnu);

%... assemble the structural stiffness
    stiffness(elementDof,elementDof) = ...
        stiffness(elementDof,elementDof)+k1;
end
end