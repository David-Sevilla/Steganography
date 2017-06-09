function [ stego,key ] = DCThide( I,M,quality )
%DCThide This function embeds a messaged M into an image I with the DCT
%JSTEG process.

message=M;

I1=I;
[row coln]= size(I);
I= double(I);
% Subtracting each image pixel value by 128 
I = I - (128*ones(size(I)));


% Quality Matrix Formulation
Q50 =stdQ;
 
 if quality > 50
     QX = round(Q50.*(ones(8)*((100-quality)/50)));
     QX = uint8(QX);
 elseif quality < 50
     QX = round(Q50.*(ones(8)*(50/quality)));
     QX = uint8(QX);
 elseif quality == 50
     QX = Q50;
 end
 
% Formulation of forward DCT Matrix and inverse DCT matrix
DCT_matrix8 = dctmtx(8);
iDCT_matrix8 = inv(DCT_matrix8);

% Jpeg Compression
dct_restored = zeros(row,coln);
QX = double(QX);

% Jpeg Encoding

% Forward Discret Cosine Transform
for i1=[1:8:row]
    for i2=[1:8:coln]
        zBLOCK=I(i1:i1+7,i2:i2+7);
        win1=dct2(zBLOCK);
        dct_domain(i1:i1+7,i2:i2+7)=win1;
    end
end
% Quantization of the DCT coefficients
for i1=[1:8:row]
    for i2=[1:8:coln]
        win1 = dct_domain(i1:i1+7,i2:i2+7);
        win2=round(win1./QX);
        dct_quantized(i1:i1+7,i2:i2+7)=win2;
    end
end

icoef=find(abs(dct_quantized)>1); % index of available coefficients for message

% validate that the message will fit in the image 
n=numel(icoef);
[hm,wm]=size(message);
message=reshape(message,1,hm*wm);
L = length(message) * 8;  
L=L+8;
 if (L)>n
 stego=[];
 key=[];
 return
 %error('The image is to small, choose a larger image')
 end

% message is converted to bit stream

    Ascii = [uint8(message),0];  %  concatenates the end of message characeter    
    binStr = (dec2bin(Ascii,8));
    binStr = reshape(binStr',1,L);
 
% Quantizatoin index are converted to binary    
indmes =  icoef(1:L); % index that will be changed
modified = dec2bin(dct_quantized(indmes)+128,8);
modified(1:length(binStr),8)=binStr;
modified=bin2dec(modified)-128;

dct_quantized(indmes)=modified;

% Jpeg Decoding 
%  DCT Coefficients Dequantization
for i1=[1:8:row]
    for i2=[1:8:coln]
        win2 = dct_quantized(i1:i1+7,i2:i2+7);
        win3 = win2.*QX;
        dct_dequantized(i1:i1+7,i2:i2+7) = win3;
    end
end
% Inverse DCT
for i1=[1:8:row]
    for i2=[1:8:coln]
        win3 = dct_dequantized(i1:i1+7,i2:i2+7);
        win4=idct2(win3);
        dct_restored(i1:i1+7,i2:i2+7)=win4;
    end
end
I2=dct_restored+128;


stego=uint8(I2);
key=[quality;indmes];
%imwrite(stego,[filename,'.jpg'],'jpg','quality',quality);
 
end

