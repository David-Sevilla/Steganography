function varargout = StegoGUI(varargin)
% STEGOGUI MATLAB code for StegoGUI.fig
%      STEGOGUI, by itself, creates a new STEGOGUI or raises the existing
%      singleton*.
%
%      H = STEGOGUI returns the handle to a new STEGOGUI or the handle to
%      the existing singleton*.
%
%      STEGOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGOGUI.M with the given input arguments.
%
%      STEGOGUI('Property','Value',...) creates a new STEGOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StegoGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StegoGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StegoGUI

% Last Modified by GUIDE v2.5 07-Dec-2015 17:54:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StegoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @StegoGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before StegoGUI is made visible.
function StegoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StegoGUI (see VARARGIN)

% Choose default command line output for StegoGUI
handles.output = hObject;




%initilaize path
set(handles.path1, 'string','CoverFile');
set(handles.path2, 'string','SecretFile');
set(handles.StegoName, 'string','StegoImageName');
set(handles.path3, 'string','StegoImageFile');
set(handles.path5, 'string','SecretFileName');

axes(handles.axes1)
handles.f=imread('selectImage.png');
handles.im1=imshow(handles.f);
set(handles.textIn,'String','Select Secret Messege')

axes(handles.axes2)
handles.g=imread('SelectMessage.png');
handles.im2=imshow(handles.g);
axes(handles.axes4)
imshow(handles.f);
% 
% axes(handles.axes3)
% handles.stego=imread('StegoImage.png');
% handles.im3=imshow(handles.f);

handles.cover=0;
handles.message=0;
handles.ready=0;
handles.hidden=0;
handles.key=0;

handles.secret=[];
handles.k=[];
handles.stego=[];

handles.method='LSB';
handles.key=[];

% set(handles.StartButton, 'visible','on');
% set(handles.path1, 'visible','off');
% set(handles.path2, 'visible','off');
% set(handles.pushbutton1, 'visible','off');
% set(handles.pushbutton2, 'visible','off');
% set(handles.pushbutton3, 'visible','off');
% set(handles.uibuttongroup1, 'visible','off');
% set(handles.axes1, 'visible','off');
 set(handles.axes2, 'visible','off');
 set(handles.axes3, 'visible','off');
  set(handles.axes5, 'visible','off');
% set(handles.textIn,'visible','off');
% set(handles.im1,'visible','off');
% set(handles.im2,'visible','off');

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes StegoGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StegoGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



path=get(handles.path1,'string');
[handles.f,m,p,filename]=imagein();
[~,~,dim]=size(handles.f);
if dim==3
    handles.f=rgb2gray(handles.f);
end

set(handles.path1,'string',filename)
axes(handles.axes1)
imshow(handles.f)

handles.cover=1;


guidata(hObject, handles)


function path1_Callback(hObject, eventdata, handles)
% hObject    handle to path1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path1 as text
%        str2double(get(hObject,'String')) returns contents of path1 as a double


% --- Executes during object creation, after setting all properties.
function path1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

path=get(handles.path2,'string');
if get(handles.radioImage,'value')
    [handles.g,m,p,filename]=imagein();
    set(handles.textIn,'visible','off');
    handles.g=handles.g+1;
    [m,n]=size(handles.g);
    if m==n
    set(handles.path2,'string',filename)
    %set(handles.axes2,'visible','on')
    axes(handles.axes2)
    imshow(handles.g,[])
    handles.message=1;

    else
        errordlg('You should use a square image');
        handles.message=0;

    end
end

if get(handles.radioText,'value')
    [handles.g,p,filename]=textin();
     set(handles.path2,'string',filename)
%     set(handles.axes2,'visible','off')
     set(handles.textIn,'visible','on')
     set(handles.textIn,'String',handles.g);
     handles.message=1;

end

guidata(hObject, handles)


function path2_Callback(hObject, eventdata, handles)
% hObject    handle to path2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path2 as text
%        str2double(get(hObject,'String')) returns contents of path2 as a double


% --- Executes during object creation, after setting all properties.
function path2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if (handles.cover && handles.message)
    handles.ready=1;
    
    axes(handles.axes3)
    if strcmp(handles.method,'LSB')
        handles.stego=LSBHide(handles.f,handles.g);
        handles.key=[];
    end
    if strcmp(handles.method,'DCT')
        [handles.stego,handles.key]=DCThide(handles.f,handles.g,75);
    end
    if isempty(handles.stego)
        uiwait(errordlg('The cover image is too small for your secret message'));
    else
    imshow(handles.stego)
    uiwait(msgbox(' Stego-Image Creation Completed'))
    end

else
    uiwait(errordlg('Please load an image a secret message'));
end
    

guidata(hObject, handles)



% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

choice = questdlg('Would you like to hide or extract a secret?', ...
	'Select Action', ...
	'Hide','Extract','No thank you');
% Handle response

if strcmp(choice,'Hide')
    disp(choice)
else
    disp(choice)
end

status='on';

set(handles.path1, 'visible',status);
set(handles.path2, 'visible',status);
set(handles.pushbutton1, 'visible',status);
set(handles.pushbutton2, 'visible',status);
set(handles.pushbutton3, 'visible',status);
set(handles.uibuttongroup1, 'visible',status);
set(handles.axes1, 'visible',status);
set(handles.axes2, 'visible',status);
set(handles.axes3, 'visible',status);

set(handles.StartButton, 'visible','on');
set(handles.StartPanel, 'visible','off');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.method = questdlg('What steganography method would you like to use?', ...
	'Select Method', ...
	'LSB','DCT','LSB');
% Handle response
if strcmp(handles.method,'LSB')
    disp(handles.method)
    status='on';
%     set(handles.path1, 'visible',status);
%     set(handles.path2, 'visible',status);
%     set(handles.pushbutton1, 'visible',status);
%     set(handles.pushbutton2, 'visible',status);
%     set(handles.pushbutton3, 'visible',status);
%     set(handles.uibuttongroup1, 'visible',status);
     
    set(handles.methodText,'String', 'LSB')
    %set(handles.axes1, 'visible',status);
    %set(handles.axes3, 'visible',status);
   
    
end
if strcmp(handles.method,'DCT')
    disp(handles.method)
    set(handles.methodText,'String', 'DCT - JSTEG')
    disp('select method')
    handles.method
end

guidata(hObject, handles);



% --- Executes on button press in radioText.
function radioText_Callback(hObject, eventdata, handles)
% hObject    handle to radioText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioText

set(handles.textIn,'visible','on')
set(handles.textIn,'visible','on')


%file = textread('loremipsum.m', '%c', 'delimiter', '\n', 'whitespace','')'



function StegoName_Callback(hObject, eventdata, handles)
% hObject    handle to StegoName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StegoName as text
%        str2double(get(hObject,'String')) returns contents of StegoName as a double


% --- Executes during object creation, after setting all properties.
function StegoName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StegoName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in imageOut.
function imageOut_Callback(hObject, eventdata, handles)
% hObject    handle to imageOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.ready
    disp('saving..')
    handles.method
    filename=get(handles.StegoName,'String')
    handles.method
    if strcmp(handles.method,'LSB')
        newname=[filename,'_LSB_.bmp'];
        imwrite(handles.stego,newname)
        msgbox(['The stego-image has been saved as', newname],'Image Saved')
    end
    if strcmp(handles.method,'DCT')
        newname=[filename,'_DCT_.jpg'];
        imwrite(handles.stego,newname,'jpg','quality',75);
        
        fid=fopen([filename,'_DCT_.key'],'w');
        fwrite(fid,handles.key,'double');
        fclose(fid);
        msgbox(['The stego-image has been saved as', newname, ' with key: ', newname,'.key'],'Image Saved')
    end
    
end


% --- Executes on button press in radioImage.
function radioImage_Callback(hObject, eventdata, handles)
% hObject    handle to radioImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.textIn,'visible','off')
set(handles.textOut,'visible','off')


% Hint: get(hObject,'Value') returns toggle state of radioImage


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.s,m,p,filename]=imagein();
set(handles.path3,'string',filename)
axes(handles.axes4)

if strcmp(handles.method,'LSB')
imshow(handles.s)
end

if strcmp(handles.method,'DCT')
    i=find(filename=='.');
    cw=pwd;
    cd(p);
    key=[filename(1:i-1),'.key']
    fid=fopen(key);
   
    if fid~=-1
        handles.k=fread(fid,'double');
        fclose(fid);
        cd(cw);
        imshow(handles.s);
    else
        errordlg('The key file associatied with this image was not found');
    end

end
handles.hidden=1;



guidata(hObject, handles)


function path3_Callback(hObject, eventdata, handles)
% hObject    handle to path3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path3 as text
%        str2double(get(hObject,'String')) returns contents of path3 as a double


% --- Executes during object creation, after setting all properties.
function path3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    name=get(handles.path5,'String');

if get(handles.radioText,'value')
    name=[name,'.txt'];
    fid=fopen(name,'w');
    fwrite(fid,handles.secret);
    fclose(fid);
    msgbox(['The hidden messge has been saved as ',name]);
    
end

if get(handles.radioImage,'value')
    
    imwrite(handles.secret,[name,'.bmp'])
    msgbox(['The hidden image has been saved as ',name]);
end

function path5_Callback(hObject, eventdata, handles)
% hObject    handle to path5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path5 as text
%        str2double(get(hObject,'String')) returns contents of path5 as a double


% --- Executes during object creation, after setting all properties.
function path5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.hidden==1
    if strcmp(handles.method,'LSB')
        msgbox('Extracting Messge...')
        m=LSBretrive(handles.s);
        if get(handles.radioText,'Value')
            handles.secret=m;
            set(handles.textOut,'visible','on')
            set(handles.textOut,'String',handles.secret)
        end
        if get(handles.radioImage,'Value')
             msgbox('Extracting Image...')
            len=length(m)
            m=reshape(m,sqrt(len),sqrt(len));
            handles.secret=uint8(m);
            set(handles.textOut,'visible','off')
            axes(handles.axes5)
            imshow(handles.secret,[])
        end
            
    end
    
    if strcmp(handles.method,'DCT')
        m = DCTretrive( handles.s,handles.k);
        handles.secret=m;
        set(handles.textOut,'visible','on')
        set(handles.textOut,'String',handles.secret);
    end
else
    errordlg('Please Load a Stego-Image')
end

guidata(hObject, handles)
