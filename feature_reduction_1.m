%**** "Insect Data feature_reduction_1"
clc;clear all;close all;
p=genpath('D:\My MAtlab\Arma_model\HOSA');
addpath(p);
load 'bobo.mat'

% ***********PreProcessing
formatSpec = 'data/LO_%d%s';
Slen=100000;n=900;
[y,t,fs]=preprocessing(n,formatSpec,Slen,2);
%-------- feature extraction ------
eng=zeros(1,441);
i=0;
for k=1:size(y,1)
i=i+1;
yy=y(k,:);
[Y,fmax(i),Ys]=hfft2(yy);
%rts(i,:) = roots(yy);
eng(i)=sum(abs(y(i,:).^2));
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
end
engn = normalaize(eng,0);
V=find(engn<0.6);
zcrn =normalaize(zcr,0);
fmaxn =normalaize(fmax,0);

fm=sum(fmaxn)/size(fmaxn,2);
zm=sum(zcrn)/size(zcrn,2);
em=sum(engn)/size(engn,2);

zcrn(V)=zm;
fmaxn(V)=fm;
engn(V)=em;

featuers=[zcrn;engn;fmaxn]';
figure;plot(engn,'*');
figure;plot(zcrn,'o');
figure;plot(fmaxn,'+');

form=[formatSpec '%s'];
str = sprintf(form,2,'_FR1','.mat')
save(str,'featuers');
% sound(bobo);


%_______________ Signal 2
% ***********PreProcessing
formatSpec = 'data/AL_%d%s';
Slen=100000;n=900;
[y,t,fs]=preprocessing(n,formatSpec,Slen,2);
%-------- feature extraction ------
eng=zeros(1,441);
i=0;
for k=1:size(y,1)
i=i+1;
yy=y(k,:);
[Y,fmax(i),Ys]=hfft2(yy);
%rts(i,:) = roots(yy);
eng(i)=sum(abs(y(i,:).^2));
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
end
engn = normalaize(eng,0);
V=find(engn<0.6);
zcrn =normalaize(zcr,0);
fmaxn =normalaize(fmax,0);

fm=sum(fmaxn)/size(fmaxn,2);
zm=sum(zcrn)/size(zcrn,2);
em=sum(engn)/size(engn,2);

zcrn(V)=zm;
fmaxn(V)=fm;
engn(V)=em;

featuers=[zcrn;engn;fmaxn]';
figure;plot(engn,'*');
figure;plot(zcrn,'o');
figure;plot(fmaxn,'+');

form=[formatSpec '%s'];
str = sprintf(form,2,'_FR1','.mat')
save(str,'featuers');
% sound(bobo);