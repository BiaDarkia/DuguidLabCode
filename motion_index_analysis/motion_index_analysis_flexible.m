%% Motion index analysis %%
% Written by Paolo Puggioni and edited by Joshua Dacre

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to calculate the motion index of a video file. Motion index is a %
% measure of change in pixel intensities from one frame of a video to the %
% next.                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Steps to calculate the motion index for a selection video files:        
% 1 - Place all video files in one folder and change video_data_path below
% 2 - Any name works                                  
% 3 - Create the file movie_list.txt cataloguing the files you want analysed 
% 4 - Add this folder to your Matlab path
% 5 - Run this script and choose your region of interest in each video,
% selecting the lower right corner then the upper left corner of the
% bounding box
% 6 - Once analysed, rename your .txt file as only one file with this name
% can exist in your Matlab path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initiate script:
clearvars
close all

% User defined parameters
num_vid_to_analyse=1;                                             % ***** Edit this value *****

% Import video_list.txt indexing information
video_data_path =  sprintf('/Volumes/Julia_muscimol_2017_2/GoNoGo_170921_muscimol_videos');       % ***** Edit this value *****
%video_data_path =  sprintf('/Volumes/Julia_muscimol_2017/Julia/Julia_Go-NoGo_muscimol_videos/Trainingbox_muscimol_170921');
save_path       = sprintf('/Users/julia 1/Documents/MATLAB/PawTracking/');
vidname  = sprintf('mouseF_day22_20171013_09-50-41.avi');
% video_list      = strcat(video_data_path,'video_list');
% fid             = fopen('video_list.txt');
% text_data       = fscanf(fid, '%u', [1 inf]);
% fclose(fid);
% text_data=text_data';

% Preallocate for speed
xrange = zeros(num_vid_to_analyse,2);
yrange = zeros(num_vid_to_analyse,2);

% Define your ROI for each video
vidID=0;
while vidID < num_vid_to_analyse
    vidID    = vidID+1;
    
%     vidname  = sprintf('%s'  , text_data(vidID));
    [xrange(vidID,:), yrange(vidID,:)] = define_roi_flexible(vidname);
    close all
end

% Calculate the motion index of each video and each ROI
vidID=0;
while vidID < num_vid_to_analyse
    vidID    = vidID+1;
%     vidname  = sprintf('%s'  , text_data(vidID));
    
    [timevid,motionindex] = make_motion_analysis_flexible(vidname,save_path,xrange(vidID,:),yrange(vidID,:));
      
end