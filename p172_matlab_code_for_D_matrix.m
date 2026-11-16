function [dmat] = dmatSolid(ee,xnu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% the D matrix for solid element
%---
    dmat=zeros(6,6);
%... d matrix for solid element
    const ee/((1.0+xnu)*(1.0-2.0*xnu));
    dmat(1,1) = const*(1.0-xnu);
    dmat(1,2) = const*xnu;
    dmat(1,3) = const*xnu;
    dmat(2,1) = const*xnu;
    dmat(2,2) = const*(1.0-xnu);
    dmat(2,3) = const*xnu;
    dmat(3,1) = const*xnu;
    dmat(3,2) = const*xnu;
    dmat(3,3) = const*(1.0-xnu);
    dmat(4,4) = const*(1.0-2.0*xnu)/2.0;
    dmat(5,5) = const*(1.0-2.0*xnu)/2.0;
    dmat(6,6) = const*(1.0-2.0*xnu)/2.0;
end