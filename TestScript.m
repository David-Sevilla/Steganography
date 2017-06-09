f=imread('cameraman.tif');

I=checkerboard(12)*255;
I=uint8(I)+1;
imshow(I)
[h,w]=size(I);
M=reshape(I,1,h*w);

s=LSBHide(f,M);

m=LSBretrive(s);

len=length(m);

m=reshape(m,sqrt(len),sqrt(len));
m=uint8(m);

imshow(m)

%%

a=[ones(8), ones(8)*2; ones(8)*3, ones(8)*4; ones(8)*5, ones(8)*6]
[x,y]=size(a)


m=[];
for i=1:8:(x)
   m=[m,a(i:i+7,:)]
end


