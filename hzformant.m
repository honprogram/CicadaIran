function form=  hzformant(rts,Fs)
form=zeros(1,3);
rts = rts(imag(rts)>=0);
angz = atan2(imag(rts),real(rts));
[frqs,indices] = sort(angz.*(Fs/(2*pi)));
bw = -1/2*(Fs/(2*pi))*log(abs(rts(indices)));
nn = 1;
for kk = 1:length(frqs)
    if (frqs(kk) > 90 && bw(kk) <400)
        formants(nn) = frqs(kk)
        nn = nn+1;
    end
end
if nn==3
   formants(3)=formants(2)+(formants(2)-formants(1));
   form=formants(1:3);
   %form=[formants 0];
else
   formants(3)=formants(2)+(formants(2)-formants(1));
   form=formants(1:3);
   
end
end