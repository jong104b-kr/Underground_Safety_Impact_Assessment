%---
% MATLAB codes for Finite Element Analysis
% Static analysis using triangular plane stress/strain element
% Sang J. LEE, 2014
% ADOPT Research Group : www.adopt.kr
% Gyeongsang National University (GNU)
%---

clear memory
clear all

disp('-----')
disp('FE Analysis using triangular plane stress/strain element')
disp('ADOPT Research Group: lee@gnu.ac.kr')
disp('Department of Architectural Engineering')
disp('Gyeongsang National University')
disp('-----')
disp('begin the job')

%% Read control data
disp('0. Read control data (0.txt)')
cont=load('0.txt');
numnp=cont(1,1);    % number of nodes
numel=cont(1,2);    % number of elements
nboun=cont(1,3);    % number of essential boundary condition
nbounf=cont(1,4);   % number of natural boundary condition
ndf=cont(1,5);      % number of degree of freedom
nel=cont(1,6);      % number of node per element

numberElements=numel;
ntype=1; % =1: plane stress, =2: plane strain

%% Read material properties
disp('1. Read material properties (1.txt)')
Pro=load('1.txt');
E=Pro(1);       % E : Modulus of shear
xnu=Pro(2);     % xnu : Poisson ratio
th=Pro(3);      % th : Thickness

%% Rigidity parameter
%d(1) = E*(1.0-xnu)/(1.0+xnu)/(1.0-2.0*xnu);
%d(2) = xnu*d(1)/(1.0-xnu);
%d(3) = E/2.0/(1.0+xnu);

%---
r=[-1,1];
lg(1)=2;        % No. of integration point for plane stiffness term
lg(2)=1;        % No. of integration point for shear stiffness term
lg(3)=2;        % No. of integration point for stress evaluation

%% Nodal coordinates
disp('2. Read nodal coordinates (2.txt)')
coor=load('2.txt');
nodeCoordinates=coor;
x=nodeCoordinates
%pause

%% Element connectivities
disp('3. Read element connectivities (3.txt)')
elem=load('3.txt');
elementNodes=elem
%pause

%% Essential boundary conditions
disp('4. Read boundary conditions (4.txt)')
boun=load('4.txt');
pointer1=0;

for j=1:nboun
    for k=1:ndf
        pointer1=pointer1+1;
        pprescribedDef(ppointer1,1)=boun(j,1)*ndf-(ndf-k);
    end
end

prescribedDof=pprescribedDof
%pause

%% (empty)
numberNodes=size(nodeCoordinates,1);
xx=nodeCoordinates(:,1);
yy=nodeCoordinates(:,2);
GDof=ndf*numberNodes;       % GDof : global number of degrees of freedom
U=zeros(GDof,1);            % U : global displacement vector
force=zeros(GDof,1);        % force : global force vector
%pause

%% Natural boundary conditions
disp('5. Read natural boundary conditions (5.txt)')
bounf=load('5.txt');
pointer1=0;

for j=1:nbounf
    for k=1:ndf
        pointer1=pointer1+1;
        ipp=bounf(j,1)*ndf-(ndf-k);
        force(ipp)=bounf(j,k+1);
    end
end

% force
disp('all input data finished')
% pause
%

%% Stiffness and mass matrix
[stiffness] = ...
    formStiffnessPlane(GDof,numberElement,...
    elementNodes,xx,yy,nel,ndf,E,xnu,th,ntype);
disp('stiffness matrix calculated')
%pause

%% Static problem
activeDof=setdiff([1:GDof],[prescribedDof]);
stiffness(activeDof,activeDof);
force(activeDof);

U=stiffness(activeDof,activeDof)\force(activeDof);

displacements=zeros(GDof,1);
displacements(activeDof)=U;
disp('nodal displacement')
%pause

%% Nodal displacements in ascending order
uk=zeros(numnp,ndf);
for j=1:numnp
    for k=1:ndf
        pointer2=(j-1)*ndf+k;
        uk(j,k)=displacements(pointer2);
    end
end
% fprintf(1,'%6i %6.4f %6.4f\n',j,uk(j,k))
end
uk
disp('nodal displacement in ascending order')
%pause

%% Stress
[sigma] = ...
    getStressPlane(numberElements,...
        elementNodes,xx,yy,nel,ndf,uk,ntype,e,xnu);
disp('finish the stress calculation')
%pause

%% Drawing the FE Mesh and Deformation
figure
mag=1000000;
    axis('equal');
    grid('off');
drawPlane(numberElements,elementNodes,xx,yy,uk,mag)
%%
disp('finish the job')