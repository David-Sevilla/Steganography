function [I, MAP, p,filename] = imagein(path)
%IMAGEIN Read image in from current-working or specified directory. 
%   I = IMAGEIN displays a window containing all the files in the current
%   directory and saves in I the image selected from the current directory.
%   [I, MAP] = IMAGEIN variable MAP is required to be an output argument
%   when image being read is an indexed image. 
%   [ ...] = IMAGEIN('PATH') is used when the image to be read resides in a
%   specified directory. For example, the input argument
%   'C:\MY_WORK\MY_IMAGES' opens a window showing the contents of directory
%   MY_IMAGES. An Image selected from that directory is read in as image I.


if nargin < 1;
    path=cd; 
end

wd=pwd;
cd(path);

imageType={'*.*';'*.tif';'*tiff';'*.jpg';'*.jpeg';'*.gif';'*.bmp';'*.png';'*.xwd'};

[filename, pathname, filterindex]=uigetfile(imageType, 'images');

cd(pathname);
p=pwd;
[I, MAP] = imread(filename);

cd(wd);
end