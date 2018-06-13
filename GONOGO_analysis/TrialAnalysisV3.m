%% Intro
% The logic of this script is that each trial (time inbetween two tones)
% can be divided into two phases: the time before the first lever reset and
% the time after. Hit/Misses and FalseAlarms/CorrectRejections can only
% happen after the first reset, preemptives can only happen after reset. 
% By seeing when pushes happen and the context it is possible to accurately
% reconstruct what happened during each trial. 
%% Set up variables
% Check if there is a reward in the trial
if isempty(find(trial_reward))
    RewCheck = 0;
else
    RewCheck = 1;
end

% find time of first lever reset
TfirstReset = find(trial_reset,1); 

% Find number of resets
Resetsvec = trial_reset(2:end) - trial_reset(1:end-1); 
Tresets = find(Resetsvec < 0 ); 

% Find times of push starts 
pushStartsvec = trial_trigger_sensor(2:end) - trial_trigger_sensor(1:end-1); 
if Opto
    TpushStarts = find(pushStartsvec < 0 ); 
else
    TpushStarts = find(pushStartsvec > 0 );
end

% Find times of push completed
pushCompletevec = trial_reward_sensor(2:end) - trial_reward_sensor(1:end-1); 
TpushComplete = find(pushCompletevec < 0 ); 

% Remove complete pushes that might have happened before first push start
% [unsure about their origin]
if ~isempty(TpushComplete)  && ~isempty(TpushStarts) 
    TpushComplete = TpushComplete(TpushComplete > TpushStarts(1));
end
%% No need to analyse much if there hasn't been any push
if isempty(TpushStarts) 
    needToAnalyse = false; 
    if trial_type == 1
        Miss = Miss + 1;
        miss_trial = 1;
        Miss_times(Miss) = tone_starts(t);
        if Opto 
            if trial_opto
                Miss_OptoStim = Miss_OptoStim + 1;
                Miss_times_OptoStim(Miss_OptoStim) = tone_starts(t); 
            else
                Miss_NoStim = Miss_NoStim + 1; 
                Miss_times_NoStim(Miss_NoStim) = tone_starts(t); 
            end
        end
    else
        CorrectRejection = CorrectRejection + 1;
        CorrectRejection_trial = 1;
        CR_times(CorrectRejection) = tone_starts(t);
        CorrectCheck = 1;
        if Opto 
            if trial_opto
                CorrectRejection_OptoStim = CorrectRejection_OptoStim + 1;
                CR_times_OptoStim(CorrectRejection_OptoStim) = tone_starts(t);
            else
                CorrectRejection_NoStim = CorrectRejection_NoStim + 1;
                CR_times_NoStim(CorrectRejection_NoStim) = tone_starts(t);
            end
       end
    end
else
    needToAnalyse = true; 
    
    % Rarely at the beginning of training the lever might not be at the
    % back, that would look like a complete push so we need to check
%     if (~isempty(TpushStarts) && ~isempty(TpushComplete))
%         try
%             while TpushComplete(1) < TpushStarts(1)
%                 TpushComplete = TpushComplete(2:end); % keep removing push completes that happened too soon
%             end
%         catch
%         end
%     end
end

%% Check what happened during trial
% What happened during response window (before first lever reset)
if needToAnalyse
    if trial_type == 1
        % GO trial
        if ~isempty(find(TpushComplete < TfirstReset))  
            % There has been a complete push
            Hit = Hit + 1;
            PushTimes = TpushComplete(TpushComplete < TfirstReset); 
            PushTime = PushTimes(1); 
            PushStartTimes = TpushStarts(TpushStarts < PushTime);    
            PushStartTime = PushStartTimes(end); 
            Reaction_time_Hit(Hit) = PushStartTime;
            Hit_times(Hit) = tone_starts(t);
            CorrectCheck = 1; % Used to track how much time it passed between consecutive correct trials
            if Opto  % Keep track of optogenetics variables 
                if trial_opto
                    Hit_OptoStim = Hit_OptoStim + 1;
                    Reaction_time_Hit_OptoStim(Hit_OptoStim) = PushStartTime;
                    Hit_times_OptoStim(Hit_OptoStim) = tone_starts(t);
                else
                    Hit_NoStim = Hit_NoStim + 1; 
                    Reaction_time_Hit_NoStim(Hit_NoStim) = PushStartTime;
                    Hit_times_NoStim(Hit_NoStim) = tone_starts(t);
                end
            end
       else
            Miss = Miss + 1;
            miss_trial = 1;
            Miss_times(Miss) = tone_starts(t);
            CorrectCheck = 0;
            if Opto 
                if trial_opto
                    Miss_OptoStim = Miss_OptoStim + 1;
                    Miss_times_OptoStim(Miss_OptoStim) = tone_starts(t);
                else
                    Miss_NoStim = Miss_NoStim + 1; 
                    Miss_times_NoStim(Miss_NoStim) = tone_starts(t);
                end
            end
        end

    else
        % NOGO trial
        if isempty(find(TpushComplete < TfirstReset)) && RewCheck == 0
            FalseAlarm = FalseAlarm + 1;
            Reaction_time_FA(FalseAlarm) = TpushStarts(1);
            FA_times(FalseAlarm) = tone_starts(t);
            CorrectCheck = 0;
            if Opto 
                if trial_opto
                    FalseAlarm_OptoStim = FalseAlarm_OptoStim + 1;
                    Reaction_time_FA_OptoStim(FalseAlarm_OptoStim) = TpushStarts(1);
                    FA_times_OptoStim(FalseAlarm_OptoStim) = tone_starts(t);
                else
                    FalseAlarm_NoStim = FalseAlarm_NoStim + 1; 
                    Reaction_time_FA_NoStim(FalseAlarm_NoStim) = TpushStarts(1);
                    FA_times_NoStim(FalseAlarm_NoStim) = tone_starts(t);
                end
            end
        else
            CorrectRejection = CorrectRejection + 1;
            CorrectRejection_trial = 1;
            CR_times(CorrectRejection) = tone_starts(t);
            CorrectCheck = 1;
            if Opto 
                if trial_opto
                    CorrectRejection_OptoStim = CorrectRejection_OptoStim + 1;
                    CR_times_OptoStim(CorrectRejection_OptoStim) = tone_starts(t);
                else
                    CorrectRejection_NoStim = CorrectRejection_NoStim + 1; 
                    CR_times_NoStim(CorrectRejection_NoStim) = tone_starts(t);
                end
            end
        end
    end


    % What happened after first reset (aka preemptives)
    PushesAfterReset = TpushStarts(TpushStarts > TfirstReset); 
    numPE = length(find(Tresets))-1; % need to remove one because the first reset is not due to a preemptive 
    numCompletePE = length(find(TpushComplete >= TfirstReset)); 
    numPartialPE = numPE - numCompletePE; 
    if numCompletePE > numPE
        % sometimes a complete push might happen while the lever is reset,
        % resulting in this condition to be true, but that shouldn't count
        numCompletePE = numPE; 
    end
    if numPE > 0
        Preemptives_ITI = Preemptives_ITI + numPE;
        Preemptives_ITI_Complete = Preemptives_ITI_Complete + numCompletePE;
        Preemptives_ITI_Incomplete = Preemptives_ITI_Incomplete + numPartialPE;
        if numPE == 1
            PE_ITI_times(Preemptives_ITI) = tone_starts(t); 
        else
            PE_ITI_times(Preemptives_ITI +1 - numPE: Preemptives_ITI) = tone_starts(t);
        end
        if Opto 
            if trial_opto
                Preemptives_ITI_OptoStim = Preemptives_ITI_OptoStim + numPE; 
                Preemptives_ITI_OptoStim_Complete = Preemptives_ITI_OptoStim_Complete + numCompletePE;
                Preemptives_ITI_OptoStim_Incomplete = Preemptives_ITI_OptoStim - Preemptives_ITI_OptoStim_Complete;
                if numPE == 1
                    PE_ITI_OptoStim_times(Preemptives_ITI_OptoStim) = tone_starts(t);
                else
                    PE_ITI_OptoStim_times(Preemptives_ITI_OptoStim +1 - numPE: Preemptives_ITI_OptoStim) = tone_starts(t);
                end
            else
                Preemptives_ITI_NoStim = Preemptives_ITI_NoStim + numPE;
                Preemptives_ITI_NoStim_Complete = Preemptives_ITI_NoStim_Complete + numCompletePE;
                Preemptives_ITI_NoStim_Incomplete = Preemptives_ITI_NoStim - Preemptives_ITI_NoStim_Complete; 
                if numPE == 1
                    PE_ITI_NoStim_times(Preemptives_ITI_NoStim) = tone_starts(t);
                else
                    PE_ITI_NoStim_times(Preemptives_ITI_NoStim +1 - numPE: Preemptives_ITI_NoStim) = tone_starts(t);
                end
            end
        end
    end
end
%% Get timestamp for correct trials 
if CorrectCheck == 1
    CorrectTimes(t) = tone_starts(t);
    CorrectTimes_OptoStim(t) = tone_starts(t);
    CorrectTimes_NoStim(t) = tone_starts(t);
    CorrectCheck = 0;
else
    CorrectTimes(t) = 0;
    CorrectTimes_OptoStim(t) = 0;
    CorrectTimes_NoStim(t) = 0;
end

%% Dev Mod stuff
if dev_mod == 1 && question_trials == 'Y' 
    
    % plots the data relative to the trial + ouputs the results of the
    % analysis and waits for the user to press any key before continouing
    % with the next trial
    
    close all
    
    figure;
    try
        plot(trial_trigger_sensor +8); hold on; plot(trial_reward_sensor+6); 
        plot(trial_reward +4); plot(trial_reset+2);  plot(trial_tone); plot( trial_laser - 4);
        legend('Trigger sensor', 'reward sensor', 'reward', 'reset',  'tone', 'laser');
    catch
        plot(trial_trigger_sensor +8); hold on; plot(trial_reward_sensor+6); 
        plot(trial_reward +4); plot(trial_reset+2); plot(trial_tone);
        legend('Trigger sensor', 'reward sensor', 'reward', 'reset', 'tone');
    end    
    
    if trial_type == 1 && ~isempty(find(TpushComplete < TfirstReset))
        text(5000, 5, 'HIT', 'FontSize', 14, 'Color', 'b');
        text(5000, 3, num2str(Hit),'FontSize', 14, 'Color', 'b');
    elseif trial_type == 1 && isempty(find(TpushComplete < TfirstReset))
        text(5000, 5, 'Miss', 'FontSize', 14, 'Color', 'b');
        text(5000, 3, num2str(Miss),'FontSize', 14, 'Color', 'b');
    elseif trial_type == 0 && isempty(find(TpushComplete < TfirstReset)) && RewCheck == 0
        text(5000, 5, 'FA', 'FontSize', 14, 'Color', 'r');
        text(5000, 3, num2str(FalseAlarm),'FontSize', 14, 'Color', 'r');
    else
        text(5000, 5, 'CR', 'FontSize', 14, 'Color', 'r');
        text(5000, 3, num2str(CorrectRejection),'FontSize', 14, 'Color', 'r');
    end
    
    if Opto
        text(6000, 5, 'Opto?', 'FontSize', 14, 'Color', 'r');
        text(6000, 3, num2str(trial_opto),'FontSize', 14, 'Color', 'r');
    end
    
    text(8000, 5, 'PE', 'FontSize', 14, 'Color', 'g');
    text(8000, 3, num2str(numPE),'FontSize', 14, 'Color', 'g');
    
    fprintf('Press a key to continue\n');
    pause;
end














