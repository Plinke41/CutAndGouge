function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Jun-2018 09:10:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
 
% _________________________________________________________________________
% testing inputs

% setappdata(0,'reference','0.mkv')
 setappdata(0,'origin',[0, 0])
 setappdata(0,'scale', 1)  
 setappdata(0,'savefile', 'savefile.xlsx') 
 setappdata(0,'i', 1)
 setappdata(0,'linenumber', 0)
      
end

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in origin.
function origin_Callback(hObject, eventdata, handles)
% hObject    handle to origin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = getappdata(0, 'ref_filename')  ;
pathname = getappdata(0, 'ref_pathname')  ;
scale = getappdata(0, 'scale') ; 
    
% open file
videoFileReader = vision.VideoFileReader(strcat(pathname,filename));
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
objectFrame = videoFileReader();

[origin, objectFrame] = EigFeat(objectFrame);


setappdata(0,'origin', origin)

setappdata(0,'ref_videoFileReader', videoFileReader);
setappdata(0,'ref_videoPlayer', videoPlayer);
setappdata(0,'ref_objectFrame', objectFrame);
set(handles.updateorigintext,'string',strcat('Origin [X, Y] = ',num2str(origin*scale),'mm'))
axes(handles.axes2)
imshow(objectFrame);


% --- Executes on button press in scale.
function scale_Callback(hObject, eventdata, handles)
% hObject    handle to scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

filename = getappdata(0, 'ref_filename')  ;
pathname = getappdata(0, 'ref_pathname')  ;

% open file
videoFileReader = getappdata(0,'ref_videoFileReader');
videoPlayer = getappdata(0,'ref_videoPlayer');
objectFrame = getappdata(0,'ref_objectFrame');

% open file
videoFileReader = vision.VideoFileReader(strcat(pathname,filename));
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
objectFrame = videoFileReader();


figure()
imshow(objectFrame); 
title('Set scale to 200 mm and hit enter...')
fprintf('Set scale to 200 mm and hit enter...\n')

 % set up the measuring tool
 h = imdistline(gca);
 api = iptgetapi(h);
 %api.setLabelVisible(false);
 pause();

 % get the distance
 dist = api.getDistance();
 fprintf('The distance is: %0.2f mm/pixel \n',dist);
 scale = 200/dist;
 set(handles.updatescaletext,'string',strcat('Scale =',num2str(scale),'mm/pixel'))
 fprintf('The scale is: %0.2f mm/pixel \n', scale)
 setappdata(0,'scale',scale)


 % print the result
 getappdata(0,'scale')
 fprintf('The scale is: %0.3f mm/pixel \n', scale)
 close(gcf)
 

 
 axes(handles.axes2)
 imshow(objectFrame);




% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = getappdata(0, 'test_filename') ; 
pathname = getappdata(0, 'test_pathname') ; 
scale = getappdata(0, 'scale')  ;
fprintf('The scale in PROCESS is: %0.2f mm/pixel \n', scale)
origin = getappdata(0, 'origin')  ;
linenumber = getappdata(0, 'linenumber')  ;
checktrack = getappdata(0, 'checktrack')  ;


strcat(pathname,filename)
videoFileReader = vision.VideoFileReader(strcat(pathname,filename));
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
objectFrame = videoFileReader();

figure(4)
imshow(objectFrame);
title('Choose region of tracking point')
fprintf('Choose region of tracking point')

objectRegion = round(getPosition(imrect))

points = detectMinEigenFeatures(rgb2gray(objectFrame),'MinQuality',0.8,'ROI',objectRegion);
close(gcf)

if size(points,1) ~= 1
    fprintf('Points ~= 1')
    points=points(1,:);
end

%% ________________________________________________________________________
% Start tracking

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,points.Location,objectFrame);

i=1;
if get(handles.checktrack,'value')== 1
    while ~isDone(videoFileReader)
          frame = videoFileReader();
          [points,validity] = tracker(frame);
          tracked(i,:) = points;
          out = insertMarker(frame,tracked,'x','Color','green','size',2);
          out = insertMarker(out,points(validity, :),'+','Color','green','size',20);
          out = insertMarker(out,origin,'+','Color','red','size',20);
          videoPlayer(out);
          i=i+1;
    end
end

assignin('base','tracked',tracked);

if get(handles.checktrack,'value')== 0
    while ~isDone(videoFileReader)
          frame = videoFileReader();
          [points,validity] = tracker(frame);
          tracked(i,:) = points;
          i=i+1;
    end
end

linenumber = linenumber + 1
% calculations

tracked_scaled = tracked * scale;
reference_scaled = origin * scale;

referenced_scaled = tracked_scaled - reference_scaled;
penetration = min(referenced_scaled(:,1))

set(handles.result,'string',strcat('Penetration =',num2str(penetration),'mm'))
setappdata(0,'penetration', penetration);
setappdata(0,'linenumber', linenumber);
set(handles.save, 'visible', 'on')
if get(handles.autosave,'value')~=0
    autosave_Callback(handles.autosave, eventdata, handles)
end


%% ________________________________________________________________________
% Plot Results

axes(handles.axes1)
plot(referenced_scaled(:,1),(referenced_scaled(:,2))*(-1),'k.')
hold on
plot(referenced_scaled(:,1),(referenced_scaled(:,2))*(-1),'b')
title('Position')
ylim([-25 25])
xlim([-25 25])
xlabel('X [mm]')
ylabel('Y [mm]')
grid on
grid minor
hold on
plot(0,0,'r+','markersize',20)







% --- Executes on button press in updatetest.
function updatetest_Callback(hObject, eventdata, handles)
% hObject    handle to updatetest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.mkv'},'File Selector')
setappdata(0,'test_filename', filename)
setappdata(0,'test_pathname', pathname)

set(handles.test, 'string', strcat(pathname,'/',filename))
set(handles.process, 'visible', 'on')


% --- Executes on button press in updateref.
function updateref_Callback(hObject, eventdata, handles)
% hObject    handle to updateref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.mkv'},'File Selector')

setappdata(0,'ref_filename', filename)
setappdata(0,'ref_pathname', pathname)

set(handles.ref, 'string', strcat(pathname,'/',filename))
set(handles.scale, 'visible', 'on')
set(handles.origin, 'visible', 'on')


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
penetration = getappdata(0, 'penetration')  ;
savefile = getappdata(0, 'savefile') ; 
pathname = getappdata(0, 'ref_pathname') ; 
linenumber = getappdata(0, 'linenumber') ;
test_filename = getappdata(0, 'test_filename');
xlswrite(savefile{1},{test_filename},'sheet1',strcat('A',num2str(linenumber)));
xlswrite(savefile{1},penetration,'sheet1',strcat('B',num2str(linenumber)));
set(handles.savetext,'string',strcat('saved at: ', savefile,':',test_filename,' - Line ',num2str(linenumber)))



% --- Executes on button press in autosave.
function autosave_Callback(hObject, eventdata, handles)
% hObject    handle to autosave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autosave
penetration = getappdata(0, 'penetration')  ;
savefile = getappdata(0, 'savefile') ; 
pathname = getappdata(0, 'ref_pathname') ; 
linenumber = getappdata(0, 'linenumber') ;
test_filename = getappdata(0, 'test_filename');

xlswrite(savefile{1},linenumber,'sheet1',strcat('A',num2str(linenumber)));
xlswrite(savefile{1},penetration,'sheet1',strcat('B',num2str(linenumber)));
set(handles.savetext,'string',strcat('saved at: ', savefile,':',test_filename,' - Line ',num2str(linenumber)))


% --- Executes on button press in updatesave.
function updatesave_Callback(hObject, eventdata, handles)
% hObject    handle to updatesave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter new file name for saving'}
filename = inputdlg(prompt)
set(handles.updatesavetext,'string',strcat('saving under: ', filename))
setappdata(0,'savefile', filename)
setappdata(0,'linenumber', 0);


% --- Executes on button press in checktrack.
function checktrack_Callback(hObject, eventdata, handles)
% hObject    handle to checktrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checktrack
