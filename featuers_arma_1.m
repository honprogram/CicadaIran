% ANN test for 5 class
close all;clear all;clc
conftotal=zeros(5,5);
acctotal=zeros(5,1);
load 'bobo.mat'
fnumb=13;

%-- C1 => AL------------
for i=1:5
    str = sprintf('data/AL_%d_FR%d.mat',i,fnumb);
    AL=load(str) ;
    a(:,:,i)=AL.featuers';
end
%-- C2 => LO------------
for i=1:5
    str = sprintf('data/LO_%d_FR%d.mat',i,fnumb);
    AL=load(str) ;
    b(:,:,i)=AL.featuers';
end
%-- C3=> SM------------
for i=1:5
    str = sprintf('data/SM_%d_FR%d.mat',i,fnumb);
    AL=load(str) ;
    d(:,:,i)=AL.featuers';
end
%-- C4 => OR------------
for i=1:5
    str = sprintf('data/OR_%d_FR%d.mat',i,fnumb);
    AL=load(str) ;
    c(:,:,i)=AL.featuers';
end
%-- C5 => TE------------
for i=1:5
    str = sprintf('data/TE_%d_FR%d.mat',i,fnumb);
    AL=load(str) ;
    e(:,:,i)=AL.featuers';
end

ntr=5*3*441;% number of train
nqtr=ntr/5;
nte=5*2*441;% number of test
nqte=nte/5;
fs=[1:30 ] % feature select
% kk=a(vv,:,1);
%-----------------------
datatrain=[a(fs,:,1) a(fs,:,2) a(fs,:,3) ...,
    b(fs,:,1) b(fs,:,2) b(fs,:,3) ...,
    c(fs,:,1) c(fs,:,2) c(fs,:,3) ...,
    d(fs,:,1) d(fs,:,2) d(fs,:,3) ...,
    e(fs,:,1) e(fs,:,2) e(fs,:,3) ];
datatest=[a(fs,:,3) a(fs,:,4)  ...,
    b(fs,:,3) b(fs,:,4)  ...,
    c(fs,:,3) c(fs,:,4)  ...,
    d(fs,:,3) d(fs,:,4)  ...,
    e(fs,:,3) e(fs,:,4)  ];

T=[ones(1,nqtr) 2*ones(1,nqtr) ...,
3*ones(1,nqtr) 4*ones(1,nqtr) 5*ones(1,nqtr)];
gend=4;
