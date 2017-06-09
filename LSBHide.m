function [ stego ] = LSBHide( I,M )
%LSBHIDE This function embeds a messaged M into an image I with the LSB
%process.

 c = I;% imread('cameraman.tif');
% c=im2double(c);
 [h,w]=size(c);
 %secret Messege is asigned
 message = M;% 'This is a secret, do not tell anyone';
 
 [hm,wm]=size(message);
 message=reshape(message,1,hm*wm);
% validate that the message will fit in the image 
 m = length(message) * 8;  
 if m>(h*w)
 stego=[];
 return;
 %error('The image is to small, choose a larger image')
 end
    
 %convert the secret message into bit stream (of lenthg m)
    
    Ascii = [uint8(message),0];  %  concatenates the end of message characeter
    
    binStr = (dec2bin(Ascii,8));
    binStr = reshape(binStr',1,m+8);
    
    b=binStr;
   % b=str2num(binStr);
    
    L=length(b); % Size of message
    
    %compute image size
    h = size(c,1);
    w = size(c,2);
    s=dec2bin(c,8);
    m=length(s);
    %
    % add message
    s(1:L,8)=b;
    %%
    %recontruct stegoimage
    s=bin2dec(s);
    s=reshape(s,h,w);
   %%
    s=uint8(s); 
     %%
    stego=s;
end

