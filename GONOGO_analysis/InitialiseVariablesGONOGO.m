% List of variables that are used as counters and flags during the analysis
% of each day's performance. 

Hit                         = 0;
Miss                        = 0;
CorrectRejection            = 0;
FalseAlarm                  = 0;

tone_num_GO                 = 0;
tone_num_NOGO               = 0;

Push_tot                    = 0;
Incomplete_push_GO          = 0;

Preemptives_ITI             = 0;
Preemptives_ITI_Complete    = 0; 
Preemptives_ITI_Incomplete  = 0; 
PE_ITI_times                = 0; 


% Stuff for optogenetics
Hit_OptoStim                        = 0;
Hit_NoStim                          = 0; 
Miss_OptoStim                       = 0;
Miss_NoStim                         = 0; 
FalseAlarm_OptoStim                 = 0;
FalseAlarm_NoStim                   = 0; 
CorrectRejection_OptoStim           = 0;
CorrectRejection_NoStim             = 0;              
                    
Preemptives_ITI_OptoStim            = 0;
Preemptives_ITI_OptoStim_Complete   = 0;
Preemptives_ITI_OptoStim_Incomplete = 0; 
Preemptives_ITI_NoStim              = 0;
Preemptives_ITI_NoStim_Complete     = 0;
Preemptives_ITI_NoStim_Incomplete   = 0; 
PE_ITI_OptoStim_times               = 0; 
PE_ITI_NoStim_times                 = 0; 


opto_trials_record = zeros(1, 100);
postStim_hits = zeros(3, 1);
postStim_fas = zeros(3, 1);
postStim_misses = zeros(3, 1);
postStim_crs = zeros(3, 1);

