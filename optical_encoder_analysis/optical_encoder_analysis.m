%% Optical encoder analysis %%
% Written by Paolo Puggioni and edited by Joshua Dacre

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to analyse mouse movement data recorded using an optical encoder %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script analyses data collected in pClamp and saved as an .abf
% file. To use script you must know the radius of your treadmill, the 
% cycles per revolution of your optical encoder, the sample rate of your
% recording, and the position within the abf of your optical encoder data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initiate script:
clearvars
close all

global TIMEPERBIN

% User defined parameters
start_analysing = 0;     % in seconds
stop_analysing  = 90;    % in seconds

sample_rate     = 10000; % Sample rate of recording equipment
TIMEPERBIN      = 1/sample_rate;

optencset.cpr   = 250;   % cycle per revolution of the optical encoder
radius          = 10;    %radius of the treadmill in cm

optenc_wave1    = 2;     % Define which wave of your abf data corresponds to the first optical encoder wave
optenc_wave2    = 3;     % Define which wave of your abf data corresponds to the second optical encoder wave

%% Set path to the folder containing optical encoder data
currentfolder = pwd;
optenc_data_path = sprintf('/Users/s1269481/Documents/MATLAB/Optical Decoder Analysis/Test/'); % ***** Edit path *****
cd(optenc_data_path)

% Decide whether to analyse one abf file or a folder of abf files
file_or_folder = input('Do you want to load a single file (f) or a folder (F)?:', 's');

if file_or_folder == 'f'
    
    optenc_filename=uigetfile('*.*');
    optencList = 1;
    
elseif file_or_folder == 'F'
    
    directory_name  =   uigetdir;
    files           =   dir(directory_name);
    fileIndex       =   find(~[files.isdir]);
    numFiles        =   length(fileIndex);
    optencList      =   zeros(1,numFiles);
    
    for file_ID = fileIndex
        if ~isempty(regexp(files(file_ID).name,'.abf', 'once'))
            optencList(file_ID) = 1;
        end
    end
    
    optencList      = find(optencList == 1);
    
end

for file_ID=optencList
    
    if length(optencList)>1
        optenc_filename = files(file_ID).name;
        cd(directory_name)
    end
    
    rawdata = abfLoad2(optenc_filename);
    
    
    % Analyse only over selected period defined by user
    
    start_bin_analysis = max(1,round(start_analysing./TIMEPERBIN));
    stop_bin_analysis  = min(round(stop_analysing./TIMEPERBIN),length(rawdata));
    
    rawdata = rawdata((start_bin_analysis:stop_bin_analysis),:);
    rawdata_optenc1 = rawdata(:,optenc_wave1);
    rawdata_optenc2 = rawdata(:,optenc_wave2);
    
    % Define a vecotr of time points
    [npoints,~] = size(rawdata);
    time = TIMEPERBIN * (1:npoints);
    
    
    %% Analyse optical encoder information and plot results
    [speed,position] = opticaldecoder(rawdata_optenc1,rawdata_optenc2,optencset,radius);
    
    figure
    plot(time,speed,'LineWidth',3);
    xlabel('time (sec)','FontSize',30);
    ylabel('speed (cm/sec)','FontSize',30);
    set(gca,'FontSize',25)
    
end