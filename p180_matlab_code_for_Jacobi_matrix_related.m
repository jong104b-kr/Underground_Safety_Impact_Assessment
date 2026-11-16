function [dr,xsj] = dxxiSolid(shpl,xl,nel)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Jacobi matrix and its inverse
%---
%... construction of jacobian and inverse
    dx = zeros(3,3);
    for i=1:3
        for j=1:3
            for k=1:nel
                dx(i,j)=dx(i,j)+xl(i,k)+shpl(j,k);
            end
        end
    end
%... Jacobian determinant
    xsj = dx(1,1)*(dx(2,2)*dx(3,3)-dx(2,3)*dx(3,2)) ...
        - dx(1,2)*(dx(2,1)*dx(3,3)-dx(2,3)*dx(3,1)) ...
        + dx(1,3)*(dx(2,1)*dx(3,2)-dx(2,2)*dx(3,1));

%... Jacobian inverse
    dr(1,1) = (dx(2,2)*dx(3,3)-dx(2,3)*dx(3,2))/xsj;
    dr(2,1) = -(dx(2,1)*dx(3,3)-dx(2,3)*dx(3,1))/xsj;
    dr(3,1) = (dx(2,1)*dx(3,2)-dx(2,2)*dx(3,1))/xsj;
    
    dr(1,2) = -(dx(1,2)*dx(3,3)-dx(1,3)*dx(3,2))/xsj;
    dr(2,2) = (dx(1,1)*dx(3,3)-dx(1,3)*dx(3,1))/xsj;
    dr(3,2) = -(dx(1,1)*dx(3,2)-dx(1,2)*dx(3,1))/xsj;

    dr(1,3) = (dx(1,2)*dx(2,3)-dx(1,3)*dx(2,2))/xsj;
    dr(2,3) = -(dx(1,1)*dx(2,3)-dx(1,3)*dx(2,1))/xsj;
    dr(3,3) = (dx(1,1)*dx(2,2)-dx(1,2)*dx(2,1))/xsj;
end