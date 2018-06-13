all_var.mouse_name                                  = old_var.mouse_name; 
all_var.training_length(1:num_days_analysed)        = old_var.training_length; 
all_var.day_mode(1:num_days_analysed)               = old_var.day_mode; 
all_var.day_length(1:num_days_analysed)             = old_var.day_length;

all_var.delay_day(1:num_days_analysed)              = old_var.delay_day; 
all_var.delay_day_max(1:num_days_analysed)          = old_var.delay_day_max; 
all_var.delay_day_min(1:num_days_analysed)          = old_var.delay_day_min; 
all_var.tone_length(1:num_days_analysed)            = old_var.tone_length; 
all_var.GoWindow(1:num_days_analysed)               = old_var.GoWindow; 
all_var.NogoWindow(1:num_days_analysed)             = old_var.NogoWindow; 

all_var.num_rewards_Go(1:num_days_analysed)         = old_var.num_rewards_Go; 
all_var.num_rewards_Nogo(1:num_days_analysed)       = old_var.num_rewards_Nogo; 
all_var.num_tones_Go(1:num_days_analysed)           = old_var.num_tones_Go; 
all_var.num_tones_Nogo(1:num_days_analysed)         = old_var.num_tones_Nogo; 

all_var.misses(1:num_days_analysed)                 = old_var.misses; 
all_var.false_alarm(1:num_days_analysed)            = old_var.false_alarm; 

all_var.num_preemptive_delay(1:num_days_analysed)   = old_var.num_preemptive_delay; 
all_var.num_preemptive_ITI(1:num_days_analysed)     = old_var.num_preemptive_ITI; 
all_var.num_preemptive_TOT(1:num_days_analysed)     = old_var.num_preemptive_TOT; 

all_var.tone_efficiency_Go(1:num_days_analysed)     = old_var.tone_efficiency_Go; 
all_var.tone_efficiency_Nogo(1:num_days_analysed)   = old_var.tone_efficiency_Nogo; 
all_var.tone_efficiency_tot(1:num_days_analysed)    = old_var.tone_efficiency_tot; 

all_var.reaction_time_Hit(:,1:num_days_analysed)      = old_var.reaction_time_Hit(:,1:num_days_analysed); 
all_var.reaction_time_Hit_TOT(:,1:num_days_analysed)  = old_var.reaction_time_Hit_TOT(:,1:num_days_analysed);
all_var.reaction_time_FA_TOT(:,1:num_days_analysed)   = old_var.reaction_time_FA_TOT(:,1:num_days_analysed); 

all_var.reaction_time_Hit_avg(1:num_days_analysed)        = old_var.reaction_time_Hit_avg; 
all_var.reaction_time_FalseAlarm_avg(1:num_days_analysed) = old_var.reaction_time_FalseAlarm_avg; 
all_var.reaction_time_Hit_std(1:num_days_analysed)        = old_var.reaction_time_Hit_std; 
all_var.reaction_time_FalseAlarm_std(1:num_days_analysed) = old_var.reaction_time_FalseAlarm_std; 
all_var.reaction_time_Hit_sem(1:num_days_analysed)        = old_var.reaction_time_Hit_sem; 
all_var.reaction_time_FalseAlarm_sem(1:num_days_analysed) = old_var.reaction_time_FalseAlarm_sem; 

all_var.Hit_timed(:,1:num_days_analysed)            = old_var.Hit_timed(:,1:num_days_analysed); 
all_var.Miss_timed(:,1:num_days_analysed)           = old_var.Miss_timed(:,1:num_days_analysed); 
all_var.FA_timed(:,1:num_days_analysed)             = old_var.FA_timed(:,1:num_days_analysed); 
all_var.CR_timed(:,1:num_days_analysed)             = old_var.CR_timed(:,1:num_days_analysed); 
all_var.PED_timed(:,1:num_days_analysed)            = old_var.PED_timed(:,1:num_days_analysed); 
all_var.PEI_timed(:,1:num_days_analysed)            = old_var.PEI_timed(:,1:num_days_analysed); 
all_var.GO_TE_timed(:,1:num_days_analysed)          = old_var.GO_TE_timed(:,1:num_days_analysed); 
all_var.NOGO_TE_timed(:,1:num_days_analysed)        = old_var.NOGO_TE_timed(:,1:num_days_analysed); 

all_var.push_tot(:,1:num_days_analysed)             = old_var.push_tot(:,1:num_days_analysed); 
all_var.push_tot_RT(:,1:num_days_analysed)          = old_var.push_tot_RT(:,1:num_days_analysed); 
all_var.PE_delay_times(:,1:num_days_analysed)       = old_var.PE_delay_times(:,1:num_days_analysed); 