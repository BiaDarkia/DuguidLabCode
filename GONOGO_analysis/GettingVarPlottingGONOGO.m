%% Get plotting variables
% Get variables out of all_var and rename them

% Mouse/ Training details
MouseName                                                           = all_var.mouse_name;
DayMode(1:length(all_var.day_mode),mouse_ID)                        = all_var.day_mode;
TrainingLength(1:length(all_var.training_length),mouse_ID)          = all_var.training_length;
% Correct and Incorrect trial outcumes
Hits(1:length(all_var.day_mode),mouse_ID)                           = all_var.num_rewards_Go;
CorrectRejections(1:length(all_var.day_mode),mouse_ID)              = all_var.num_rewards_Nogo;
Misses(1:length(all_var.day_mode),mouse_ID)                         = all_var.misses;
FalseAlarms(1:length(all_var.day_mode),mouse_ID)                    = all_var.false_alarm;
% Reaction Times
Median_ReactTime_Hit(1:length(all_var.day_mode),mouse_ID)           = all_var.reaction_time_Hit_median;
Median_ReactTime_FalseAlarm(1:length(all_var.day_mode),mouse_ID)    = all_var.reaction_time_FalseAlarm_median;
Std_ReactTime_Hit(1:length(all_var.day_mode),mouse_ID)              = all_var.reaction_time_Hit_std;
Std_ReactTime_FalseAlarm(1:length(all_var.day_mode),mouse_ID)       = all_var.reaction_time_FalseAlarm_std;
Sem_ReactTime_Hit(1:length(all_var.day_mode),mouse_ID)              = all_var.reaction_time_Hit_sem;
Sem_ReactTime_FalseAlarm(1:length(all_var.day_mode),mouse_ID)       = all_var.reaction_time_FalseAlarm_sem;
% AllPushesRT                                                         = all_var.push_tot_RT;
% Number of Tones
Num_tonesGO(1:length(all_var.day_mode),mouse_ID)                    = all_var.num_tones_Go;
Num_tonesNOGO(1:length(all_var.day_mode),mouse_ID)                  = all_var.num_tones_Nogo;
Num_trials(1:length(all_var.day_mode), mouse_ID)                    = all_var.num_trials; 
% Tone Efficiency
ToneEff_GO(1:length(all_var.day_mode),mouse_ID)                     = all_var.tone_efficiency_Go;
ToneEff_NOGO(1:length(all_var.day_mode),mouse_ID)                   = all_var.tone_efficiency_Nogo;
ToneEff_TOT(1:length(all_var.day_mode),mouse_ID)                    = all_var.tone_efficiency_tot;
% Preemptives
Preemptives_ITI(1:length(all_var.day_mode),mouse_ID)                = all_var.num_preemptive_ITI;
Preemptives_ITI_Complete(1:length(all_var.day_mode),mouse_ID)       = all_var.num_preemptive_ITI_Complete;
Preemptives_ITI_Incomplete(1:length(all_var.day_mode),mouse_ID)     = all_var.num_preemptive_ITI_Incomplete;
% Timed stuff
Hit_timed                                                           = all_var.Hit_timed;
Miss_timed                                                          = all_var.Miss_timed;
FA_timed                                                            = all_var.FA_timed;
CR_timed                                                            = all_var.CR_timed;
PED_timed                                                           = all_var.PED_timed;
PEI_timed                                                           = all_var.PEI_timed;
GO_TE_timed                                                         = all_var.GO_TE_timed;
NOGO_TE_timed                                                       = all_var.NOGO_TE_timed;
% Events times
Hit_times                                                           = all_var.Hit_times;
Miss_times                                                          = all_var.Miss_times;
FA_times                                                            = all_var.FA_times;
CR_times                                                            = all_var.CR_times;
% Correct Times
CorrectTimes                                                        = all_var.Correct_Tr_Times; 
CompletePEratio                                                     = all_var.complete_preemptive_ITI_ratio; 
Tr2Corr_avg                                                         = all_var.num_trials_to_correct_avg;
Tr2Corr_sem                                                         = all_var.num_trials_to_correct_sem; 
Sec2Corr_avg                                                        = all_var.time_to_correct_avg;
Sec2Corr_sem                                                        = all_var.time_to_correct_sem;        
% Discr and Bias Indexes
DiscrIndex                                                          = all_var.DiscrIndx; 
B                                                                   = all_var.BiasIndx; 


% Opto stuff
Hit_OptoStim                                                        = all_var.Hit_OptoStim(:, lastNonOptoDay+1 : end);
Hit_NoStim                                                          = all_var.Hit_NoStim(:, lastNonOptoDay+1 : end);
Miss_OptoStim                                                       = all_var.Miss_OptoStim(:, lastNonOptoDay+1 : end);
Miss_NoStim                                                         = all_var.Miss_NoStim(:, lastNonOptoDay+1 : end); 
FalseAlarm_OptoStim                                                 = all_var.FalseAlarm_OptoStim(:, lastNonOptoDay+1 : end);
FalseAlarm_NoStim                                                   = all_var.FalseAlarm_NoStim(:, lastNonOptoDay+1 : end); 
CorrectRejection_OptoStim                                           = all_var.CorrectRejection_OptoStim(:, lastNonOptoDay+1 : end);
CorrectRejection_NoStim                                             = all_var.CorrectRejection_NoStim(:, lastNonOptoDay+1 : end);              
Preemptives_ITI_OptoStim                                            = all_var.Preemptives_ITI_OptoStim(:, lastNonOptoDay+1 : end);
Preemptives_ITI_OptoStim_Complete                                   = all_var.Preemptives_ITI_OptoStim_Complete(:, lastNonOptoDay+1 : end);
Preemptives_ITI_OptoStim_Incomplete                                 = all_var.Preemptives_ITI_OptoStim_Incomplete(:, lastNonOptoDay+1 : end); 
Preemptives_ITI_NoStim                                              = all_var.Preemptives_ITI_NoStim(:, lastNonOptoDay+1 : end);
Preemptives_ITI_NoStim_Complete                                     = all_var.Preemptives_ITI_NoStim_Complete(:, lastNonOptoDay+1 : end);
Preemptives_ITI_NoStim_Incomplete                                   = all_var.Preemptives_ITI_NoStim_Incomplete(:, lastNonOptoDay+1 : end); 

Reaction_time_Hit_OptoStim                                          = all_var.Reaction_time_Hit_OptoStim(:, lastNonOptoDay+1 : end);
Reaction_time_Hit_NoStim                                            = all_var.Reaction_time_Hit_NoStim(:, lastNonOptoDay+1 : end);
Reaction_time_FA_OptoStim                                           = all_var.Reaction_time_FA_OptoStim(:, lastNonOptoDay+1 : end);
Reaction_time_FA_NoStim                                             = all_var.Reaction_time_FA_NoStim(:, lastNonOptoDay+1 : end);
median_reaction_time_Hit_OptoStim                                   = all_var.reaction_time_Hit_median_OptoStim(:, lastNonOptoDay+1 : end);
median_reaction_time_FalseAlarm_OptoStim                            = all_var.reaction_time_FalseAlarm_median_OptoStim(:, lastNonOptoDay+1 : end);                                              
std_reaction_time_Hit_OptoStim                                      = all_var.reaction_time_Hit_std_OptoStim(:, lastNonOptoDay+1 : end);
std_reaction_time_FalseAlarm_OptoStim                               = all_var.reaction_time_FalseAlarm_std_OptoStim(:, lastNonOptoDay+1 : end);
sem_reaction_time_Hit_OptoStim                                      = all_var.reaction_time_Hit_sem_OptoStim(:, lastNonOptoDay+1 : end);
sem_reaction_time_FalseAlarm_OptoStim                               = all_var.reaction_time_FalseAlarm_sem_OptoStim(:, lastNonOptoDay+1 : end);
median_reaction_time_Hit_NoStim                                     = all_var.reaction_time_Hit_median_NoStim(:, lastNonOptoDay+1 : end);
median_reaction_time_FalseAlarm_NoStim                              = all_var.reaction_time_FalseAlarm_median_NoStim(:, lastNonOptoDay+1 : end);
std_reaction_time_Hit_NoStim                                        = all_var.reaction_time_Hit_std_NoStim(:, lastNonOptoDay+1 : end);
std_reaction_time_FalseAlarm_NoStim                                 = all_var.reaction_time_FalseAlarm_std_NoStim(:, lastNonOptoDay+1 : end);
sem_reaction_time_Hit_NoStim                                        = all_var.reaction_time_Hit_sem_NoStim(:, lastNonOptoDay+1 : end);
sem_reaction_time_FalseAlarm_NoStim                                 = all_var.reaction_time_FalseAlarm_sem_NoStim(:, lastNonOptoDay+1 : end); 
tone_eff_GO_OptoStim                                                = all_var.tone_efficiency_Go_OptoStim(:, lastNonOptoDay+1 : end); 
tone_eff_NOGO_OptoStim                                              = all_var.tone_efficiency_Nogo_OptoStim(:, lastNonOptoDay+1 : end); 
tone_eff_tot_OptoStim                                               = all_var.tone_efficiency_tot_OptoStim(:, lastNonOptoDay+1 : end);
tone_eff_GO_NoStim                                                  = all_var.tone_efficiency_Go_NoStim(:, lastNonOptoDay+1 : end); 
tone_eff_NOGO_NoStim                                                = all_var.tone_efficiency_Nogo_NoStim(:, lastNonOptoDay+1 : end);
tone_eff_tot_NoStim                                                 = all_var.tone_efficiency_tot_NoStim(:, lastNonOptoDay+1 : end);
opto_trials_record                                                  = all_var.opto_trials_record(:, lastNonOptoDay+1 : end); 
num_OptoStimtrials                                                  = all_var.num_OptoStimTrials(:, lastNonOptoDay+1 : end); 
    
CompletePEratio_OptoStim                                            = all_var.complete_preemptive_ITI_ratio_OptoStim(:, lastNonOptoDay+1 : end); 
CompletePEratio_NoStim                                              = all_var.complete_preemptive_ITI_ratio_NOStim(:, lastNonOptoDay+1 : end);
Hit_OptoStim_timed                                                  = all_var.Hit_OptoStim_timed(:, lastNonOptoDay+1 : end);
Miss_OptoStim_timed                                                 = all_var.Miss_OptoStim_timed(:, lastNonOptoDay+1 : end); 
FA_OptoStim_timed                                                   = all_var.FA_OptoStim_timed(:, lastNonOptoDay+1 : end); 
CR_OptoStim_timed                                                   = all_var.CR_OptoStim_timed(:, lastNonOptoDay+1 : end); 
PEI_OptoStim_timed                                                  = all_var.PEI_OptoStim_timed(:, lastNonOptoDay+1 : end); 
Hit_NoStim_timed                                                    = all_var.Hit_NoStim_timed(:, lastNonOptoDay+1 : end); 
Miss_NoStim_timed                                                   = all_var.Miss_NoStim_timed(:, lastNonOptoDay+1 : end); 
FA_NoStim_timed                                                     = all_var.FA_NoStim_timed(:, lastNonOptoDay+1 : end); 
CR_NoStim_timed                                                     = all_var.CR_NoStim_timed(:, lastNonOptoDay+1 : end); 
PEI_NoStim_timed                                                    = all_var.PEI_NoStim_timed(:, lastNonOptoDay+1 : end);    
DiscrIndex_OptoStim                                                 = all_var.DiscrIndx_OptoStim(:, lastNonOptoDay+1 : end); 
B_OptoStim                                                          = all_var.BiasIndx_OptoStim(:, lastNonOptoDay+1 : end);
DiscrIndex_NoStim                                                   = all_var.DiscrIndx_NoStim(:, lastNonOptoDay+1 : end);
B_NoStim                                                            = all_var.BiasIndx_NoStim(:, lastNonOptoDay+1 : end); 
    
CorrectTimes_OptoStim                                               = all_var.Correct_Tr_Times_OptoStim(:, lastNonOptoDay+1 : end); 
AvgNumTrials_OptoStim                                               = all_var.num_trials_to_correct_avg_OptoStim(:, lastNonOptoDay+1 : end); 
AvgTimeTrials_OptoStim                                              = all_var.time_to_correct_avg_OptoStim(:, lastNonOptoDay+1 : end);
SemNumTrials_OptoStim                                               = all_var.num_trials_to_correct_sem_OptoStim(:, lastNonOptoDay+1 : end); 
SemTimeTrials_OptoStim                                              = all_var.time_to_correct_sem_OptoStim(:, lastNonOptoDay+1 : end); 
CorrectTimes_NoStim                                                 = all_var.Correct_Tr_Times_NoStim(:, lastNonOptoDay+1 : end);  
AvgNumTrials_NoStim                                                 = all_var.num_trials_to_correct_avg_NoStim(:, lastNonOptoDay+1 : end); 
AvgTimeTrials_NoStim                                                = all_var.time_to_correct_avg_NoStim(:, lastNonOptoDay+1 : end);
SemNumTrials_NoStim                                                 = all_var.num_trials_to_correct_sem_NoStim(:, lastNonOptoDay+1 : end);
SemTimeTrials_NoStim                                                = all_var.time_to_correct_sem_NoStim(:, lastNonOptoDay+1 : end);
