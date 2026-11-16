function [sigma] = getStressSolid(numberElements, ...
    elementNodes,xx,yy,zz,nel,uk,ee,xnu)

%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Calculate the stress for all elements
%---

for e=1:numberElements;
    indice=elementNodes(e,:);       % ndf<=3 u_1 v_1 w_1 u_2 v_2 w_2 ...

%... coordinates of local nodes i,j
    xl=zeros(3,8);
    xl(1,1)=xx(indice(1));
    xl(1,2)=xx(indice(2));
    xl(1,3)=xx(indice(3));
    xl(1,4)=xx(indice(4));
    xl(1,5)=xx(indice(5));
    xl(1,6)=xx(indice(6));
    xl(1,7)=xx(indice(7));
    xl(1,8)=xx(indice(8));

    xl(2,1)=yy(indice(1));
    xl(2,2)=yy(indice(2));
    xl(2,3)=yy(indice(3));
    xl(2,4)=yy(indice(4));
    xl(2,5)=yy(indice(5));
    xl(2,6)=yy(indice(6));
    xl(2,7)=yy(indice(7));
    xl(2,8)=yy(indice(8));

    xl(3,1)=zz(indice(1));
    xl(3,2)=zz(indice(2));
    xl(3,3)=zz(indice(3));
    xl(3,4)=zz(indice(4));
    xl(3,5)=zz(indice(5));
    xl(3,6)=zz(indice(6));
    xl(3,7)=zz(indice(7));
    xl(3,8)=zz(indice(8));
%
    u1(1,1)=uk(indice(1),1);
    u1(1,2)=uk(indice(2),1);
    u1(1,3)=uk(indice(3),1);
    u1(1,4)=uk(indice(4),1);
    u1(1,5)=uk(indice(5),1);
    u1(1,6)=uk(indice(6),1);
    u1(1,7)=uk(indice(7),1);
    u1(1,8)=uk(indice(8),1);

    u1(2,1)=uk(indice(1),2);
    u1(2,2)=uk(indice(2),2);
    u1(2,3)=uk(indice(3),2);
    u1(2,4)=uk(indice(4),2);
    u1(2,5)=uk(indice(5),2);
    u1(2,6)=uk(indice(6),2);
    u1(2,7)=uk(indice(7),2);
    u1(2,8)=uk(indice(8),2);

    u1(3,1)=uk(indice(1),3);
    u1(3,2)=uk(indice(2),3);
    u1(3,3)=uk(indice(3),3);
    u1(3,4)=uk(indice(4),3);
    u1(3,5)=uk(indice(5),3);
    u1(3,6)=uk(indice(6),3);
    u1(3,7)=uk(indice(7),3);
    u1(3,8)=uk(indice(8),3);

%... element stress
    [sigma]=elementStressSolid(xl,nel,ul,ee,xnu);
end
end