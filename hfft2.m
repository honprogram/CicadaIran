% Hfft ver1.2

%T = 1/Fs; % Sample time
%t = (0:L-1)*T;                % Time vector
% plot(Fs*t(1:50),y(1,1:50))
% title('Signal ')
% xlabel('time (milliseconds)')
% plot(f,) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')
function [Y,fmax,Ys]=hfft(y)
L = size(y,2);  % Length of signal
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Ys = fft(y(1,:),NFFT)/L;
Y=2*abs(Ys(1:NFFT/2+1));
%f = Fs/2*linspace(0,1,NFFT/2+1);
fmax=find(Y==max(Y));
end
