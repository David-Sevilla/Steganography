f=imread('Landscape.png');
f=rgb2gray(f);
loremipsum
[stego,key]=DCThide(f,t,75);
%%
fid=fopen('testkey.key','w');
fwrite(fid,key,'double');
fclose(fid);
%%

fid=fopen('testkey.key');
k=fread(fid,'double')
fclose(fid);
