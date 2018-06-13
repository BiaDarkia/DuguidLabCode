%% Loads excel lever training records and updates the metadata and compiles a mouse training sheet
% Preliminary stuff:

clear all

% Load MetaPathList
MetaPathList % Your paths are save in MetaPathList.m

currentfolder=pwd;
pathfolder=trainingSheetPath;
cd(pathfolder);

% Option to load individual file or folder containing multiple fiels
file_or_folder = input('Do you want to load a single file (f) or a folder (F)?:', 's');

if file_or_folder == 'f' %Single file
    
    filename=uigetfile('*.*');
    xlsList = 1;
    
elseif file_or_folder == 'F' %Folder: get list of excel files in it
    
    directory_name  =   uigetdir;
    files           =   dir(directory_name);
    fileIndex       =   find(~[files.isdir]);
    numFiles        =   length(fileIndex);
    xlsList         =   zeros(1,numFiles);
    
    for file_ID = fileIndex
        if ~isempty(regexp(files(file_ID).name,'.xls', 'once'))
            xlsList(file_ID) = 1;
        end
    end
    
    xlsList         = find(xlsList == 1);
    numxlsFiles     = length(xlsList);
    
end

% For each file in list extract data and add to metadata
for file_ID=xlsList
    
    if length(xlsList)>1
        filename = files(file_ID).name;
        cd(directory_name)
    end
    
    
    [NUM,TXT,RAW] = xlsread(filename);  % <-- Read the Excel here
    
    
    % Load previous metadata file if such a file exists, otherwise create a cell array for the headers of such a file:
    if exist('Lever_training_cued_metadata.mat','file')
        load('Lever_training_cued_metadata.mat');
        old_metadata=mouse_metadata;
    else
        old_metadata={'Mouse_name','ABF_name','Initial_weight','Tr_day_1_date','Num_Tr_days','Reward_pos','Training paradigm'};
    end
    
    % Extract appropriate variables from the excel training sheet:
    Mouse_name      =   TXT{3,20};
    ABF_name        =   TXT{4,20};
    Initial_weight  =   RAW{8,5};
    Tr_day_1_date   =   TXT{29,1};
    Num_tr_days     =   RAW{5,20};
    Reward_pos      =   TXT{6,20};
    TrainingParadigm     =   TXT{7,20};    % This is now used to distinguish between Normal training and Go/NoGo mice.       
    
    
    if ischar(Num_tr_days)==1
        Num_tr_days=str2double(Num_tr_days);
    end
    
    if strcmp(TrainingParadigm, 'W') || strcmp(TrainingParadigm, 'F')  %% The old file won't have the TrainingParadigm cell so need to compensate for that
        TrainingParadigm = 'G'; 
        FoodorWater = 'W'; 
        
    end
    
    %% Metadata Loader for Go NoGo mice
    
    if strcmp(TrainingParadigm, 'GN') == 1
        TrainingParadigm = 'Go/NoGo'; 
    
    % Check if the mouse is already in the metadata:
    exist_mouse = zeros(size(old_metadata));
    for ii = 1:length(exist_mouse)
        if strfind(old_metadata{ii},Mouse_name)
            exist_mouse(ii)=ii;
        end
    end
    exist_mouse = exist_mouse(exist_mouse~=0);
    
    % Define cell array of mouse metadata and concatenate that with old
    % metadata
    
    newmetadata     = {Mouse_name,ABF_name,Initial_weight,Tr_day_1_date,Num_tr_days,Reward_pos,TrainingParadigm};
    
    if exist_mouse>0 % ask user if he wants to overwrite the existing entry for that mouse
        reply = input('Do you want to overwrite the metadata, replacing metadata for a pre-existing mouse? [Y/N]: ', 's');
        if strcmp(reply,'Y')
            old_metadata(exist_mouse,:) = newmetadata;
            mouse_metadata = old_metadata;
        end
    else % mouse doesn't exist: create new entry
        mouse_metadata  = [old_metadata;newmetadata];
    end
    
    % Save appropriate variables to individual mouse training file:
    % Initiate variables
    
    Num_Tr_day       = zeros(Num_tr_days,1);
    Date             = cell(Num_tr_days,1);
    ABF_temp         = cell(Num_tr_days,1);
    ABF              = cell(Num_tr_days,1);
    Weight           = zeros(Num_tr_days,1);
    Sustenance_given = zeros(Num_tr_days,1);
    Reward_action    = cell(Num_tr_days,1);
    Lever_distance   = zeros(Num_tr_days,1);
    Hold_time        = zeros(Num_tr_days,1);
    Randomisation    = zeros(Num_tr_days,1);
    Num_rewards      = zeros(Num_tr_days,1);
    Training_mode    = zeros(Num_tr_days,1); 

    
    for day_ID = 1:Num_tr_days
        Num_Tr_day(day_ID)       =  day_ID;
        Date(day_ID)             =  TXT(6*(day_ID-1)+29,1);
        ABF_temp{day_ID}         =  TXT(6*(day_ID-1)+29,19:20); % For the option to concatenate two training files
        Weight(day_ID)           =  RAW{6*(day_ID-1)+29,7};
        Sustenance_given(day_ID) =  RAW{6*(day_ID-1)+29,8};
        Reward_action(day_ID)    =  TXT(6*(day_ID-1)+29,16);
        Lever_distance(day_ID)   =  RAW{6*(day_ID-1)+30,14};
        Hold_time(day_ID)        =  RAW{6*(day_ID-1)+29,14};
        Randomisation(day_ID)    =  RAW{6*(day_ID-1)+31,14};
        Num_rewards(day_ID)      =  RAW{6*(day_ID-1)+34,15};    
        Training_mode(day_ID)    =  RAW{6*(day_ID-1)+30,16};
        
        % Code below for spreadsheets of mice that were NOT water
        % restricted for 10 days prior to start of training
%         Date(day_ID)             =  TXT(6*(day_ID-1)+25,1);
%         ABF_temp{day_ID}         =  TXT(6*(day_ID-1)+25,19:20); % For the option to concatenate two training files
%         Weight(day_ID)           =  RAW{6*(day_ID-1)+25,7};
%         Sustenance_given(day_ID) =  RAW{6*(day_ID-1)+25,8};
%         Reward_action(day_ID)    =  TXT(6*(day_ID-1)+25,16);
%         Lever_distance(day_ID)   =  RAW{6*(day_ID-1)+26,14};
%         Hold_time(day_ID)        =  RAW{6*(day_ID-1)+25,14};
%         Randomisation(day_ID)    =  RAW{6*(day_ID-1)+27,14};
%         Num_rewards(day_ID)      =  RAW{6*(day_ID-1)+30,15};
%         Training_mode(day_ID)    =  RAW{6*(day_ID-1)+26,16};
    end
    
    % Reshape the ABF array to be more useful
    ABF_temp = reshape([ABF_temp{:}],[2,Num_tr_days])';
    for day_ID = 1 : Num_tr_days
        if or(strcmp(ABF_temp{day_ID,2}(regexp(ABF_temp{day_ID,2},'.abf')),'.')==1, ...
                or(strcmp(ABF_temp{day_ID,2}(regexp(ABF_temp{day_ID,2},'.mat')),'.')==1, ...
                strcmp(ABF_temp{day_ID,2}(regexp(ABF_temp{day_ID,2},'.daq')),'.')==1))
            [concat_filename] = abfconcat_2x15(ABF_temp{day_ID,1});
            ABF{day_ID} = concat_filename;
        else
            ABF{day_ID} = ABF_temp{day_ID,1};
        end
    end
    
    % Loop to pick up non trained days:
    
    for day_ID = 1 : Num_tr_days
        if      strcmp(ABF{day_ID}(regexp(ABF{day_ID},'.mat')),'.')==1
        elseif  strcmp(ABF{day_ID}(regexp(ABF{day_ID},'.daq')),'.')==1
        elseif  strcmp(ABF{day_ID}(regexp(ABF{day_ID},'.abf')),'.')==1
        else
            ABF{day_ID} = NaN;
        end
    end
    
    
    % Define cell array of individual mouse parameters
    mouseolddata={'Num_Tr_day','Date','ABF','Weight','Sustenance_given', ...
        'Reward_action','Lever_distance','Hold_time','Randomisation', ...
        'Num_rewards','Training_mode'};
    
    newmousedata = [num2cell(Num_Tr_day)';Date';ABF';num2cell(Weight)'; ...
        num2cell(Sustenance_given)';Reward_action';num2cell(Lever_distance)'; ...
        num2cell(Hold_time)';num2cell(Randomisation)';num2cell(Num_rewards)'; ...
        num2cell(Training_mode)']';
    
    mouse_data=[mouseolddata;newmousedata];
    
    end
    
   
     
    
    %% Save data
    
    pathfolder=metadataPath; %Change path
    cd(pathfolder);
    
    % Save mouse_metadata to the metadata .mat file
    
    fprintf('Imported training sheet for mouse %s \n',Mouse_name);
    
    if exist_mouse == 0
        
        reply = input('Do you want to save the metadata (appending to the exisitng metadata)? [Y/N]: ', 's');
        
        if isempty(reply)
            reply = 'N';
        end
        
        if strcmp('Y',reply)
            save('Lever_training_cued_metadata.mat','mouse_metadata');
        end
    else
        save('Lever_training_cued_metadata.mat','mouse_metadata');
    end
    
    % Save mouse_data to individual .mat file
    
    filename=sprintf('/%s.mat',Mouse_name);
    all_mouse_data=strcat(metadataPath,filename); %Change path
    
    if exist(all_mouse_data,'file')
        
        reply2 = input('Do you want to save the individual mouse data (overwriting the existing file?)? [Y/N]: ', 's');
        
        if isempty(reply2)
            reply2 = 'N';
        end
        
        if strcmp('Y',reply2)
            save(all_mouse_data,'mouse_data');
        end
    else
        save(all_mouse_data,'mouse_data');
        
    end
    
    
end

cd(pwd);