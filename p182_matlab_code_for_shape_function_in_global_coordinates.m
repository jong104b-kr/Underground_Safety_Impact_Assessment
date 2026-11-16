function [shp] = gshape(nel,dr,shpl)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% evaluate the derivatives of shape function in global doordinate
%---

%... dn/dx = dn/dr * dr/dx
    shp=zeros(1,3);
%
    for i=1:nel
        tp1 = shpl(1,i)*dr(1,1)+shpl(2,i)*dr(2,1)+shpl(3,i)*dr(3,1);
        tp2 = shpl(1,i)*dr(1,2)+shpl(2,i)*dr(2,2)+shpl(3,i)*dr(3,2);
        shp(3,i) = shpl(1,i)*dr(1,3)+shpl(2,i)*dr(2,3)+shpl(3,i)*dr(3,3);
        
        shp(1,i) = tp1;
        shp(2,i) = tp2;
    end
end