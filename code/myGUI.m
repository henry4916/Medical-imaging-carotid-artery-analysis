function varargout = myGUI(varargin)
% MYGUI MATLAB code for myGUI.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myGUI

% Last Modified by GUIDE v2.5 23-Dec-2021 16:15:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @myGUI_OutputFcn, ...
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
end

% --- Executes just before myGUI is made visible.
function myGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myGUI (see VARARGIN)
set(gcf,'name','609410151'); 
white_img = imread("../data/white.jpg");
axes(handles.axes1);
imshow(white_img);
axes(handles.axes2);
imshow(white_img);
% Choose default command line output for myGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = myGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    cla(handles.axes1,'reset');
    cla(handles.axes2,'reset');
    white_img = imread("../data/white.jpg");
    axes(handles.axes1);
    imshow(white_img);
    axes(handles.axes2);
    imshow(white_img);
    
    [filename, pathname] = uigetfile({'*.*' , 'All Files'}, 'Select Original Data', "./original_data/");
    ori_data_name = strcat(pathname, filename);
    % handles.string_text  = handles.string_text + "\n" + ori_data_name;
    % set(handles.text2, 'String' , handles.string_text);

    ori_data = dicomread(ori_data_name);
    % handles.ori_data;
    % guidata(hObject,handles);
    x1=0;
    y1=0;
    x2=0;
    y2=0;
    for i = 1:500
       % exit= msgbox("string(1)+'/500');
       % timer close msgbox
       % start(timer('timerFcn',@(obj,~)close(f),'StartDelay',0.1,'stopFcn',@(obj,~)delete(obj)));
       ori_image = ori_data(:, :, :, i);
       str_tmp = strcat(int2str(i), ".jpg");
       save_file_name = strcat("../data/original_image/ori_img", str_tmp);
       imwrite(ori_image, save_file_name);
    %    axes(handles.axes1);
    %    imshow(save_file_name);
       if(i == 1)
            axes(handles.axes1);
            imshow(save_file_name);
            choose_artery_msgbox = msgbox('Frame the position of the carotid artery in the picture');
            waitfor(choose_artery_msgbox);
            hold on
            [x1,y1]=ginput(1);
            plot(x1,y1,'+');
            [x2,y2]=ginput(1);
            plot(x2,y2,'+');
            f = waitbar(0,'Loading your data...');
       end
       % segmentation original image to carotid_artery_image 
       cut_image = imcrop(ori_image, [x1, y1, x2-x1, y2-y1]);
       str_tmp = strcat(int2str(i), ".jpg");
       artery_file_name = strcat("../data/carotid_artery_image/carotid_artery_image", str_tmp);
       imwrite(cut_image, artery_file_name);
    %    axes(handles.axes2);
    %    imshow(cut_image);
        waitbar(i/500,f);
        pause(0.1);
    end
    close(f);
    choose_artery_msgbox = msgbox('Data loading completed');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    f = waitbar(0,'Processing your data...');
    for i = 1:500
        waitbar(i/500,f);
        pause(0.1);
        str_tmp = strcat(int2str(i), ".jpg");
        ori_file_name = strcat("../data/carotid_artery_image/carotid_artery_image", str_tmp);
        carotid_artery_image = imread(ori_file_name);
%         axes(handles.axes1);
%         imshow(carotid_artery_image);

        % rgb2gray
        gray_image = rgb2gray(carotid_artery_image);

        % medium filter
        medium_filter_image = medfilt2(gray_image,[9,9]);

        % imhist
        histeq_img = histeq(medium_filter_image);

%         axes(handles.axes2);
%         imshow(histeq_img);

        % otsu
        threshold = graythresh (histeq_img);
        bw_img = imbinarize(histeq_img, threshold);

        str_tmp = strcat(int2str(i), ".jpg");
        artery_file_name = strcat("../data/black_white_image/black_white_image", str_tmp);
        imwrite(bw_img, artery_file_name);
    end
    close(f);
    choose_artery_msgbox = msgbox('Data Processing completed');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    I = imread('../data/carotid_artery_image/carotid_artery_image1.jpg');
    axes(handles.axes2);
    imshow(I);
    draw_cirlce_box = msgbox('Draw a circle inside the carotid artery');
    waitfor(draw_cirlce_box);
    r = drawcircle;
    circle_draw = createMask(r);
    imwrite(circle_draw, "../data/circle_draw.jpg");
    x = ones(1,500);
    x(x==1)=5000;
    count = 0;
    for i_img_read = 1:500
        str_tmp = strcat(int2str(i_img_read), ".jpg");
        ori_file_name = strcat("../data/original_image/ori_img", str_tmp);
        carotid_artery_image = imread(ori_file_name);
        axes(handles.axes1);
        imshow(carotid_artery_image);

        I = imread([['../data/black_white_image/black_white_image', int2str(i_img_read)], '.jpg']);
        bw = activecontour(I,circle_draw,100,'Chan-Vese');

        bw = activecontour(I,bw,100,'edge');

        imwrite(bw, [['../data/result/result', int2str(i_img_read)], '.jpg']);
        img = imread([['../data/result/result', int2str(i_img_read)], '.jpg']);
        img = double(img);
        img_size = size(img);
        for i = 1:img_size(1)
            for j = 1:img_size(2)
                if(img(i, j) == 255)
                    count = count + 1;
                end
            end
        end
        x(i_img_read) = count;
        count = 0;
        axes(handles.axes2);
        plot(x);
        drawnow;
    end
    %
    time = (1:500);
    [peaks_all,locs_all]=findpeaks(x);
    [peaks_crest,locs_crest]=findpeaks(x);
    [peaks_crest,locs_crest] = findpeaks(x,'minpeakheight',mean(peaks_crest));
    [peaks_crest,locs_crest] = findpeaks(x,'minpeakdistance', 24);
    hold on;
    plot(time,x)                                                   
    plot(locs_crest,peaks_crest,'*','color','R');
    nm=max(x)-x ;   
    hold off;
    
    [peaks_trough,locs_trough]=findpeaks(nm);
    [peaks_trough,locs_trough] = findpeaks(nm,'minpeakheight',mean(peaks_trough));
    [peaks_trough,locs_trough] = findpeaks(nm,'minpeakdistance', 24);

    hold on;
    axes(handles.axes2);
    plot(time,x)
    plot(locs_trough,x(locs_trough),'o','color','G');  
    average_crset = mean(peaks_crest);
    average_trough = mean(x(locs_trough)); 
    hold off;
    drawnow;
    
    prompt = {'Enter Systolic blood pressure:','Enter Diastolic blood pressure:'};
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {'',''};
    answer = inputdlg(prompt,dlgtitle,dims,definput)
    Systolic = str2num(answer{1});
    Diastolic = str2num(answer{2});
    
    draw_cirlce_box = msgbox({'Peak Average = '+ string(average_crset) ; 
        "Valley Average = " + string(average_trough);
        "Stiffness index = " + string((log(Systolic-Diastolic)/((average_crset-average_trough)/average_trough)))});
%     mean(peaks_crest)
%     mean(x(locs_trough))
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exit= questdlg('Are you sure you want to end the program?', 'Exit the program', 'yes','no','no');
if exit =='yes'
close(gcf)
end
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
