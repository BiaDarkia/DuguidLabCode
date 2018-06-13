function [ pushes_starts, pushes_ends, num_pushes ] = FindPushes( trial_trigger_sensor )
%Find the times at which pushees start and end wihtin one trial
trial_trigger_sensor_neg = -trial_trigger_sensor(2:length(trial_trigger_sensor)); 
trial_trigger_sensor_pos = trial_trigger_sensor(1:legth(trial_trigger_sensor)-1); 
summa_trigger = trial_trigger_sensor_pos + trial_trigger_sensor_neg; 

pushes_starts = find(summa_trigger<0); 
pushes_ends = find(summa_trigger>0); 
num_pushes = size(pushes_starts,1); 


end

