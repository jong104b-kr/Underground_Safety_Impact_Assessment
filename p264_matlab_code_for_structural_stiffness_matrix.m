function [stiffness]=formStiffnessTorsionT3(GDof,numel,...
                elementNodes,xx,yy,zz,nel,ndf,G)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the structural stiffness
%---
%... initialization
stiffness=zeros(GDof);
%... computation of the structural stiffness matrix
numberElements=numel;

for e=1:Elements=numel;
    indice=elementNodes(e,:);   % ndf=2; u_1 v_1 u_2 v_2
    elementDof=[indice(1)*ndf ...
                indice(2)*ndf ...
                indice(3)*ndf];

%... coordinates of local nodes i,j
    xl=zeros(2,3);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));

    xl(2,1)=yy(indice(1));
    xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3));

%... element stiffness
    k1=elementStiffnessTorsionT3(xl,nel,ndf,G);
%... assemble the structural stiffness
    stiffness(elementDof,elementDof)=...
        stiffness(elementDof,elementDof)+k1;
end
end