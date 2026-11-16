function [shp] = gshape(nel,dr,shpl)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Derevatives of shape function in global coordinates
%---
    shp = zeros(3,nel);
    for i=1:nel
        tp = shpl(1,1)*dr(1,1)+shpl(2,i)*dr(1,2);
        shp(2,i) = shpl(1,i)*dr(2,1)*shpl(2,i)*dr(2,2);
        shp(1,i) = tp;
    end
end
