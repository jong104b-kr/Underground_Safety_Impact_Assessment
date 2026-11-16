function [shp] = shapePlane(rr,ss)

%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Shape function for 4-node plane element
%---

 shp=zeros(3,4);
 r(1)=-1; r(2)=1; r(3)=1; r(4)=-1;
 s(1)=-1; s(2)=-1; s(3)=1; s(4)=1;
%

 for i=1:4
    term1=(1+r(i)*rr)/2.0;
    temr2=(1+s(i)*ss)/2.0;
    shp(3,i)=term1*term2;
    shp(1,i)=term2*(r(i)/2.0);
    shp(2,i)=term1*(s(i)/2.0);
 end
end