%**** "Insect Data feature_reduction_4"
% extract ALL feature 
%------
clc;clear all;close all;
p=genpath('D:\My MAtlab\ARMA_onInsect\HOSA');
addpath(p);
load 'bobo.mat'
% select the song----------
for s=1:5
if s==1 formatSpec = 'data/AL_%d%s'; end
if s==2 formatSpec = 'data/LO_%d%s'; end
if s==3 formatSpec = 'data/OR_%d%s'; end
if s==4 formatSpec = 'data/SM_%d%s'; end
if s==5 formatSpec = 'data/TE_%d%s'; end
% ***********PreProcessing
for m=1:5
Slen=100000;n=900;
[y,t,fs]=preprocessing(n,formatSpec,Slen,m);
%-------- feature extraction ------
eng=zeros(1,441);
c=zeros(size(y,1),900);
i=0;
for k=1:size(y,1)
i=i+1;
yy=y(k,:);
[Y(i,:),fmax(i),Ys]=hfft2(yy);
%-------- Cepestrom------------
%c(i,:) = spCepstrum(yy, fs, 'hamming')';
%f0(i) = spPitchCepstrum(c, fs);
%eng(i)=sum(abs(yy.^2));
% ------------LPC----
%lc(:,i)= lpc(yy,5);
%---- -----ZCR
%[t z]=zerocros(yy);
%zcr(i)=size(z,2);
%------------MA-------
bvec(:,i) = maest(yy,14,3,128); 
%------------AR-------
avec(:,i)= arrcest(yy,14,0);
%[ash(:,i),bsh(:,i),err] = shanks(yy,5,5);
end
YY=Y';
%A=avec';
%***************MA and AR  mean
g = gausswin(10); 
g = g/sum(g);
for i=1:size(y,1)
    MA(i,:) = conv(bvec(:,i), g, 'same')';
end
for i=1:size(y,1)
    AR(i,:) = conv(avec(:,i), g, 'same')';
end
% %***************ash and bsh  mean
% for i=1:size(y,1)
%     BSH(i,:) = conv(bsh(:,i), g, 'same')';
% end
% for i=1:size(y,1)
%     ASH(i,:) = conv(ash(:,i), g, 'same')';
% end
% %****************LPC mean
% LP=lc';
% g = gausswin(45); 
% g = g/sum(g);
% for i=1:size(y,1)
% LP(i,:) = conv(LP(i,:), g, 'same');
% end
% %************** Cepestrom------------
% C=sum(c')/size(c',2);
% %----------- smoothing of spectrum
% g = gausswin(45); 
% g = g/sum(g);
% for i=1:size(y,1)
% Y(i,:) = conv(Y(i,:), g, 'same');
% fmean(i)=find(Y(i,:)==max(Y(i,:)));
% end
%------- Prepare Feature-------
featuers=[MA';AR']';
form=[formatSpec '%d%s']; 
fnumb=13;
str = sprintf(form,m,'_FR',fnumb,'.mat')
save(str,'featuers');
end
end
 sound(bobo);

