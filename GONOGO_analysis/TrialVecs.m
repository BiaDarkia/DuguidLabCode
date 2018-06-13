% Finds trial start/end time, defines the tone signal for the trial and if
% the trial is a GO or NOGO, creates the vectors relative to the trial
%% Trial start/end time
trial_start_time = tone_starts(t);
if t<length(tone_starts)
    trial_end_time = tone_starts(t+1)-1;
else
    trial_end_time = length(tone_vec);
end

%% Tone GO/NOGO
% Get tone length
trial_tone_length =  tone_ends(t) - tone_starts(t);

tone_sig = tone_vec(tone_starts(t):(tone_starts(t) + trial_tone_length));
if mean(tone_sig) > 0.75
    trial_type = 1; % GO
    tone_num_GO = tone_num_GO + 1;
else
    trial_type = 0; % NOGO
    tone_num_NOGO = tone_num_NOGO +1;
end

%% Trial vecs
% we need to check if we are working on training boxes (DAQ) data or on lever rig
% (ABF) data
trial_trigger_sensor       = sensor_trigger_vec(trial_start_time : trial_end_time);
trial_reward_sensor        = sensor_reward_vec(trial_start_time : trial_end_time);
trial_reward               = reward_signal_vec(trial_start_time : trial_end_time);
trial_reset                = reset_vec(trial_start_time : trial_end_time);

trial_tone                 = tone_vec(trial_start_time : trial_end_time);


if ~isempty(strfind(date.ABF{dayID},'.daq'))
    % It's a daq file
    trial_light                = light_vec(trial_start_time : trial_end_time);
else
    % It's an ABF file
    if Opto
        trial_shutter              = shutter_vec(trial_start_time : trial_end_time);
        trial_laser                = laser_vec(trial_start_time : trial_end_time);
    end
end


%% Check if we are delivering opto stim
if Opto && isempty(strfind(date.ABF{dayID},'.daq')) % MAking sure that it is an opto day
    if trial_end_time - trial_start_time < 600
        num_datapoints = trial_end_time - trial_start_time;
    else
        num_datapoints = 600;
    end
    if ~isempty(find(trial_laser(1:num_datapoints))) % Only look at first 600 datapoints, we are only interest in checking if the laser is on durig the tone
        trial_opto = 1; % We delivered an opto stim this trial
    else
        trial_opto = 0; % No Opto stim
    end
    opto_trials_record(t) = trial_opto;  % it's one when we deliverd stim on the trial and zero otherwise
end

