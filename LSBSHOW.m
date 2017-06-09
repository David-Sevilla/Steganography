function [lsb  ] = LSBSHOW( status,guidata)
%LSBSHOW handles visibility of interface elements that are required by LSBSHOW
% status 'on' to show or 'off' to hide


set(handles.path1, 'visible',status);
set(handles.path2, 'visible',status);
set(handles.pushbutton1, 'visible',status);
set(handles.pushbutton2, 'visible',status);
set(handles.pushbutton3, 'visible',status);
set(handles.uibuttongroup1, 'visible',status);
set(handles.axes1, 'visible',status);
set(handles.axes2, 'visible',status);
set(handles.axes3, 'visible',status);

if strcmp(status,'on')
set(handles.StartButton, 'visible','off');
else
set(handles.StartButton, 'visible','on');
end


lsb=['LSB MODE','Status'];

end

