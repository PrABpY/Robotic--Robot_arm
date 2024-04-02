function varargout = RRR_Robot(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RRR_Robot_OpeningFcn, ...
                   'gui_OutputFcn',  @RRR_Robot_OutputFcn, ...
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


% --- Executes just before RRR_Robot is made visible.
function RRR_Robot_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
L_1 = 50;
L_2 = 50;
L_3 = 40;
L_4 = 40;

L(1) = Link([0 L_1 0 pi/2]);
L(2) = Link([0 0 L_2 0]);
L(3) = Link([0 0 L_3 0]);
L(4) = Link([0 0 L_4 0]);
L(4).offset = -pi/2;

Robot = SerialLink(L);
Robot.name = '  3DoF';

handles.Theta_1.String = '0';
handles.Theta_2.String = '0';
handles.Theta_3.String = '0';
handles.Theta_4.String = '0';

T = Robot.fkine([0 0 0 0]);

handles.CurrentT1 = pi/2;
handles.CurrentT2 = pi/2;
handles.CurrentT3 = pi/2;
handles.CurrentT4 = pi/2;

handles.Pos_X.String = num2str(floor(T.t(1,1)));
handles.Pos_Y.String = num2str(floor(T.t(2,1)));
handles.Pos_Z.String = num2str(floor(T.t(3,1)));

Robot.plot([0 0 0 0]);
view(45,30);
handles.Robot = Robot;
% Update handles structure
guidata(hObject, handles);

function Theta_1_Callback(hObject, eventdata, handles)
function Theta_2_Callback(hObject, eventdata, handles)
function Theta_3_Callback(hObject, eventdata, handles)
function Pos_X_Callback(hObject, eventdata, handles)
function Pos_Y_Callback(hObject, eventdata, handles)
function Pos_Z_Callback(hObject, eventdata, handles)

function varargout = RRR_Robot_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function Theta_1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Theta_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Theta_3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Forward.
function btn_Forward_Callback(hObject, eventdata, handles)
Th_1 = str2double(handles.Theta_1.String)*pi/180;
Th_2 = str2double(handles.Theta_2.String)*pi/180;
Th_3 = str2double(handles.Theta_3.String)*pi/180;
Th_4 = str2double(handles.Theta_4.String)*pi/180;

%cla(handles.axes1);
handles.Robot.plot([Th_1 Th_2 Th_3 Th_4]);

T = handles.Robot.fkine([Th_1 Th_2 Th_3 Th_4]);
handles.CurrentT1 = Th_1;
handles.CurrentT2 = Th_2;
handles.CurrentT3 = Th_3;
handles.CurrentT4 = Th_4;

handles.Pos_X.String = num2str(floor(T.t(1,1)));
handles.Pos_Y.String = num2str(floor(T.t(2,1)));
handles.Pos_Z.String = num2str(floor(T.t(3,1)));

function Pos_X_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Pos_Y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Pos_Z_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Inverse.
function btn_Inverse_Callback(hObject, eventdata, handles)
PX = str2double(handles.Pos_X.String);
PY = str2double(handles.Pos_Y.String);
PZ = str2double(handles.Pos_Z.String);

T = transl(PX,PY,PZ);

J = handles.Robot.ikine(T,[0 handles.CurrentT2 handles.CurrentT3 handles.CurrentT4], 'mask', [1 1 1 0 0 0]) * 180/pi;
J
handles.Theta_1.String = num2str(floor(J(1)));
handles.Theta_2.String = num2str(floor(J(2)));
handles.Theta_3.String = num2str(floor(J(3)));

%cla(handles.axes1);
handles.Robot.plot(J*pi/180);


% --- Executes on button press in btnDemo.
function btnDemo_Callback(hObject, eventdata, handles)
State = 0;
x = handles.txtStep.String;
if( strcmp(x, '') )
    Step = 20;
else
    Step = str2double(x);
end
Start = 0;
End = 180;
%PauseTime = 0;

Th_1 = str2double(handles.Theta_1.String)*pi/180;
Th_2 = str2double(handles.Theta_2.String)*pi/180;
Th_3 = str2double(handles.Theta_3.String)*pi/180;
Th_4 = str2double(handles.Theta_3.String)*pi/180;

%cla(handles.axes1);
handles.Robot.plot([Th_1 Th_2 Th_3 Th_4]);

%view(45,30);
hold on;

t_1 = Start:Step:End;
Points = zeros(length(t_1), length(t_1) , 4);

for c = 1:Step:180
    for t1 = 1:1:length(t_1)
        if (State == 0)
            for t2 = 1:1:length(t_1)
                %handles.Robot.plot([0 t1 t2]*pi/180);
                P = handles.Robot.fkine([c t_1(t1) t_1(t2) t_1(t2)]*pi/180);
                Points(t1,t2,1) = P.t(1,1);
                Points(t1,t2,2) = P.t(2,1);
                Points(t1,t2,3) = P.t(3,1);
                plot3(P.t(1,1),P.t(2,1),P.t(3,1),'r.');
                handles.Robot.plot([P.t(1,1) P.t(2,1) P.t(3,1)]*pi/180);
                % pause(PauseTime);
            end
            State = 1;
        else
            for t2 = length(t_1):-1:1
                %handles.Robot.plot([0 t1 t2]*pi/180);
                P = handles.Robot.fkine([c t_1(t1) t_1(t2) t_1(t2)]*pi/180);
                Points(t1,t2,1) = P.t(1,1);
                Points(t1,t2,2) = P.t(2,1);
                Points(t1,t2,3) = P.t(3,1);
                plot3(P.t(1,1),P.t(2,1),P.t(3,1),'r.');
                handles.Robot.plot([P.t(1,1) P.t(2,1) P.t(3,1)]*pi/180);
                % pause(PauseTime);
            end
            State = 0;
        end
    end
end
%plot3(Points(:,:,1), Points(:,:,2), Points(:,:,3), 'r.');


% --- Executes during object creation, after setting all properties.
function txtStep_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta_4_Callback(hObject, eventdata, handles)
% hObject    handle to Theta_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta_4 as text
%        str2double(get(hObject,'String')) returns contents of Theta_4 as a double


% --- Executes during object creation, after setting all properties.
function Theta_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
