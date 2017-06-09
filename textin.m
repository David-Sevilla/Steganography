function [file, p,filename] = textin(path)
%TEXTIN Read text in from current-working or specified directory. 
%   I = TEXTIN displays a window containing all the files in the current
%   directory and saves in I the image selected from the current directory.
%   %   [ ...] = TEXTIN('PATH') is used when the file to be read resides in a
%   specified directory. For example, the input argument
%   'C:\MY_WORK\MY_FILES' opens a window showing the contents of directory
%   MY_FILES. A file selected from that directory is read in as text file.


if nargin < 1;
    path=cd; 
end

wd=pwd;
cd(path);

imageType={'*.*';'*.txt';'*m'};

[filename, pathname, filterindex]=uigetfile(imageType, 'images');

cd(pathname);
p=pwd;
fileID = fopen(filename);
t=fread(fileID);
file=char(t)';
fclose(fileID);
cd(wd);
end