function [stiffness]=...
    formStiffnessTetra(GDof,numberElements,...
        elementNodes,xx,yy,zz,nel,ndf,E,NU)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Assemble element stiffness matrix into structural stiffness
%---
stiffness=zeros(GDof);
for e=1:numberElements;
    indice=elementNodes(e,:);   % ndf=3 u_1 v_1 w_1 u_2 v_2 w_2 ...
        elementDof=[indice(1)*ndf-2 indice(1)*ndf-1 indice(1)*ndf ...
                   indice(2)*ndf-2 indice(2)*ndf-1 indice(2)*ndf ...
                   indice(3)*ndf-2 indice(3)*ndf-1 indice(3)*ndf ...
                   indice(4)*ndf-2 indice(4)*ndf-1 indice(4)*ndf];

%... coordinates of local nodes i,j,k,l
    xl=zeros(3,4);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));
    xl(1,4)=xx(indice(4));

    xl(2,1)=yy(indice(1));
    xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3));
    xl(2,4)=yy(indice(4));

    xl(3,1)=zz(indice(1));
    xl(3,2)=zz(indice(2));
    xl(3,3)=zz(indice(3));
    xl(3,4)=zz(indice(4));

%... element stiffness
    k1=elementStiffnessTetra(xl,nel,ndf,E,NU);
%... assemble the structural stiffness
    stiffness(elementDof,elementDof)=...
        stiffness(elementDof,elementDof)+k1;
end
end