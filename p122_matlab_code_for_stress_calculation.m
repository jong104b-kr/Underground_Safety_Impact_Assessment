function [sigma]=...
    getStressPlane(numberElements,...
        elementNodes,xx,yy,lg,nel,ndf,uk,ntype,E,xnu)

%---
% Sang J. LEE, 2014
% ADOPT  Research Group : www.adopt.kr
% Calculate the stress for all elements
%---

for e=1:numberElements
    indice=elementNodes(e,:); % ndf = 2 u_1 v_1 u_2 v_2, ..., u_4 v_4

%... coordinates of local nodes i,j
    xl=zeros(3,4);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));
    xl(1,4)=xx(indice(4));
    xl(2,1)=yy(indice(1));
    xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3));
    xl(2,4)=yy(indice(4));

%
    ul(1,1)=uk(indice(1),1);
    ul(1,2)=uk(indice(2),1);
    ul(1,3)=uk(indice(3),1);
    ul(1,4)=uk(indice(4),1);
    ul(2,1)=uk(indice(1),2);
    ul(2,2)=uk(indice(2),2);
    ul(2,3)=uk(indice(3),2);
    ul(2,4)=uk(indice(4),2);

%... element stress
    [sigma]=elementStressPlane(lg,xl,nel,ul,ntype,E,xnu);
%
end
end