function [ message ] = DCTretrive( stego,key)
%DCTretireve This function retrives a hidden message from a stego-image that
%was encoded using DCTHide function.
quality=key(1);
indmes=key(2:end);
I = stego;
I1=I;
[row coln]= size(I);
I= double(I);
% Subtracting each image pixel value by 128 
I = I - (128*ones(size(I)));

% Quality Matrix Formulation
Q50 = [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
 
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
        win1=DCT_matrix8*zBLOCK*iDCT_matrix8;
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

% index that can contain part of the message
icoef=find(abs(dct_quantized)>1); % index of available coefficients for message

s=dct_quantized(indmes)+128;
s=dec2bin(s);
m=s(:,8);
k=mod(length(m),8);
    if k~=0
    m=str2num(m);
    m=cat(1,m,zeros(8-k,1));
    m=num2str(m);
    end

m=reshape(m,8,numel(m)/8)';
message=char(bin2dec(m))';

end

