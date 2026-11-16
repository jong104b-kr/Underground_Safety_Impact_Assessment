function [stiffness]=...
    formStiffnessPlane(GDof,numberElements,...
        elementNodes,xx,yy,nel,ndf,Elas,xnu,th,ntype)

%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr

% Assemble element stiffness matrix into structural stiffness
%---
%... initialization
stiffness=zeros(GDof);

%... computation of the structural stiffness matrix
for e=1:numberElements;
    indice=elementNodes(e,:); % ndf=2; u_1 v_1 u_2 v_2 u_3 v_3
    elementDof=[indice(1)*ndf-1 indice(1)*ndf ...
        indice(2)*ndf-1 indice(2)*ndf ...
        indice(3)*ndf-1 indice(3)*ndf ...
        indice(4)*ndf-1 indice(4)*ndf];

        %... coordinates of local nodes i,j,k
    xl=zeros(2,3);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));
    xl(2,1)=yy(indice(1));
    xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3));

    %... element stiffness
    kl=elementStiffnessPlane(lg,xl,nel,ndf,Elas,xnu,th,ntype);

%... assemble the structural stiffness
    stiffness(elementDof,elementDof)=...
        stiffness(elementDof,elementDof)+kl;
end
end