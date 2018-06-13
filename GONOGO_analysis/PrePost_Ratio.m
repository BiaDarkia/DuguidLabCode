%% Script to convert analysed behavioural file into format suitable for export to graphpad

close all

%% POI library

javaaddpath('/Users/federicoclaudi/Documents/MATLAB/matlab_R2015b_maci64/java/jar/poi_library/poi-3.8-20120326.jar');
javaaddpath('/Users/federicoclaudi/Documents/MATLAB/matlab_R2015b_maci64/java/jar/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('/Users/federicoclaudi/Documents/MATLAB/matlab_R2015b_maci64/java/jar/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('/Users/federicoclaudi/Documents/MATLAB/matlab_R2015b_maci64/java/jar/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('/Users/federicoclaudi/Documents/MATLAB/matlab_R2015b_maci64/java/jar/poi_library/dom4j-1.6.1.jar');


%% script determinats

timed = 1; % Set to 1 to extract the data fort the timed stuff

individuals_timed = 0;   % Set 1 to plot the individual's track in the timed stuff graphs
prompts = 1; % 1 for ON - 2 for OFF
count = 1; % used in prompts







%% Folder and files



% directory_template:  /Users/federicoclaudi/Documents/MATLAB/LeverData/AnalysedFiles
cd '/Users/federicoclaudi/Documents/MATLAB/LeverData/AnalysedFiles';
[NUM1,TMPL_1,RAW1] = xlsread('ExtractedData - TEMPLATE.xlsx',1);
[NUM2,TMPL_2,RAW2] = xlsread('ExtractedData - TEMPLATE.xlsx',2);
[NUM3,TMPL_3,RAW3] = xlsread('ExtractedData - TEMPLATE.xlsx',3);


% cd directory_name;
if exist('folder_save','var') == 1
    if ~isempty(folder_save)
        directory_name = folder_save;
    else
        directory_name  = uigetdir;
    end
else
    directory_name  = uigetdir;
    
end

cd(directory_name);

if exist('filenameExcel', 'var') ~= 1
    file_ok = 0;
    while file_ok < 1
        
        filename = input('Name of the excel file:\n ', 's');
        filenameExcel = [filename '.xlsx'];
        
        if exist('filenameExcel') == 2
            
            fprintf('There''s already a file named %s.\n',filenameExcel); pause(0.5);
            check = input('Do you wish to overwrite it? [Y/N]\n ', 's');
            if check == 'N';
                file_ok = 0;
                continue
            else
                file_ok = 2;
                continue
            end
        else
            file_ok = 2;
            continue
        end
        
    end

end




files           = dir(directory_name);
fileIndex       = find(~[files.isdir]);
numFiles        = length(fileIndex);
matList         = zeros(1,numFiles);

for file_ID = fileIndex
    if ~isempty(regexp(files(file_ID).name,'.mat', 'once'))
        matList(file_ID) = 1;
    end
end

matList         = find(matList == 1);
numMatFiles     = length(matList);
search_dir = dir(directory_name);
search_dir_struct = struct2cell(search_dir);



% Gives the user the option to plot several graphs, also gives the
% option to choose how should the React Time and Timed graphs look like
if exist('Graphs', 'var') ~= 1

Graphs = input('Do you want to plot? [Y/N]:\n ', 's');
end



page1 = zeros ( 436,17);
page2 = zeros ( 168,15);
page3 = zeros ( 216,15);




%% script to extract the data of each mouse

for mouse_ID=1:numMatFiles;
    
    
    currentfolder=pwd;
    cd(directory_name);
    
    filename = files(matList(mouse_ID)).name
    load(filename);
    
    
    num_days = length(all_var.training_length);
    
    %Preallocate for variables required:
    graphpadOutput = zeros(num_days,17);
    TimedBinnedOutput = zeros(6,num_days);
    
    graphpadOutput(:,1) = all_var.num_rewards; %Rewards
    graphpadOutput(:,2) = all_var.tone_efficiency; % Tone efficiency
    graphpadOutput(:,3) = all_var.action_efficiency; % Action efficiency
    graphpadOutput(1:length(all_var.median_reaction_time),4) = all_var.median_reaction_time; % Mean reaction time
    graphpadOutput(:,5) = all_var.num_preemptive; % Number of PE
    graphpadOutput(:,6) = all_var.variance_reaction_time; % Variance reaction time
    
    
    if timed == 1
        % Data relative to time-binned performance(numb.rewards)
        
        a = zeros(num_days);
        rew_binned = zeros(num_days,6);
        
        
        for loop = 1: num_days
            
            a = all_var.performance{1,loop};
            
            rew_binned(loop,1) = a(1,1);
            rew_binned(loop,2) = a(1,2);
            rew_binned(loop,3) = a(1,3);
            rew_binned(loop,4) = a(1,4);
            rew_binned(loop,5) = a(1,5);
            rew_binned(loop,6) = a(1,6);
            
        end
        
        % Num of rewards in the first, second and third 10 mins of a training session across days
        
        graphpadOutput(:,7) = rew_binned(:,1)+rew_binned(:,2); % 1st 10 mins
        graphpadOutput(:,8) = rew_binned(:,3)+rew_binned(:,4); % 2nd 10 mins
        graphpadOutput(:,9) = rew_binned(:,5)+rew_binned(: ,6); % 3rd 10 mins
        
        %to obtain data relative to time-binned tone efficiency
        for day_ID=1:num_days
            
            if length(all_var.tone_efficiency_timed{day_ID}) ~= 0
                
                
                TimedBinnedOutput(:,day_ID) = all_var.tone_efficiency_timed{1,day_ID}';
                
            end
        end
        
        
        
        graphpadOutput(:,10) = all_var.num_missed_tones + all_var.num_rewards;
        
        
        graphpadOutput(:,11) = (TimedBinnedOutput(1,:)+TimedBinnedOutput(2,:))/2; % 1st 10 mins
        graphpadOutput(:,12) = (TimedBinnedOutput(3,:)+TimedBinnedOutput(4,:))/2; % 2nd 10 mins
        graphpadOutput(:,13) = (TimedBinnedOutput(5,:)+TimedBinnedOutput(6,:))/2; % 3rd 10 mins
        
        %to obtain data relative to time-binned preemptive failures
        
        
        PE_timed = zeros(num_days,6);
        
        for loopAct = 1: num_days
            
            a = all_var.activity{loopAct};
            b = all_var.performance{loopAct};
            
            if length(a) == length(b)
                PE_timed(loopAct,:) = a - b;
                
            elseif length(a) < length(b)
                
                for ii = 1:length(a)
                    PE_timed(loopAct,ii) = a(ii) - b(ii);
                    
                end
                
            else
                for ii = 1:length(b)
                    PE_timed(loopAct,ii) = a(ii) - b(ii);
                    
                end
                
            end
            
        end
        
        
        
        
        graphpadOutput(:, 15) = PE_timed(:,1) + PE_timed(:,2);
        graphpadOutput(:, 16) = PE_timed(:,3) + PE_timed(:,4);
        graphpadOutput(:, 17) = PE_timed(:,5) + PE_timed(:,6);
        
        
    end
    
    
    ratioRews = graphpadOutput(2,1)/graphpadOutput(1,1)
    
    
    
    
end


