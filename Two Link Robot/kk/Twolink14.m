function varargout = Twolink14(varargin)
% TWOLINK14 MATLAB code for Twolink14.fig
%      TWOLINK14, by itself, creates a new TWOLINK14 or raises the existing
%      singleton*.
%
%      H = TWOLINK14 returns the handle to a new TWOLINK14 or the handle to
%      the existing singleton*.
%
%      TWOLINK14('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOLINK14.M with the given input arguments.
%
%      TWOLINK14('Property','Value',...) creates a new TWOLINK14 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Twolink14_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Twolink14_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Twolink14

% Last Modified by GUIDE v2.5 01-Oct-2015 03:10:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Twolink14_OpeningFcn, ...
                   'gui_OutputFcn',  @Twolink14_OutputFcn, ...
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


% --- Executes just before Twolink14 is made visible.
function Twolink14_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Twolink14 (see VARARGIN)

% Choose default command line output for Twolink14
handles.output = hObject;

handles.robot = []; % the robot 
handles.j1 = 0;  %its joints
handles.j2 = 0;
% Update handles structure

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Twolink14 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Twolink14_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
disp s1.1
handles.j2 = get (hObject,'Value');
guidata(hObject, handles);
disp s1.2
%handles.robot.plot ([handles.j1, handles.j2]);
disp s1.3
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.j1 = get(hObject, 'Value');
guidata(hObject, handles);
%handles.robot.plot ([handles.j1, handles.j2]);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in create_robot.
function create_robot_Callback(hObject, eventdata, handles)
% hObject    handle to create_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp c1
% L(i) = Link{[theta d A Alpha]}
L(1) = Link([pi/2 0 10.8 0]);
L(2) = Link([0 2.5 10.878 0]);
handles.robot = SerialLink(L, 'name', 'robot');

handles.robot.plot ([handles.j1, handles.j2]);
disp c2
