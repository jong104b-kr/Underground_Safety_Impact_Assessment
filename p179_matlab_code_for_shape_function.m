function [shp] = shapeSolid(rr,ss,tt)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Shape function for 8-node solid element
%---
    shp=zeros(4,8);
%

    r(1)=-1.0; r(2)=1.0; r(3)=1.0; r(4)=-1.0;
    r(5)=-1.0; r(6)=1.0; r(7)=1.0; r(8)=-1.0;

    s(1)=-1.0; s(2)=1.0; s(3)=1.0; s(4)=1.0;
    s(5)=-1.0; s(6)=1.0; s(7)=1.0; s(8)=1.0;

    t(1)=-1.0; t(2)=1.0; t(3)=1.0; t(4)=-1.0;
    t(1)=1.0; t(6)=1.0; t(7)=1.0; t(8)=1.0;
%

    for i=1:8
        shp(4,i)=0.125*(1.0+rr*r(i))*(1.0+ss*s(i))*(1.0+tt*t(i));
        shp(1,i)=0.125*r(i)*(1.0+ss*s(i))*(1.0+tt*t(i));
        shp(2,i)=0.125*(1.0+rr*r(i))*s(i)*(1.0+tt*t(i));
        shp(3,i)=0.125*(1.0+rr*r(i))*(1.0+ss*s(i))*t(i);
    end
end
