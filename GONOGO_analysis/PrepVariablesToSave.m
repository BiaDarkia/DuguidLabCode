%% PrepVariablesToSave
% At the end of the analysis rearrange the results to input them to all_var
% and prepare all_var for saving
%% Update all_var with the results of the analysis
all_var.training_length(dayID)                                               = file_length_s;
all_var.day_mode(dayID)                                                      = trainingdata.tr_mode(dayID);
all_var.day_length                                                           = day_length;
% Update the rest only if we analysed this day
if dayID >= Mod2startday
    % Number of Rewards and erroneus trials
    all_var.num_rewards_Go(dayID)                                            = Hit;
    all_var.misses(dayID)                                                    = Miss;
    all_var.num_rewards_Nogo(dayID)                                          = CorrectRejection;
    all_var.false_alarm(dayID)                                               = FalseAlarm;
    % Number of tones
    all_var.num_tones_Go(dayID)                                              = tone_num_GO;
    all_var.num_tones_Nogo(dayID)                                            = tone_num_NOGO;
    all_var.num_trials(dayID)                                                = tone_num_GO + tone_num_NOGO; 
    % Reaction Time
    all_var.reaction_time_Hit(1:length(Reaction_time_Hit),dayID)             = Reaction_time_Hit;
    all_var.reaction_time_FA(1:length(Reaction_time_FA),dayID)               = Reaction_time_FA;
    all_var.reaction_time_Hit_median(dayID)                                  = median_reaction_time_Hit;
    all_var.reaction_time_FalseAlarm_median(dayID)                           = median_reaction_time_FalseAlarm;
    all_var.reaction_time_Hit_std(dayID)                                     = std_reaction_time_Hit;
    all_var.reaction_time_FalseAlarm_std(dayID)                              = std_reaction_time_FalseAlarm;
    all_var.reaction_time_Hit_sem(dayID)                                     = sem_reaction_time_Hit;
    all_var.reaction_time_FalseAlarm_sem(dayID)                              = sem_reaction_time_FalseAlarm;
    % Tone efficiency
    all_var.tone_efficiency_Go(dayID)                                        = tone_eff_GO;
    all_var.tone_efficiency_Nogo(dayID)                                      = tone_eff_NOGO;
    all_var.tone_efficiency_tot(dayID)                                       = tone_eff_tot;
    % Preemptives
    all_var.num_preemptive_ITI(dayID)                                        = Preemptives_ITI;
    all_var.num_preemptive_ITI_Complete(dayID)                               = Preemptives_ITI_Complete; 
    all_var.num_preemptive_ITI_Incomplete(dayID)                             = Preemptives_ITI_Incomplete; 
    all_var.complete_preemptive_ITI_ratio(dayID)                             = CompletePEratio; 
    % Tone starts
    all_var.tone_starts(1:length(tone_starts), dayID)                        = tone_starts;
    % Timed stuff 
    all_var.Hit_timed(1:TimedBins,dayID)                                     = Hit_timed;
    all_var.Miss_timed(1:TimedBins, dayID)                                   = Miss_timed;
    all_var.FA_timed(1:TimedBins, dayID)                                     = FA_timed;
    all_var.CR_timed(1:TimedBins, dayID)                                     = CR_timed;
    all_var.PEI_timed(1:TimedBins, dayID)                                    = PEI_timed;
    all_var.GO_TE_timed(1:TimedBins, dayID)                                  = GO_TE_timed;
    all_var.NOGO_TE_timed(1:TimedBins, dayID)                                = NOGO_TE_timed;
    % Events times
    all_var.Hit_times(1:length(Hit_times'),dayID)                            = Hit_times';
    all_var.Miss_times(1:length(Miss_times'),dayID)                          = Miss_times';
    all_var.FA_times(1:length(FA_times'),dayID)                              = FA_times';
    all_var.CR_times(1:length(CR_times'),dayID)                              = CR_times';
    all_var.PE_ITI_times(1:Preemptives_ITI, dayID)                           = PE_ITI_times;
    % Push tot
    all_var.push_tot(1:Push_tot,dayID)                                       = Push_tot;
%    all_var.push_tot_RT(1:Push_tot, dayID)                                   = RT_pushes;
    % Correct trials
    all_var.Correct_Tr_Times(1: length(CorrectTimes),dayID)                  = CorrectTimes'; 
    all_var.num_trials_to_correct_avg(1,dayID)                               = AvgNumTrials; 
    all_var.time_to_correct_avg(1,dayID)                                     = AvgTimeTrials; 
    all_var.num_trials_to_correct_sem(1,dayID)                               = SemNumTrials; 
    all_var.time_to_correct_sem(1,dayID)                                     = SemTimeTrials; 
    % Discrimination and bias indexes
    all_var.DiscrIndx(1,dayID)                                               = DiscrIndex;
    all_var.BiasIndx(1,dayID)                                                = B;
    
    % Opto stuff
    all_var.day_apparatus(1,dayID)                                           = Apparatus; 
    all_var.day_opto(1,dayID)                                                = Opto; 
    
    if Opto
        all_var.Hit_OptoStim(1:length(Hit_OptoStim), dayID)                                                  = Hit_OptoStim;
        all_var.Hit_NoStim(1:length(Hit_NoStim), dayID)                                                      = Hit_NoStim; 
        all_var.Miss_OptoStim(1:length(Miss_OptoStim), dayID)                                                = Miss_OptoStim;
        all_var.Miss_NoStim(1:length(Miss_NoStim), dayID)                                                    = Miss_NoStim; 
        all_var.FalseAlarm_OptoStim(1:length(FalseAlarm_OptoStim), dayID)                                    = FalseAlarm_OptoStim;
        all_var.FalseAlarm_NoStim(1:length(FalseAlarm_NoStim), dayID)                                        = FalseAlarm_NoStim; 
        all_var.CorrectRejection_OptoStim(1:length(CorrectRejection_OptoStim), dayID)                        = CorrectRejection_OptoStim;
        all_var.CorrectRejection_NoStim(1:length(CorrectRejection_NoStim), dayID)                            = CorrectRejection_NoStim;              
        all_var.Preemptives_ITI_OptoStim(1:length(Preemptives_ITI_OptoStim), dayID)                          = Preemptives_ITI_OptoStim;
        all_var.Preemptives_ITI_OptoStim_Complete(1:length(Preemptives_ITI_OptoStim_Complete), dayID)        = Preemptives_ITI_OptoStim_Complete;
        all_var.Preemptives_ITI_OptoStim_Incomplete(1:length(Preemptives_ITI_OptoStim_Incomplete), dayID)    = Preemptives_ITI_OptoStim_Incomplete; 
        all_var.Preemptives_ITI_NoStim(1:length(Preemptives_ITI_NoStim), dayID)                              = Preemptives_ITI_NoStim;
        all_var.Preemptives_ITI_NoStim_Complete(1:length(Preemptives_ITI_NoStim_Complete), dayID)            = Preemptives_ITI_NoStim_Complete;
        all_var.Preemptives_ITI_NoStim_Incomplete(1:length(Preemptives_ITI_NoStim_Incomplete), dayID)        = Preemptives_ITI_NoStim_Incomplete; 

        all_var.Reaction_time_Hit_OptoStim(1:length(Reaction_time_Hit_OptoStim),dayID)                       = Reaction_time_Hit_OptoStim;
        all_var.Reaction_time_Hit_NoStim(1:length(Reaction_time_Hit_NoStim),dayID)                           = Reaction_time_Hit_NoStim;
        all_var.Reaction_time_FA_OptoStim(1:length(Reaction_time_FA_OptoStim),dayID)                         = Reaction_time_FA_OptoStim;
        all_var.Reaction_time_FA_NoStim(1:length(Reaction_time_FA_NoStim),dayID)                             = Reaction_time_FA_NoStim;
        all_var.reaction_time_Hit_median_OptoStim(dayID)                                                     = median_reaction_time_Hit_OptoStim;
        all_var.reaction_time_FalseAlarm_median_OptoStim(dayID)                                              = median_reaction_time_FalseAlarm_OptoStim;
        all_var.reaction_time_Hit_std_OptoStim(dayID)                                                        = std_reaction_time_Hit_OptoStim;
        all_var.reaction_time_FalseAlarm_std_OptoStim(dayID)                                                 = std_reaction_time_FalseAlarm_OptoStim;
        all_var.reaction_time_Hit_sem_OptoStim(dayID)                                                        = sem_reaction_time_Hit_OptoStim;
        all_var.reaction_time_FalseAlarm_sem_OptoStim(dayID)                                                 = sem_reaction_time_FalseAlarm_OptoStim;

        all_var.reaction_time_Hit_median_NoStim(dayID)                                                       = median_reaction_time_Hit_NoStim;
        all_var.reaction_time_FalseAlarm_median_NoStim(dayID)                                                = median_reaction_time_FalseAlarm_NoStim;
        all_var.reaction_time_Hit_std_NoStim(dayID)                                                          = std_reaction_time_Hit_NoStim;
        all_var.reaction_time_FalseAlarm_std_NoStim(dayID)                                                   = std_reaction_time_FalseAlarm_NoStim;
        all_var.reaction_time_Hit_sem_NoStim(dayID)                                                          = sem_reaction_time_Hit_NoStim;
        all_var.reaction_time_FalseAlarm_sem_NoStim(dayID)                                                   = sem_reaction_time_FalseAlarm_NoStim;

        all_var.tone_efficiency_Go_OptoStim(dayID)                                                           = tone_eff_GO_OptoStim;
        all_var.tone_efficiency_Nogo_OptoStim(dayID)                                                         = tone_eff_NOGO_OptoStim;
        all_var.tone_efficiency_tot_OptoStim(dayID)                                                          = tone_eff_tot_OptoStim;      
        all_var.tone_efficiency_Go_NoStim(dayID)                                                             = tone_eff_GO_NoStim;
        all_var.tone_efficiency_Nogo_NoStim(dayID)                                                           = tone_eff_NOGO_NoStim;
        all_var.tone_efficiency_tot_NoStim(dayID)                                                            = tone_eff_tot_NoStim;

        all_var.opto_trials_record(1:length(opto_trials_record),dayID)                                       = opto_trials_record;
        all_var.num_OptoStimTrials(1,dayID)                                                                  = sum(opto_trials_record); 

        all_var.complete_preemptive_ITI_ratio_OptoStim(dayID)                                                = CompletePEratio_OptoStim; 
        all_var.complete_preemptive_ITI_ratio_NOStim(dayID)                                                  = CompletePEratio_NoStim; 

        all_var.Hit_OptoStim_timed(1:TimedBins,dayID)                                                         = Hit_OptoStim_timed;
        all_var.Miss_OptoStim_timed(1:TimedBins,dayID)                                                        = Miss_OptoStim_timed; 
        all_var.FA_OptoStim_timed(1:TimedBins,dayID)                                                          = FA_OptoStim_timed; 
        all_var.CR_OptoStim_timed(1:TimedBins,dayID)                                                          = CR_OptoStim_timed; 
        all_var.PEI_OptoStim_timed(1:TimedBins,dayID)                                                         = PEI_OptoStim_timed; 
        all_var.Hit_NoStim_timed(1:TimedBins,dayID)                                                           = Hit_NoStim_timed; 
        all_var.Miss_NoStim_timed(1:TimedBins,dayID)                                                          = Miss_NoStim_timed; 
        all_var.FA_NoStim_timed(1:TimedBins,dayID)                                                            = FA_NoStim_timed; 
        all_var.CR_NoStim_timed(1:TimedBins,dayID)                                                            = CR_NoStim_timed; 
        all_var.PEI_NoStim_timed(1:TimedBins,dayID)                                                           = PEI_NoStim_timed;

        all_var.DiscrIndx_OptoStim(1,dayID)                                                                   = DiscrIndex_OptoStim;
        all_var.BiasIndx_OptoStim(1,dayID)                                                                    = B_OptoStim;
        all_var.DiscrIndx_NoStim(1,dayID)                                                                     = DiscrIndex_NoStim;
        all_var.BiasIndx_NoStim(1,dayID)                                                                      = B_NoStim;

        all_var.Correct_Tr_Times_OptoStim(1: length(CorrectTimes),dayID)                                      = CorrectTimes_OptoStim'; 
        all_var.num_trials_to_correct_avg_OptoStim(1,dayID)                                                   = AvgNumTrials_OptoStim; 
        all_var.time_to_correct_avg_OptoStim(1,dayID)                                                         = AvgTimeTrials_OptoStim; 
        all_var.num_trials_to_correct_sem_OptoStim(1,dayID)                                                   = SemNumTrials_OptoStim; 
        all_var.time_to_correct_sem_OptoStim(1,dayID)                                                         = SemTimeTrials_OptoStim; 
        all_var.Correct_Tr_Times_NoStim(1: length(CorrectTimes),dayID)                                        = CorrectTimes_NoStim'; 
        all_var.num_trials_to_correct_avg_NoStim(1,dayID)                                                     = AvgNumTrials_NoStim; 
        all_var.time_to_correct_avg_NoStim(1,dayID)                                                           = AvgTimeTrials_NoStim; 
        all_var.num_trials_to_correct_sem_NoStim(1,dayID)                                                     = SemNumTrials_NoStim; 
        all_var.time_to_correct_sem_NoStim(1,dayID)                                                           = SemTimeTrials_NoStim; 
        
        
        all_var.Hit_OptoStim_times(1:length(Hit_times_OptoStim'),dayID)                            = Hit_times_OptoStim';
        all_var.Miss_OptoStim_times(1:length(Miss_times_OptoStim'),dayID)                          = Miss_times_OptoStim';
        all_var.FA_OptoStim_times(1:length(FA_times_OptoStim'),dayID)                              = FA_times_OptoStim';
        all_var.CR_OptoStim_times(1:length(CR_times_OptoStim'),dayID)                              = CR_times_OptoStim';

        all_var.Hit_NoStim_times(1:length(Hit_times_NoStim'),dayID)                            = Hit_times_NoStim';
        all_var.Miss_NoStim_times(1:length(Miss_times_NoStim'),dayID)                          = Miss_times_NoStim';
        all_var.FA_NoStim_times(1:length(FA_times_NoStim'),dayID)                              = FA_times_NoStim';
        all_var.CR_NoStim_times(1:length(CR_times_NoStim'),dayID)                              = CR_times_NoStim';
        
        all_var.postStim_hits(:, dayID) = postStim_hits;
        all_var.postStim_fas(:, dayID) = postStim_fas;
        all_var.postStim_misses(:, dayID) = postStim_misses;
        all_var.postStim_crs(:, dayID) = postStim_crs;
        
    end
end
