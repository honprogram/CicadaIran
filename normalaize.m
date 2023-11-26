function y = normalaize(x,type)

     mx=max(x);
     mi=min(x);
     if (length(mx)>1)  
         mmx=mx(1);
     else 
         mmx=mx;
     end
     if (length(mi)>1)  
         mmi=mi(1);
     else 
         mmi=mi;
     end
     y=(x-mmi)/(mmx-mmi);
if type==1
     y=y-mean(y);
end

end