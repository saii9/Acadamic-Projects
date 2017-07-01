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

% Last Modified by GUIDE v2.5 08-Dec-2015 11:32:10

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

handles.j1 = 0;  %variable for joint 1 angle 
handles.j2 = 0;  %variable for Joint 2 angle

handles.deg = 180/pi; %variable to convert in to degrees
handles.rad = pi/180; %variable to convert in to radians

handles.a = arduino('COM10');
handles.a.servoAttach(1);
handles.a.servoAttach(2);
handles.a.servoAttach(5);

handles.pen.down=93;
handles.pen.up=31;
handles.pen.break=50;

handles.a.servoWrite(5, handles.pen.up);

%its joints
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Twol  ink14 wait for user response (see UIRESUME)
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
handles.j1 = get (hObject,'Value');
handles.robot.plot ([handles.j1, handles.j2]);
set(handles.j1angle,'String',handles.j1*handles.deg);
%set(handles.j1angle,'Value',num2str(handles.j1));
handles.a.servoWrite(1,-1 * round(handles.j1*handles.deg,0) + 129);
guidata(hObject, handles);
calculate_positions(hObject, handles) % to caluculte position of end effectot with nee joint angles

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
handles.j2 = get(hObject, 'Value');
handles.robot.plot ([handles.j1, handles.j2]);
set(handles.j2angle,'String',handles.j2*handles.deg);
handles.a.servoWrite(2,-1*round(handles.j2*handles.deg,0) - 31);
calculate_positions(hObject, handles)
guidata(hObject, handles);

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
% L(i) = Link{[theta d A Alpha]}
%L(1) = Link([0 0 10.878 0]);
%L(2) = Link([0 2.5 10.8 0]);
L(1) = Revolute('d', 0,     'a', 0.11, 'alpha', 0, ...
    'qlim', [129 -51]*handles.deg );
% calling revolute function for the second joint
L(2) = Revolute('d', .025, 'a', 0.108, 'alpha', 0, ...
    'qlim', [-31 -149]*handles.deg ); % specifying the joint limits with respec to Y axis

handles.robot = SerialLink(L, 'name', 'robot');

handles.j1=75 * handles.rad;  %setting to min position when the plot starts
handles.j2=-90 * handles.rad;


%handles.j1 = get (handles.slider1,'Min') ;  %setting to min position when the plot starts
%handles.j2 = get (handles.slider2,'Min') ;

set(handles.slider2,'Value',handles.j2); % setting the value of sliders
set(handles.slider1,'Value',handles.j1);
handles.a.servoWrite(1,-1 * round(handles.j1*handles.deg ,0) + 129);
handles.a.servoWrite(2, -1 * round(handles.j2*handles.deg ,0) - 31);

handles.robot.plot ([handles.j1, handles.j2]);

set(handles.j2angle,'String',handles.j2*handles.deg );
set(handles.j1angle,'String',handles.j1*handles.deg );

guidata(hObject, handles);
calculate_positions(hObject, handles)% to caluculte position of end effectot with nee joint angles
%set(gcf, 'CurrentCharacter','@getKey');


function j1angle_Callback(hObject, eventdata, handles)
% hObject    handle to j1angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.j1 = str2double(get(hObject, 'String'))*handles.rad;

% pop up if the entered value is out of range
if handles.j1 < get (handles.slider1,'Min') || handles.j1 > get (handles.slider1,'Max'); 
   msgbox ('Please enter the joint one angle in range');
   handles.j1 = get (handles.slider1,'Value');
   set(handles.j1angle,'String',round(handles.j1*handles.deg));
   return;    
end

set(handles.slider1,'Value',handles.j1);
handles.robot.plot ([handles.j1, handles.j2]);
handles.a.servoWrite(1,-1 * round(handles.j1*handles.deg,0) + 129);
guidata(hObject, handles);
calculate_positions(hObject, handles)% to caluculte position of end effectot with nee joint angles

% Hints: get(hObject,'String') returns contents of j1angle as text
%        str2double(get(hObject,'String')) returns contents of j1angle as a double

% --- Executes during object creation, after setting all properties.
function j1angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j1angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function j2angle_Callback(hObject, eventdata, handles)
% hObject    handle to j2angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j2angle as text
%        str2double(get(hObject,'String')) returns contents of j2angle as a double

% --- Executes during object creation, after setting all properties.
handles.j2 = str2double(get(hObject, 'String'))* handles.rad;

% pop up if the entered value is out of range
if handles.j2 < get (handles.slider2,'Min') || handles.j2 > get (handles.slider2,'Max'); 
   msgbox ('Please enter the joint one angle in range');
   handles.j2 = get (handles.slider2,'Value');
   set(handles.j2angle,'String',handles.j2*handles.deg);
   
   return;    
end

set(handles.slider2,'Value',handles.j2);
handles.robot.plot ([handles.j1, handles.j2]); %plotting with the new set of joint angles

handles.a.servoWrite(2,-1*round(handles.j2*handles.deg,0) - 31);
guidata(hObject, handles);
calculate_positions(hObject, handles) % to caluculte position of end effectot with nee joint angles

function j2angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j2angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% this fucntion is to caluculate the positions of the end effector and
% joint two. It uses fkine to calculate
% to caluculte position of end effectot with nee joint angles
function calculate_positions(hObject, handles)

% using fkine function to calculate the end effecto position
[handles.Tmat All] = handles.robot.fkine ([handles.j1, handles.j2]);
set(handles.eex,'String', handles.Tmat(1,4)*100);
set(handles.eey,'String', handles.Tmat(2,4)*100);
set(handles.eez,'String', handles.Tmat(3,4)*100);

% displaying on the graphical interface
%{
set(handles.j1x,'String', All(1,4,1));
set(handles.j1y,'String', All(2,4,1));
set(handles.j1z,'String', All(3,4,1));

set(handles.j1xb,'String', All(1,4,1) + 4.6);
set(handles.j1yb,'String', All(2,4,1) + 10);
set(handles.j1zb,'String', All(3,4,1));

set(handles.eexb,'String', handles.Tmat(1,4) + 4.6);
set(handles.eeyb,'String', handles.Tmat(2,4) + 10);
set(handles.eezb,'String', handles.Tmat(3,4));

set(handles.eex,'String',(cos(handles.j1) * 10.878)+(cos(handles.j1 + handles.j2) * 10.8));
set(handles.eey,'String',(sin(handles.j1) * 10.878)+(sin(handles.j1 + handles.j2) * 10.8));
set(handles.eez,'String',2.5);

set(handles.eexb,'String',(cos(handles.j1) * 10.878)+(cos(handles.j1 + handles.j2) * 10.8) + 4.6);
set(handles.eeyb,'String',(sin(handles.j1) * 10.878)+(sin(handles.j1 + handles.j2) * 10.8) + 10);
set(handles.eezb,'String',2.5);

set(handles.j1x,'String',cos(handles.j1) * 10.878);
set(handles.j1y,'String',sin(handles.j1) * 10.878);
set(handles.j1z,'String',2.5);

set(handles.j1xb,'String', cos(handles.j1) * 10.878 + 4.6);
set(handles.j1yb,'String', sin(handles.j1) * 10.878 + 10);
set(handles.j1zb,'String', z);

%}

guidata(hObject, handles);

function updateAll(hObject, handles)
    
    set(handles.slider1,'Value',handles.j1);
    set(handles.slider2,'Value',handles.j2);
    set(handles.j1angle,'String',handles.j1*handles.deg);
    set(handles.j2angle,'String',handles.j2*handles.deg);
    handles.robot.plot ([handles.j1, handles.j2]);
    calculate_positions(hObject, handles);
   
function keyControl_Callback(hObject, eventdata, handles)
% hObject    handle to keyControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp man

% --- Executes on key press with focus on keyControl and none of its controls.
function keyControl_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to keyControl (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

switch(eventdata.Key)
    case 'uparrow'
        move(0.002,0,0,hObject, eventdata, handles);
    case 'downarrow'
        move(-0.002,0,0,hObject, eventdata, handles)
    case 'leftarrow'
        move(0,0.002,0,hObject, eventdata, handles)
    case 'rightarrow'
        move(0,-0.002,0,hObject, eventdata, handles)
    case 'pageup'
        handles.a.servoWrite(5,handles.pen.up);
    case 'pagedown'
        handles.a.servoWrite(5,handles.pen.down);
        
end

function move(dx,dy,dz,hObject, eventdata, handles)
    %% changing the Tmat for Ikine
    Tmat = handles.Tmat;
    Tmat(1,4) = Tmat(1,4)+ dx;
    Tmat(2,4) = Tmat(2,4)+ dy;
    Tmat(3,4) = Tmat(3,4)+ dz;

    j = handles.robot.ikine(Tmat,[handles.j1 handles.j2],[1 1 0 0 0 0]);
    
    handles.j1 = j(1,1);
    handles.j2 = j(1,2);
    
    handles.Tmat = handles.robot.fkine([handles.j1 handles.j2]);
    updateAll(hObject, handles);% updating the leabels on GUI
   %writing to servos
    handles.a.servoWrite(2,-1*round(handles.j2*handles.deg,0) - 31);
    handles.a.servoWrite(1,-1 * round(handles.j1*handles.deg,0) + 129);
    
    guidata(hObject, handles);
    %disp move2

function msg_Callback(hObject, eventdata, handles)
% hObject    handle to msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msg as text
%        str2double(get(hObject,'String')) returns contents of msg as a double


% --- Executes during object creation, after setting all properties.
function msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in writeMsg.
function writeMsg_Callback(hObject, eventdata, handles)
% hObject    handle to writeMsg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    xposmax =16;
    xposmin=0;
    yposmax=6;
    yposmin=-9;
    handles.a.servoWrite(5, handles.pen.up);

    text = get(handles.msg,'String')% getting the input text
    textascii = double(text);

    for k=1:length(textascii)
       % disp(textascii(k));

        if ((textascii(k)<97 && textascii(k)~=32) || (textascii(k)>122))
            continue;
        end
        % reading from file
        [w e] = textread(strcat(num2str(textascii(k)), '.txt')); 
        l = length(w);    

        if (k==1)
    
            xpos=16;
            ypos=5

            j = [60 -74]*handles.rad;
            Tmatx = handles.robot.fkine (j)
            Tmatx =  cat ( 2, Tmatx(1:4,1:3),[xpos/100; ypos/100; .025; 1]) ;
            j = handles.robot.ikine(Tmatx,j,[1 1 0 0 0 0])
            jx = j;
            myMotors(handles.a,j);
            Tmat = Tmatx;
        else
            ypos = ypos - 1

            if (ypos < yposmin)% if the robot has reached the end of line
                xpos = xpos -1;
                ypos = yposmax;

                Tmatx =  cat ( 2, Tmatx(1:4,1:3),[xpos/100; ypos/100; 2.5; 1]) ;
                jx = handles.robot.ikine(Tmatx,jx,[1 1 0 0 0 0])
                j = jx;
                Tmat = Tmatx;
                myMotors(handles.a,j);
            else
                Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100; ypos/100; 2.5; 1]) ;
                j = handles.robot.ikine(Tmat,j,[1 1 0 0 0 0]);
                myMotors(handles.a,j);
            end;
        end;

        for i=1:1:l
            
            Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100+e(i)/100; ypos/100+(1-w(i))/100; 2.5; 1]) ;
            j = handles.robot.ikine(Tmat,j,[1 1 0 0 0 0]);
            Tmat = handles.robot.fkine(j);

            if(i==1)

                myMotors(handles.a,j)
                handles.a.servoWrite(5, handles.pen.down);

            else if (w(i) == 0) % lifting the pen in case of letters like t,i,j,k

                handles.a.servoWrite(5, handles.pen.break);
                Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100+e(i+1)/100; ypos/100+(1-w(i+1))/100; 2.5; 1]) ;
                j = handles.robot.ikine(Tmat,j,[1 1 0 0 0 0]);

                myMotors(handles.a,j)
                i = i+1;

                handles.a.servoWrite(5, handles.pen.down);
            else

                myMotors(handles.a,j)
            end
            
            if(i==l)
                handles.a.servoWrite(5, handles.pen.break);% pen break between alphabets
            end;
            
            end;
        end;

    end;
    handles.a.servoWrite(5, handles.pen.up); % raising the pen
    
    handles.Tmat = Tmat;
    handles.j1 = j(1,1);
    handles.j2 = j(1,2);
    updateAll(hObject,handles); % updating positions in GUI

    
    function myMotors(a,j) % to write values in to servos
        a.servoWrite(1,-1*round(j(1,1)*180/pi) + 129);      
        a.servoWrite(2,-1*round(j(1,2)*180/pi) - 31);
 
