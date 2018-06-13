%% Set up variables
% Check if there is a reward in the trial
if isempty(find(trial_reward))
    RewCheck = 0;
else
    RewCheck = 1;
end

% Various flags used for the analysis
push                    = 0;
HIT_check               = 0;
FA_check                = 0;
PE_ITI                  = 0;
pushSRT                 = 0;
pushCMPLT               = 0;
miss_trial              = 0;
CorrectRejection_trial  = 0;
delay_trial             = 0;
RewardedPush            = 0;
PECheck                 = 0;
PEComplete              = 0;
CorrectCheck            = 0;



%% Analysis of the trial millisec by millisec
for i = 2:length(trial_tone)
    if trial_trigger_sensor(i) == 1 && trial_trigger_sensor(i-1) == 0 % A push was started
        
        push = push+1;  % counts pushes and gets the time at which they happened.
        RT_pushes(push+Push_tot) = i; % Not used at the moment
        
        if push == 1 %First push of the trial
            
            if trial_type ~= 1 %NOGO trial --> FA or preemptive
                if RewCheck == 0 % There hasn't been a reward it must be a False Alarm (otherwise it's preemptive ITI)
                    FA_check = 1;
                    RT_FA_trial = i;
                else
                    if trial_reset(i-3) == 0 && trial_reward(i) == 0;  % PE ITI
                        PE_ITI = PE_ITI + 1;
                        PECheck = 1; % A PE was started, we need to see if it's a full push or not
                        PE_ITI_times(PE_ITI + Preemptives_ITI) = i+ tone_starts(t);
                    end
                end
                
            elseif  trial_type ~= 0 %GO trial
                if trial_light(i) == 1  % During response window --> it could be a hit
                    pushSRT = 1; % Flag that signal push is started during GO window
                    RT_hit_trial = i;
                else % After response window --> must be a preemptive
                    PE_ITI = PE_ITI + 1;
                    PECheck = 1; % A PE was started, we need to see if it's a full push or not
                    PE_ITI_times(PE_ITI + Preemptives_ITI) = i+ tone_starts(t);
                end
            end
            
            
        else  % not the first push of the trial but might still be during response window
            if trial_type ~= 0 && RewCheck == 1 % Rewarded Go trial
                % Need to check if it's a double push during reward
                if pushSRT == 0 && pushCMPLT == 0 && RewardedPush == 0 && sum(trial_reward(1:i)) == 0 %We're before the reward
                    % Not during already started push, not after completed/rewarded push, must be during response window.
                    pushSRT = 1;
                    RT_hit_trial = i; % Correct to take this as RT?
                elseif trial_reset(i-3) == 0 && sum(trial_reward(1:i)) > 0; % PE ITI
                    PE_ITI = PE_ITI + 1;
                    PECheck = 1; % A PE was started, we need to see if it's a full push or not
                    PE_ITI_times(PE_ITI + Preemptives_ITI) = i+ tone_starts(t);
                end
            else % Otherwise it must be a PE ITI
                PE_ITI = PE_ITI + 1;
                PECheck = 1; % A PE was started, we need to see if it's a full push or not
                PE_ITI_times(PE_ITI + Preemptives_ITI) = i+ tone_starts(t);
            end
        end
        
    end
    
    if pushSRT ==  1 && trial_reward_sensor(i) == 0  % lever just reached front sensor after push in GO wind
        pushSRT = 0;
        pushCMPLT = 1; %Flag that signals a complete push during GO window
    end
    
    if pushCMPLT == 1  && trial_reward(i) == 1 % being rewarded after a complete push in the Go wind
        pushCMPLT = 0;
        HIT_check = 1;
        RewardedPush = 1;
    end
    
    if PECheck == 1 && trial_reward_sensor(i) == 0  % lever just reached front sensor after preemptive push
        PEComplete = PEComplete + 1; % Keep track of how many PE were complete pushes
        PECheck = 0;
    end
end

if PE_ITI > 0
    a = 1;
end
PEPartial = PE_ITI - PEComplete; % Count how many of the PEs were incomplete
Push_tot = Push_tot + push;

%% Results of the trial analysis
% Get final values of counters and save them to variables

% Get the outcome of the trial
if trial_type == 1 % GO trial
    
    if HIT_check == 1
        Hit = Hit + 1;
        CorrectCheck = 1; % Used to track how much time it passed between consecutive correct trials
        Reaction_time_Hit(Hit) = RT_hit_trial;
        Hit_times(Hit) = tone_starts(t);
    else
        Miss = Miss + 1;
        miss_trial = 1;
        Miss_times(Miss) = tone_starts(t);
    end
    
else % NOGO trial
    
    if FA_check == 1
        FalseAlarm = FalseAlarm + 1;
        Reaction_time_FA(FalseAlarm) = RT_FA_trial;
        FA_times(FalseAlarm) = tone_starts(t);
    else
        CorrectRejection = CorrectRejection + 1;
        CorrectCheck = 1; % Used to track how much time it passed between consecutive correct trials
        CorrectRejection_trial = 1;
        CR_times(CorrectRejection) = tone_starts(t);
    end
    
end

if PE_ITI ~= 0
    Preemptives_ITI = Preemptives_ITI + PE_ITI;
    Preemptives_ITI_Complete = Preemptives_ITI_Complete + PEComplete;
    Preemptives_ITI_Incomplete = Preemptives_ITI_Incomplete + PEPartial;
end

%% Get timestamp for correct trials 
if CorrectCheck == 1
    CorrectTimes(t) = tone_starts(t);
    CorrectCheck = 0;
else
    CorrectTimes(t) = 0;
end

%%
%%
%% Dev mod stuff
if dev_mod == 1 && question_trials == 'Y'
    
    % plots the data relative to the trial + ouputs the results of the
    % analysis and waits for the user to press any key before continouing
    % with the next trial
    
    close all
    
    figure;
    plot(trial_trigger_sensor +8); hold on; plot(trial_reward_sensor+6); hold on;
    plot(trial_reward +4); plot(trial_reset+2); plot( trial_light); plot(trial_tone-2);
    legend('Trigger sensor', 'reward sensor', 'reward', 'lever', 'light', 'tone');
    
    if HIT_check ~= 0
        text(5000, 5, 'HIT', 'FontSize', 14, 'Color', 'b');
        text(5000, 3, num2str(Hit),'FontSize', 14, 'Color', 'b');
    elseif CorrectRejection_trial == 0 && FA_check == 0
        text(5000, 5, 'Miss', 'FontSize', 14, 'Color', 'b');
    end
    
    if FA_check == 1
        text(5000, 5, 'FA', 'FontSize', 14, 'Color', 'r');
    elseif CorrectRejection_trial == 1
        text(5000, 5, 'CR', 'FontSize', 14, 'Color', 'r');
    end
    
    
    fprintf(' *********************************************\n Trial %d of %d \n', t, length(tone_starts));
    
    push
    RewCheck
    PE_ITI
    PEComplete
    PEPartial
    
    delay_trial
    trial_tone_length
    if CheckLight ~= 0
        CheckLight
    end
    if push ~= 0
        push
    end
    
    
    if HIT_check ~= 0
        HIT_check
        Hit
        Reaction_time_Hit(Hit)
    else
        miss_trial
        Miss
    end
    
    
    if FA_check == 1
        FA_check
        Reaction_time_FA(FalseAlarm)
        FalseAlarm
    else
        CorrectRejection_trial
    end
    
    PE_delay
    PE_ITI
    
    tilefigs
    
    
    fprintf('Press a key to continue\n');
    pause;
    tilefigs
end
























