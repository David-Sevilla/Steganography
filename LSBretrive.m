function [ message ] = LSBretrive( stego )
%LSBRETRIVE This function retrives a hidden message from a stego-image that
%was encoded using LSBHide function


   s = stego;% imread('hiddenmsgimage.bmp');
   
  [h,w] = size(s);
   
 
   
   %%
   s=reshape(s,h*w,1); 
   s=dec2bin(s);
   m=s(:,8);
   
   %%
   k=mod(length(m),8);
    if k~=0
    m=str2num(m);
    m=cat(1,m,zeros(8-k,1));
    m=num2str(m);
    end
    
   m=reshape(m',8,length(m)/8);
   m=m';
   
   i = find(bin2dec(m)==0);  %looks for end of message 
   if isempty(i)
   message=char(bin2dec(m))';
   warning('No Message');
   else
   message=char(bin2dec(m(1:i-1,:)))';
   
   end
end