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
[Y(i,:),fmax(i),Ys]=hfft2(yy);
%rts(i,:) = roots(yy);
eng(i)=sum(abs(y(i,:).^2));
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
end
%----------- smoothing of spectrum
%in the "gausswin(X)", X is -
%  the width of the smoothing window
g = gausswin(45); 
g = g/sum(g);
for i=1:size(y,1)
Y(i,:) = conv(Y(i,:), g, 'same');
fmean(i)=find(Y(i,:)==max(Y(i,:)));
end
g = gausswin(30); 
g = g/sum(g);
fmean= conv(fmean, g, 'same');
%Y1=Y';
% Y1=sum(Y)/size(Y,1);
% Y1mean=find(Y1==max(Y1));
%----------- normalize 
% engn = normalaize(eng,0);
% V=find(engn<0.6);
% zcrn =normalaize(zcr,0);
% fmaxn =normalaize(fmax,0);
% fmeann=normalaize(fmean,0);
%-----------  mean of each feature
% fm=sum(fmaxn)/size(fmaxn,2);
% zm=sum(zcrn)/size(zcrn,2);
% em=sum(engn)/size(engn,2);
% fmn=sum(fmeann)/size(fmeann,2);
%----------- change to mean 
% zcrn(V)=zm;
% fmaxn(V)=fm;
% engn(V)=em;
% fmeann(V)=fmn;
%----- show the signal -----------------
% figure;plot(engn,'*');figure;plot(zcrn,'o');
% figure;plot(fmaxn,'+');
% --prepare the feature Vector----------
featuers=[zcr;eng;fmax]';
form=[formatSpec '%s'];
str = sprintf(form,2,'_FR6','.mat')
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
[Y(i,:),fmax(i),Ys]=hfft2(yy);
%rts(i,:) = roots(yy);
eng(i)=sum(abs(y(i,:).^2));
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
end
%----------- smoothing of spectrum
%in the "gausswin(X)", X is -
%  the width of the smoothing window
g = gausswin(45); 
g = g/sum(g);
for i=1:size(y,1)
Y(i,:) = conv(Y(i,:), g, 'same');
fmean(i)=find(Y(i,:)==max(Y(i,:)));
end
g = gausswin(30); 
g = g/sum(g);
fmean= conv(fmean, g, 'same');
%Y1=Y';
% Y1=sum(Y)/size(Y,1);
% Y1mean=find(Y1==max(Y1));
%----------- normalize 
% engn = normalaize(eng,0);
% V=find(engn<0.6);
% zcrn =normalaize(zcr,0);
% fmaxn =normalaize(fmax,0);
% fmeann=normalaize(fmean,0);
%-----------  mean of each feature
% fm=sum(fmaxn)/size(fmaxn,2);
% zm=sum(zcrn)/size(zcrn,2);
% em=sum(engn)/size(engn,2);
% fmn=sum(fmeann)/size(fmeann,2);
%----------- change to mean 
% zcrn(V)=zm;
% fmaxn(V)=fm;
% engn(V)=em;
% fmeann(V)=fmn;
%----- show the signal -----------------
% figure;plot(engn,'*');figure;plot(zcrn,'o');
% figure;plot(fmaxn,'+');
% --prepare the feature Vector----------
featuers=[zcr;eng;fmax]';
form=[formatSpec '%s'];
str = sprintf(form,2,'_FR6','.mat')
save(str,'featuers');

% figure;plot(1:513,Y1,'*',1:513,Y2,'+');
% figure;plot(1:513,y31,'*',1:513,y32,'+');
% figure;plot(Y2,'+');