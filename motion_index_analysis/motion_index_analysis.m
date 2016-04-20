%% Motion index analysis %%
% Written by Paolo Puggioni and edited by Joshua Dacre

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to calculate the motion index of a video file. Motion index is a %
% measure of change in pixel intensities from one frame of a video to the %
% next.                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Steps to calculate the motion index for a selection video files:        
% 1 - Place all video files in one folder and change video_data_path below
% 2 - Rename the videos with the format: yymmdd_xxx where xxx is a unique 
% file identifier, e.g. 160419_001.mp4                                    
% 3 - Create the file movie_list.txt cataloguing the files you want       
% analysed and place this in the folder with the videos
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

% User parameters
num_vid_to_analyse=1;                                             % ***** Edit this value *****

% Import video_list.txt indexing information
video_data_path = sprintf('/Users/s1269481/Documents/MATLAB/video analysis scripts/Test video/');       % ***** Edit this value *****
video_list      = strcat(video_data_path,'video_list');
fid             = fopen(video_list);
text_data       = fscanf(fid, '%u %u', [2 inf]);
fclose(fid);
text_data=text_data';

% Preallocate for speed
xrange = zeros(num_vid_to_analyse,2);
yrange = zeros(num_vid_to_analyse,2);

% Define your ROI for each video
vidID=0;
while vidID < num_vid_to_analyse
    vidID    = vidID+1;
    date     = sprintf('%d'  , text_data(vidID,1));
    file_num = sprintf('%03d', text_data(vidID,2));
    [xrange(vidID,:), yrange(vidID,:)] = define_roi(date,file_num,video_data_path);
    close all
end

% Calculate the motion index of each video and each ROI
vidID=0;
while vidID < num_vid_to_analyse
    vidID    = vidID+1;
    date     = sprintf('%d',text_data(vidID,1));
    file_num = sprintf('%03d',text_data(vidID,2));
    
    [timevid,motionindex] = make_motion_analysis(date,file_num,video_data_path,xrange(vidID,:),yrange(vidID,:));
      
end