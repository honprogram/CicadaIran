function [y,t,fs]=preprocessing(n,formatSpec,Slen,i)
% Read Audio DATA--------
frm='.wav';
str = sprintf(formatSpec,i,frm)
[x1 fs] =audioread(str);
x=x1(1:Slen)';
xn = normalaize(x,1);
%---- Framing DATA-----------
[y,t]=enframe(xn,hamming(n,'periodic'),n/4);
end