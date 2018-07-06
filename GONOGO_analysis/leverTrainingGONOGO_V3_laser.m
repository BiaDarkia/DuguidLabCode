%% Script to analyse lever training data
% Script to analyse the sensor and reward signal data collected
% throughout the course of behavioural training. To be used in conjunction
% with excelloadergonogo to input excel training record data.

% Once the metadata of each mice are loaded using excelloaderGonogo, a few
% options are given to the user to set up the analysis (e.g. which animals
% to analyse, whether you're re-analysing these mice or not...).

clear all


%% Settings

mouseVec = [2]; % Mouse IDs to loop over (lines of Lever_training_cued_metadata.m file)

DelayCheck = 0; % =1 --> delay present, =0--> delay absent. 
                %The trial by trial analysis changes wether or not a delay is present in the training paradigm.
                
Reanalyse = 0;  % Not compatible with Opto option
% This option is used to save time if mice are being analysed multiple
% times during training. If you have analysed the mice previously, by
% setting "Reanalyse = 1" the analysis will skip the days that have already
% been analysed. To do so it will ask you to provide the folder where you
% saved the _analysed files for these mice. This option sometimes gives
% problem, in which case run the analysis again but with "Reanalyse = 0". 

CentralPartOfBehaviour = 1; % =1 to analyse only a give part of the training session (e.g. first 30 mins, see line 110). 
        CutStart = 0.01; % 0.n where n is what % of the session you want to cut at the beginning (e.g. 0.1 --> cutting first 10% of session)
        CutEnd = 0.51; % 0.n where n is what % of the session you want to cut at the end (e.g. 0.5 --> cutting last 50% of session)
        % if CentralPartOfBehaviour = 1 the analysis will only consider the
        % portion of the ABF file between CutStart and CutEnd

%% DEV MOD
% This can be used to more easily debug the code if changes have been made
% to it or problems aryse. It gives you different option to automatically
% stop the analysis in different places and generate plots that can be used
% to check that the output is corret. 

dev_mod_tot = 0;  % =1 to launch in dev_mod ON, = 0 dev_mod OFF

if dev_mod_tot == 1     % Different options... "Y" to have an option ON, "N" to have it OFF
    question_trials =        'Y';      % Plots the result of the trial by trial analsis 
    question_timed_stuff =   'N';      % Plots the analysis of the timed analysis 
    question_waves =         'N';      % Plots the whole ABF data for each day (To check if there's anything funky with the file)
else
    dev_mod = 0;
end

%% Constants 
% (used for the analysis, it shouldn't be necessary to change these)
sample_rate=    1000;   % Sample rate (Hz)
sensor_th=      2.5;      % Threshold for sensor state change
tone_th=        0.1;        % Threshold for detecting tone
TimedBins =     6;      % Number of time bins in which to divide each training session for timed analysis (usually 6);if changed also change in PlottingGoNogo.m line 27
%% Load Cued Metadata 
% Load the metadata generated with excelLoaderGONGO
[mouse,trainingsettings,filename] = loadCuedMetadataGonogo;  

%% Analyse behavioural data for each GoNogo animal
for mouseID=mouseVec   % mouseID loops through the list of mice to analyse (mouseVec) specified in the Settings section
    %% Prepare the analysis and check if re-analysing
    % load data relative to the mouse
    fprintf(' ===============================\n ===============================\n '); 
    [date,weight,trainingdata] = findMouseCuedGONOGO(mouse.name{mouseID}, trainingsettings, mouseID);
    num_days = length(date.date); % Number of training days
    
    % Avoid re-analysing stuff ( if reanalyse == 1 in Settings section)
    if  Reanalyse == 1
        if mouseID == mouseVec(1)  % first mouse being analysed --> ask to find data of previous analysis
            AnalysedDir     =   uigetdir('/Users/federicoclaudi/Documents/MATLAB/LeverData', 'Where are the analysed files?');
            files           =   what(AnalysedDir);
            files           =   files.mat;
            numFiles        =   length(files);
        end
        
        for f = 1:numFiles % loop through _analysed files and load the correct one for the mouse being analysed, then check number of days to skip
            checkname = sprintf('%s_analysed.mat',mouse.name{mouseID});
            if strcmp(checkname, files(f))
                [num_days_analysed] = ChechAnalysedDays(checkname); % check number of analysed days
            end
        end
    else % not re-analysing --> do all days
        if mouseID == mouseVec(1) % If first mouse, ask for folder in which to save the data
            AnalysedDir = uigetdir('/Users/federicoclaudi/Documents/MATLAB/LeverData', 'Where to save?');
        end
        num_days_analysed = 0; % analyse all days
    end
    
    % Defining variables before analysis. It's different whether or not
    % you're re-analysing the data. 
    if Reanalyse ~= 1
        [all_var] = defineAllVar_GoNogo(num_days, mouse, mouseID, TimedBins);  % Create new empty variables
    else
        old_var = load(checkname);  % load variables from data relative to previous analysis
        old_var = old_var.all_var; 
        ResaveAllVarGonogo % Merge the two sets of var
        %ResaveAllVarOutputGonogo % Merge the two sets of var
    end
    
    %% For the current mouse, loop over single days
    % Get first day of Mode 2 training (to skip mode 1)
    Mod2startday = find(trainingdata.tr_mode > 1,1);
    % If not specified assume it's day 1
    if isempty(Mod2startday)
        Mod2startday = 1;
    end
    
    % Loop over days
    if num_days_analysed ~= num_days % if you're re-analysing check if there's days that haven't been analysed yet
        for dayID = num_days_analysed+1:num_days % loop over days
            if dayID >= Mod2startday  % only analyse the data in which the mouse was trained in mode 2
                
                filename=date.ABF{dayID};   % name abf file for that day

                if exist(filename,'file')
                    %% Setting up day analysis and handling files
                    LoadABfTime = tic; % keep track of the time that takes to load the file and to analyse it
                    TotTime     = tic;
                    
                    %load the ABF file
                    ABF=loadAbfData(filename);
                    toc(LoadABfTime);
                    
                    % Option for analysing only part of the training
                    % session (set in Settings section)
                    if CentralPartOfBehaviour == 1  % Analyse only a part of the behaviour
                        ABF = ABF((size(ABF,1)*CutStart):(size(ABF,1)*CutEnd),:);
                    end
                    
                    % Handle ABF file
                    file_length   = length(ABF);    % File length in data points
                    file_length_s = round(file_length/sample_rate); % File length to the nearest second
                    day_length    = round(file_length_s/60);
                    
                    % Get vectors out of ABF  or DAQ file
                    %%%% Need to check here if the file we are loading
                    %%%% is a DAQ (training boxes) or an ABF (lever
                    %%%% training) and label the AbfWaves accordingly
                    
                    if ~isempty(strfind(date.ABF{dayID},'.daq'))
                        % It's a daq file
                        [sensor_trigger_vec, sensor_reward_vec, reward_signal_vec, reset_vec, tone_vec, light_vec] = ...
                            labelAbfWaves_Gonogo(ABF, sensor_th, tone_th, date.ABF{dayID});
                        
                        % Check if this is an opto-day  and which apparatus was used
                        [Apparatus, Opto] = CheckIfOpto(date.ABF{dayID}); 
                    else
                        % It's an ABF file
                        if size(ABF,2) == 6
                             [sensor_trigger_vec, sensor_reward_vec, reward_signal_vec, reset_vec, tone_vec] = ...
                                labelAbfWaves_Gonogo(ABF, sensor_th, tone_th, date.ABF{dayID});
                            Apparatus = 1;  % No need to check using CheckIfOpto for this case
                            Opto = 0; 
                        elseif size(ABF,2) == 7
                            [sensor_trigger_vec, sensor_reward_vec, reward_signal_vec, reset_vec, tone_vec,  shutter_vec, laser_vec] = ...
                                labelAbfWaves_Gonogo(ABF, sensor_th, tone_th, date.ABF{dayID});
                            
                            % Check if this is an opto-day  and which apparatus was used
                            [Apparatus, Opto] = CheckIfOpto(date.ABF{dayID}, laser_vec); 
                        else
                            error('The ABF file format is not recognised, please contact federicoclaudi@gmail.com'); 
                        end
                    end
                    
                    % Option for dev_mod
                    if dev_mod_tot == 1 && Opto % Ask user if you want to start the dev mode for each day, only if selected as ON in the settings area
                        % Dev mod stops the analysis at every loop iteration slowing
                        % things downs. If you know you are only interest
                        % in one day, you can switch dev_mod off for the
                        % others
                        Today = input('Do you want to launch Dev Mod for this day. [Y/N]\n','s');  % "N" to switch dev_mod OFF for this day
                        if strcmp(Today,'Y') == 1
                            dev_mod = 1;
                            if question_waves == 'Y'
                                PlotAbfWaves
                                PlotVecs
                                tilefigs
                                pause;
                            end
                        else
                            dev_mod = 0;
                        end
                    else
                        dev_mod = 0;
                    end
                    
                    % Initialises variables used later for the analysis but
                    % not used for analysis
                    InitialiseVariablesGONOGO;
                    
                    % Clear some variables for every dayID - gives errors
                    % otherwise
                    ClearVarsGONOGO
                    
                    % Find the times at which each tone starts (and ends) durig the
                    % session. Used for outlining the trials to analyse. 
                    [tone_starts, tone_ends, num_tones] = FindToneStartV2(tone_vec);
                                        
                    %% Trial by trial analysis %%%%%%%%%
                    % Here is where the analysis really happens. 
                    % Each trial is defined as the period between two
                    % consecutive tones. The analysis will loop over such
                    % trials and analyse each one of them individually.
                    % The analysis is done in TrialAnalysisV2
                    for t = 1 :length(tone_starts)
                        TrialVecs; % cut the data vecs to select just each trial and determine if its a Go or Nogo trial
                        TrialAnalysisV3; % See what happens during the trial
                        afterOptostimTrials_effects;  % get performance on 1st, second and third trial after opto stim
                    end
                    
                    %% Check for empty vars
                    % If for instance a mouse doesn't do false alarms, we
                    % need to create place holder variables. 
                    Gonogo_CheckVars
                    
                    %% Timed analysis of task performance
                    % Uses the number of Bins specified in the Constants
                    % section to divide the session and measure the
                    % performance in each bin.
                    Gonogo_timedAnalysis

                    %% Rearrange variables
                    RearrangeVariables
                    
                    %% Discrimination and Bias Indexes
                    % Calculate D.I. and B. 
                    DiscrAndBiasIndex
                    
                    %% Avg. Time and Num Trials between Correct Trials
                    AvgTimeToCorrectTrial
                    
                    %% Redefine all variables to save them:
                    PrepVariablesToSave;
                    toc(TotTime) % analysis finished for this day, stop timer!
                    
                else
                    fprintf('Unable to find file %s...',filename);
                end
            end
        end
    end
    
    %% Save results
    saveAllVar_Gonogo(mouseID, mouse, all_var, AnalysedDir)
    %saveAllVarOutput_Gonogo(mouseID, mouse, all_varOutput, AnalysedDir)
end

