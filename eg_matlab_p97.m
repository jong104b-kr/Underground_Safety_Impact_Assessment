function [dmat] = dmatPlane(ntype,E,nu)
%---
% Sang J. LEE, 2014
% ADOPT Research Group : www.adapt.kr
% the rigidity D matrix 
%---
%---
% 목적 : 요소 절점에서 사용하는 강성(강성 행렬, D matrix) 계산
% 평면응력(plane stress) 또는 평면변형률(plane strain) 조건 선택
% 입력 :
% ntype : 조건구분 (1=평면응력, 그외=평면변형률)
% E : 탄성계수(Young's modulus) [Pa]
% nu : 포아송비(Poisson's ratio)
% 출력 :
% dmat : 3x3 강성행렬, σ = dmat * E 관계를 만족함

 mat = zeros(3,3);
%
 if ntype==1
%... D matrix for plane stress case
    % -- 평면응력(plane stress) 조건 --
    % 면내 응력-변형률 관계:
    % σx = E/(1-v^2) * (εx + v*εy), σy = E/(1-v^2) * (v*εx + εy)
    % τxy = G*γxy, G = E/(2*(1+v))
    % 즉, D = E/(1-v^2) * [1 v 0; v 1 0; 0 0 (1-v)/2]
    const = E/(1.0-nu*nu);          % 공통계수 E/(1-v^2)
    dmat(1,1) = const;              % D11: σx와 εx의 관계
    dmat(2,2) = const;              % D22: σy와 εy의 관계
    dmat(1,2) = const*nu;           % D12: σx와 εy(횡방향) 결합 
    dmat(2,1) = const*nu;           % D21: 대칭성(D12=D21) 
    dmat(3,3) = const*(1.0-nu)/2;   % D33: 전단항, G=E/(2(1+v))와 동일
 else
%... D matrix for plane strain case
    % -- 평면변형률(plane strain) 조건 --
    % 체적변형률(εz)과 전단변형률(γxz, γyz)이 0인 조건:
    % σz = v(σx + σy)로 구속됨
    % D = E(1-v)/((1+v)(1-2v))*[1 v/(1-v) 0; v/(1-v) 1 0; 0 0 (1-2v)/(2(1-v))]
    const = E*(1.0-nu)/((1.0+nu)*(1.0-2.0*nu));     % 공통계수
    dmat(1,1) = const;                              % D11
    dmat(2,2) = const;                              % D22
    dmat(1,2) = const*nu/(1.0-nu);                  % D12 = v/(1-v)배, 평면응력보다 커짐
    dmat(2,1) = dmat(1,2);                          % 대칭성(D12=D21)
    dmat(3,3) = const*(1.0-2.0*nu)/(2.0*(1.0-nu));  % D33 = E/(2/(1+v)) = G
 end
end

% 요약하자면,
% ntype == 1: 평면응력 - 두께방향 응력*전단응력이 0으로 가정. const=E/(1-v^2)
% 그외(ntype~=1): 평면변형률 - 두께방향 변형률이 0으로 가정. const=E(1-v)/((1+v)(1-2v))
% dmat(3,3)은 두 경우 모두 전단 탄성계수 G=E/(2(1+v))와 같다는 공통점이 있다.
% dmat(1,2)와 dmat(2,1)은 항상 대칭으로 설정된다.
% 이 코드는 FEM(유한요소법)에서 등방성 재료의 평면 응력/변형률 구성방정식에 사용되는 전형적인 강성행렬이다.