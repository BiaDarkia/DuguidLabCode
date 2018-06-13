function [mouse,trainingsettings,filename]  =  loadCuedMetadataGonogo
%Function to load general metadata for training group or groups of mice
%   Data loaded includes mouse names, initial weights, number of training
%   days, position of reward zone (front/back) and type of lever action (pull, push,
%   pushpull etc.)

currentfolder  = pwd;
mouse_metadata = [];

MetaPathList
pathfolder     = loadCuedMetadataPathfolder;

filename = sprintf('Lever_training_cued_metadata.mat');
fprintf('Trying to open file: %s%s \n',pathfolder,filename)

if exist(filename,'file')
    
    load(filename)
    
    mouse.name                   = mouse_metadata(:,1);
    mouse.ABF                    = mouse_metadata(:,2);
    mouse.init_weight            = mouse_metadata(:,3);
    trainingsettings.day1date    = mouse_metadata(:,4);
    trainingsettings.numdays     = mouse_metadata(:,5);
end

cd(currentfolder);
end