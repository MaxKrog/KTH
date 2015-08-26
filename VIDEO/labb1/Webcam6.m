function varargout = Webcam6(varargin)
% WEBCAM6 MATLAB code for Webcam6.fig
%      WEBCAM6, by itself, creates a new WEBCAM6 or raises the existing
%      singleton*.
%
%      H = WEBCAM6 returns the handle to a new WEBCAM6 or the handle to
%      the existing singleton*.
%
%      WEBCAM6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEBCAM6.M with the given input arguments.
%
%      WEBCAM6('Property','Value',...) creates a new WEBCAM6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Webcam6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Webcam6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Webcam6

% Last Modified by GUIDE v2.5 31-Mar-2015 17:40:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Webcam6_OpeningFcn, ...
                   'gui_OutputFcn',  @Webcam6_OutputFcn, ...
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


% --- Executes just before Webcam6 is made visible.
function Webcam6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Webcam6 (see VARARGIN)

% Choose default command line output for Webcam6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Webcam6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Webcam6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
set(handles.Show,'Visible','off');
set(handles.Process,'Visible','off');
set(handles.Record,'Visible','off');


vid = videoinput('macvideo', 1, 'YCbCr422_1280x720');
vidRes=get(vid,'videoResolution');
nBands=get(vid,'NumberOfBands');


vid.FramesPerTrigger = 100; % Inf;
vid.LoggingMode = 'disk&memory';
fileName = strcat(pwd,'/testABCD.mp4');
disp(fileName);

handles.filename = fileName;
diskLogger = VideoWriter(fileName, 'MPEG-4');
vid.DiskLogger = diskLogger;

axes(handles.axPreview);
hImage=image(zeros(vidRes(2),vidRes(1),nBands));

preview(vid, hImage);

set(handles.Record,'Visible','on')

handles.stop = 0;
handles.vid = vid;

guidata(hObject,handles);

% --- Executes on button press in Record.
function Record_Callback(hObject, eventdata, handles)
% hObject    handle to Record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vid = handles.vid;
start(vid);

wait(vid);
delete(vid);
clear vid;

warndlg('Done!');
disp(' Image Acquired!');

set(handles.Process,'Visible','on');
guidata(hObject,handles);


% --- Executes on button press in Process.
function Process_Callback(hObject, eventdata, handles)
% hObject    handle to Process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = handles.filename;
disp('Processing');
vidRGB2YUV( fileName )

set(handles.Show,'Visible','on');

guidata(hObject,handles);

% --- Executes on button press in Show.
function Show_Callback(hObject, eventdata, handles)
% hObject    handle to Show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



fileName = strcat(pwd,'/Show.avi');
movObj = VideoReader(fileName);
mov = movObj.read();
movie(handles.axPreview, mov,1,30);
    

guidata(hObject,handles);
