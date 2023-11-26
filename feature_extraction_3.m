%**** "Insect Data feature_reduction_1"
clc;clear all;close all;
p=genpath('D:\My MAtlab\ARMA_onInsect\HOSA');
addpath(p);
load 'bobo.mat'

% ***********PreProcessing
formatSpec = 'data/LO_%d%s';
Slen=100000;n=900;
[y,t,fs]=preprocessing(n,formatSpec,Slen,2);
%-------- feature extraction ------
eng=zeros(1,441);
c=zeros(size(y,1),900);
i=0;
for k=1:size(y,1)
i=i+1;
yy=y(k,:);
[Y(i,:),fmax(i),Ys]=hfft2(yy);
%-------- Cepestrom------------
c(i,:) = spCepstrum(y(i,:), fs, 'hamming')';
f0(i) = spPitchCepstrum(c, fs);
eng(i)=sum(abs(y(i,:).^2));
% ------------LPC----
lc(:,i)= lpc(y(i,:),2);
%---- ZCR
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
% ARMA
%[avec(:,i),bvec(:,i)] = armaqs(yy,6,4);
% bvec(:,i)= maorder (yy, 0, 6); 
%bvec(:,i) = maest(yy,7,3,128); 
%p3 = arorder(yy,3);
bvec(:,i)= arrcest(yy,3,0);
%bb= maest(yy,7,3,128); 
end
YY=Y';
%A=avec';
%ARMA mean
g = gausswin(10); 
g = g/sum(g);
for i=1:size(y,1)
MA(i,:) = conv(bvec(:,i), g, 'same')';
end
% for i=1:size(y,1)
% AR(i,:) = conv(avec(:,i), g, 'same')';
% end
%LPC mean
LP=lc';
g = gausswin(45); 
g = g/sum(g);
for i=1:size(y,1)
LP(i,:) = conv(LP(i,:), g, 'same');
end
%-------- Cepestrom------------
C=sum(c')/size(c',2);
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
%featuers=[LP';f0;C]';
% featuers=[LP']';
featuers=[MA']';
form=[formatSpec '%s'];
str = sprintf(form,2,'_FR8','.mat')
save(str,'featuers');
% sound(bobo);
%_______________ Signal 2
% ***********PreProcessing
formatSpec = 'data/AL_%d%s';
Slen=100000;n=900;
[y,t,fs]=preprocessing(n,formatSpec,Slen,2);
%-------- feature extraction ------
eng=zeros(1,441);
c=zeros(size(y,1),900);
i=0;
for k=1:size(y,1)
i=i+1;
yy=y(k,:);
[Y(i,:),fmax(i),Ys]=hfft2(yy);
%-------- Cepestrom------------
c(i,:) = spCepstrum(y(i,:), fs, 'hamming')';
f0(i) = spPitchCepstrum(c, fs);
eng(i)=sum(abs(y(i,:).^2));
% ------------LPC----
lc(:,i)= lpc(y(i,:),2);
%---- ZCR
[t z]=zerocros(y(i,:));
zcr(i)=size(z,2);
% ARMA
%[avec(:,i),bvec(:,i)] = armaqs(yy,4,6);
%bvec(:,i) = maest(yy,7,3,128); 
bvec(:,i)= arrcest(yy,3,0);
end
YY=Y';
%A=avec';
%ARMA mean
g = gausswin(10); 
g = g/sum(g);
for i=1:size(y,1)
MA(i,:) = conv(bvec(:,i), g, 'same')';
end
% for i=1:size(y,1)
% AR(i,:) = conv(avec(:,i), g, 'same')';
% end
%LPC mean
LP=lc';
g = gausswin(45); 
g = g/sum(g);
for i=1:size(y,1)
LP(i,:) = conv(LP(i,:), g, 'same');
end
%-------- Cepestrom------------
C=sum(c')/size(c',2);
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
%featuers=[LP';f0;C]';
%featuers=[LP']';
featuers=[MA']';
form=[formatSpec '%s'];
str = sprintf(form,2,'_FR8','.mat')
save(str,'featuers');
% sound(bobo);

% figure;plot(1:513,Y1,'*',1:513,Y2,'+');
% figure;plot(1:513,y31,'*',1:513,y32,'+');
% figure;plot(Y2,'+');