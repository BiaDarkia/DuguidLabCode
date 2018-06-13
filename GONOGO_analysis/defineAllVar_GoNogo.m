function [all_var] = defineAllVar_GoNogo(num_days, mouse, mouseID, TimedBins)
%defineAllVar defines the final variables of leverTrainingCued

% Mouse details
all_var.mouse_name                          = mouse.name{mouseID};
all_var.training_length                     = zeros(1, num_days);
all_var.day_mode                            = zeros(1, num_days);
all_var.day_length                          = zeros(1, num_days);
% Number of rewards
all_var.num_rewards_Go                      = zeros(1, num_days);
all_var.num_rewards_Nogo                    = zeros(1, num_days);
% Number of Tonoes
all_var.num_tones_Go                        = zeros(1, num_days);
all_var.num_tones_Nogo                      = zeros(1, num_days);
all_var.num_trials                          = zeros(1, num_days); 
% Number of erroneus trials
all_var.misses                              = zeros(1, num_days);
all_var.false_alarm                         = zeros(1, num_days);
% Preemptives
all_var.num_preemptive_ITI                  = zeros(1, num_days);
all_var.num_preemptive_ITI_Complete         = zeros(1, num_days);
all_var.num_preemptive_ITI_Incomplete       = zeros(1, num_days);
all_var.complete_preemptive_ITI_ratio       = zeros(1, num_days);
% Tone efficiency
all_var.tone_efficiency_Go                  = zeros(1, num_days);
all_var.tone_efficiency_Nogo                = zeros(1, num_days);
all_var.tone_efficiency_tot                 = zeros(1, num_days);
% Tone start times
all_var.tone_starts                         = zeros(500, num_days); 
% Reaction time   
all_var.reaction_time_Hit                   = zeros(500, num_days);
all_var.reaction_time_FA                    = zeros(500, num_days);
all_var.reaction_time_Hit_avg               = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_avg        = zeros(1, num_days);
all_var.reaction_time_Hit_std               = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_std        = zeros(1, num_days);
all_var.reaction_time_Hit_sem               = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_sem        = zeros(1, num_days);
% Total number of pushes
all_var.push_tot                            = zeros(500, num_days); 
all_var.reaction_time_push_tot              = zeros(500, num_days); 
% Timed analysis 
all_var.Hit_timed                           = zeros(TimedBins, num_days); 
all_var.Miss_timed                          = zeros(TimedBins, num_days); 
all_var.FA_timed                            = zeros(TimedBins, num_days); 
all_var.CR_timed                            = zeros(TimedBins, num_days); 
all_var.PED_timed                           = zeros(TimedBins, num_days); 
all_var.PEI_timed                           = zeros(TimedBins, num_days); 
all_var.GO_TE_timed                         = zeros(TimedBins, num_days); 
all_var.NOGO_TE_timed                       = zeros(TimedBins, num_days);
% Events times
all_var.Hit_times                           = zeros(500, num_days);
all_var.Miss_times                          = zeros(500, num_days);
all_var.FA_times                            = zeros(500, num_days);
all_var.CR_times                            = zeros(500, num_days);
% Time between correct trials
all_var.Correct_Tr_Times                    = zeros(500, num_days);
all_var.num_trials_to_correct_avg           = zeros(1, num_days);
all_var.num_trials_to_correct_sem           = zeros(1, num_days);
all_var.time_to_correct_avg                 = zeros(1, num_days);
all_var.time_to_correct_sem                 = zeros(1, num_days);
%Discr index and Bias index 
all_var.DiscrIndx                           = zeros(1, num_days);
all_var.BiasIndx                            = zeros(1, num_days);

% Opto stuff
all_var.Hit_OptoStim                              = zeros(1, num_days);
all_var.Hit_NoStim                                = zeros(1, num_days); 
all_var.Miss_OptoStim                             = zeros(1, num_days);
all_var.Miss_NoStim                               = zeros(1, num_days); 
all_var.FalseAlarm_OptoStim                       = zeros(1, num_days);
all_var.FalseAlarm_NoStim                         = zeros(1, num_days); 
all_var.CorrectRejection_OptoStim                 = zeros(1, num_days);
all_var.CorrectRejection_NoStim                   = zeros(1, num_days);              
all_var.Preemptives_ITI_OptoStim                  = zeros(1, num_days);
all_var.Preemptives_ITI_OptoStim_Complete         = zeros(1, num_days);
all_var.Preemptives_ITI_OptoStim_Incomplete       = zeros(1, num_days); 
all_var.Preemptives_ITI_NoStim                    = zeros(1, num_days);
all_var.Preemptives_ITI_NoStim_Complete           = zeros(1, num_days);
all_var.Preemptives_ITI_NoStim_Incomplete         = zeros(1, num_days); 

all_var.Reaction_time_Hit_OptoStim                = zeros(500, num_days);
all_var.Reaction_time_Hit_NoStim                  = zeros(500, num_days);
all_var.Reaction_time_FA_OptoStim                 = zeros(500, num_days);
all_var.Reaction_time_FA_NoStim                   = zeros(500, num_days);
all_var.reaction_time_Hit_median_OptoStim            = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_median_OptoStim     = zeros(1, num_days);
all_var.reaction_time_Hit_std_OptoStim               = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_std_OptoStim        = zeros(1, num_days);
all_var.reaction_time_Hit_sem_OptoStim               = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_sem_OptoStim        = zeros(1, num_days);
all_var.reaction_time_Hit_median_NoStim              = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_median_NoStim       = zeros(1, num_days);
all_var.reaction_time_Hit_std_NoStim                 = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_std_NoStim          = zeros(1, num_days);
all_var.reaction_time_Hit_sem_NoStim                 = zeros(1, num_days);
all_var.reaction_time_FalseAlarm_sem_NoStim          = zeros(1, num_days);

all_var.tone_efficiency_Go_OptoStim                  = zeros(1, num_days);    
all_var.tone_efficiency_Nogo_OptoStim                = zeros(1, num_days);    
all_var.tone_efficiency_tot_OptoStim                 = zeros(1, num_days);    
all_var.tone_efficiency_Go_NoStim                    = zeros(1, num_days);    
all_var.tone_efficiency_Nogo_NoStim                  = zeros(1, num_days);    
all_var.tone_efficiency_tot_NoStim                   = zeros(1, num_days);    

all_var.opto_trials_record                           = zeros(500, num_days);
all_var.num_OptoStimTrials                           = zeros(1, num_days); 

all_var.complete_preemptive_ITI_ratio_OptoStim       = zeros(1, num_days); 
all_var.complete_preemptive_ITI_ratio_NOStim         = zeros(1, num_days); 

all_var.Hit_OptoStim_timed                           = zeros(TimedBins, num_days); 
all_var.Miss_OptoStim_timed                          = zeros(TimedBins, num_days); 
all_var.FA_OptoStim_timed                            = zeros(TimedBins, num_days); 
all_var.CR_OptoStim_timed                            = zeros(TimedBins, num_days); 
all_var.PEI_OptoStim_timed                           = zeros(TimedBins, num_days); 
all_var.Hit_NoStim_timed                             = zeros(TimedBins, num_days); 
all_var.Miss_NoStim_timed                            = zeros(TimedBins, num_days); 
all_var.FA_NoStim_timed                              = zeros(TimedBins, num_days); 
all_var.CR_NoStim_timed                              = zeros(TimedBins, num_days); 
all_var.PEI_NoStim_timed                             = zeros(TimedBins, num_days);

all_var.DiscrIndx_OptoStim                           = zeros(1, num_days);                  
all_var.BiasIndx_OptoStim                            = zeros(1, num_days);                  
all_var.DiscrIndx_NoStim                             = zeros(1, num_days);                   
all_var.BiasIndx_NoStim                              = zeros(1, num_days);  

all_var.Correct_Tr_Times_OptoStim                    = zeros(500, num_days);
all_var.num_trials_to_correct_avg_OptoStim           = zeros(1, num_days);
all_var.num_trials_to_correct_sem_OptoStim           = zeros(1, num_days);
all_var.time_to_correct_avg_OptoStim                 = zeros(1, num_days);
all_var.time_to_correct_sem_OptoStim                 = zeros(1, num_days);
all_var.Correct_Tr_Times_NoStim                      = zeros(500, num_days);
all_var.num_trials_to_correct_avg_NoStim             = zeros(1, num_days);
all_var.num_trials_to_correct_sem_NoStim             = zeros(1, num_days);
all_var.time_to_correct_avg_NoStim                   = zeros(1, num_days);
all_var.time_to_correct_sem_NoStim                   = zeros(1, num_days);

all_var.day_apparatus                                = zeros(1, num_days); 
all_var.day_opto                                     = zeros(1, num_days); 


end

