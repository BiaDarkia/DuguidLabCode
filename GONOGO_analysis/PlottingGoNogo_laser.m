clear all
%close all

%% Intro
% This function regulates the plotting of the perfomance of mice trained
% with the Gonogo task. It's used to plot the data generated through the
% LeverTrainingGonogo script. 

% The script asks you to identify the folder in which the _analysed files
% are saved as a result of levertrainingGONOGO_V3 analysis. Then it
% generates plots based on the options specified below. 

%% Setings
% In this section you can choose which plots will be generated in addition
% to the standard plot for each mouse. 
PlotHRvsFARcheck = 1; % if =1 plots for each mouse in each session the hit ratio vs false alarm ratio timed, used to check how motivation and discrimination
                            % vary for each mouse within sessions    
Plot_cohort = 0; %=1 to plot a summary figure of the whole cohort (old code, might not work)                            
                          
% Additional set up info
ScreenCheck = 'Main';  % Can be either 'Main' or 'Ext', necessary to sort figures at the of plotting on main of external screen


%% Handling files
% asks to open the directory in which the files to plot with the data are
% saved and gets the list of files present
directory_name  = uigetdir;
files           = dir(directory_name); 
fileIndex       = find(~[files.isdir]);
numFiles        = length(fileIndex);
matList         = zeros(1,numFiles);

for file_ID = fileIndex
    if ~isempty(regexp(files(file_ID).name,'.mat', 'once'))
        matList(file_ID) = 1;
    end
end

matList           = find(matList == 1);
numMatFiles       = length(matList);
search_dir        = dir(directory_name);
search_dir_struct = struct2cell(search_dir);


%% Plotting
% For each file generate plots according to specified options
 
for mouse_ID = 1:numMatFiles; %for each mouse ...
    
    % Select right file and load data
    currentfolder=pwd;
    cd(directory_name);
    filename = files(matList(mouse_ID)).name;
    load(filename);    
    
    %% Get Training rig and Opto info
    % We find the first day the mice have been moved to the rig (.abf file,
    % see analysis scripts) so that we can highlight that in the plots
    num_days                                                            = length(all_var.training_length);
    apparatusRecord                                                     = all_var.day_apparatus; 
    optoRecord                                                          = all_var.day_opto; 

    firstDayonRig = find(apparatusRecord,1); 
    if firstDayonRig > 1
        firstDayonRig = firstDayonRig - 0.6; 
    end
    if isempty(firstDayonRig)   
        firstDayonRig = num_days+1;
    end

    % Check if there were opto days
    if ~isempty(firstDayonRig)
        firstOptoDay = find(optoRecord, 1); 
        if isempty(firstOptoDay)
           lastNonOptoDay = firstDayonRig;  % Used to set axes when plotting and select correct variable ranges when plotting opto data
        else
            lastNonOptoDay = firstOptoDay - 1; 
        end
    end
    
    %% Handling variables loaded
    GettingVarPlottingGONOGO
    fprintf('Plotting %s...\n', MouseName);

    % Main individual mouse plot (summary)
    PlottingIndividuals_GONOGO_Combined

    if ~isempty(find(optoRecord,1)) % There have been some opto days        
        PlottingIndividuals_GONOGO_Combined_Opto
    end
    

    % HR vs FAR ratio
    if PlotHRvsFARcheck == 1
        PlotHRvsFAR;
    end    
    
    fprintf(' ===============================\n ===============================\n');
end

if Plot_cohort == 1 %Old code, might have bugs that still need to be fixed. 
    PlotCohortCombined
end
    
%% conclusion
tilefigs; 

