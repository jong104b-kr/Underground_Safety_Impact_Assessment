function [dr,xsj] = dxdxiplane(shpl,xl,nel)

%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Jacobi matrix and its inverse
%---

    dx = zeros(2,2);
    for i=1:2 % ndm
        for j=1:2
            dx(i,j) = 0.0;
            for k=1:nel
                dx(i,j) = dx(i,j)+xl(j,k)*shpl(i,k);
            end
        end
    end

%... Jacobi matrix determinant
    xsj = dx(1,1)*dx(2,2)-dx(1,2)*dx(2,1);

%... Jacobi matrix inverse
    dr(1,1) = dx(2,2)/xsj;
    dr(2,2) = dx(1,1)/xsj;
    dr(1,2) = -dx(1,2)/xsj;
    dr(2,1) = -dx(2,1)/xsj;
end