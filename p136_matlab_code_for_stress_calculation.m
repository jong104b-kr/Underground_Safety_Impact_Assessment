function [sigma]=...
    getStressPlane(numberElements,...
        elementNodes,xx,yy,nel,ndf,uk,ntype,E,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the stress for all elements
%---
    for e=1:numberElements;
    indice=elementNodes(e,:); % ndf=2 u_1 v_1 u_2 v_2 ...

%... coordinates of local nodes i,j,k
    xl=zeros(2,3);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));
    xl(2,1)=xx(indice(1));
    xl(2,2)=xx(indice(2));
    xl(2,3)=xx(indice(3));
%... element displacement
    ul(1,1)=uk(indice(1),1);
    ul(1,2)=uk(indice(2),1);
    ul(1,3)=uk(indice(3),1);
    ul(2,1)=uk(indice(1),2);
    ul(2,2)=uk(indice(2),2);
    ul(2,3)=uk(indice(3),2);
%... element stress
    [sigma]=elementStressPlane(xl,nel,ndf,ul,ntype,E,xnu);
%
    end
end