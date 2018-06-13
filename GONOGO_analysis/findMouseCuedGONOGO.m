    function [date,weight,trainingdata]  =  findMouseCuedGONOGO(Mouse_name,trainingsettings,i)
%Function to load specific training data for an individual mouse
%   Data loaded includes date of each session, weight of mouse during each
%   session, number of times lever action demonstrated, succesful number of
%   rewarded actions, lever travel distance, sensor distance, and reward
%   zone hold time


filename        = sprintf('%s.mat',Mouse_name);

currentfolder   = pwd;

MetaPathList

pathfolder      = findMouseCuedPathfolder;


fprintf('Trying to open file: %s%s \n',pathfolder,filename)

if exist(filename,'file')
    mouse_data = [];
    load(filename)
    
    date.day    = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,1));
    date.date   = (mouse_data(2:trainingsettings.numdays{i}+1,2));
    date.ABF    = (mouse_data(2:trainingsettings.numdays{i}+1,3));
    
    weight.weight             = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,4));
    weight.sustenance_given   = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,5));
    
    trainingdata.Reward_action   = (mouse_data(2:trainingsettings.numdays{i}+1,6));
    trainingdata.Lever_dist      = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,7));
    trainingdata.Num_rewards     = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,8));
    trainingdata.tr_mode         = cell2num(mouse_data(2:trainingsettings.numdays{i}+1,9));
end

cd(currentfolder);
end