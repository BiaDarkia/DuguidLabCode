%% Rearrange the varibales for easier saving

if Hit ~= 0
    median_reaction_time_Hit          = median(Reaction_time_Hit);
    std_reaction_time_Hit             = std(Reaction_time_Hit);
    sem_reaction_time_Hit             = std_reaction_time_Hit/length(Reaction_time_Hit);
    tone_eff_GO                       = (Hit / tone_num_GO)*100;   
else
    Reaction_time_Hit                 = 0;
    Reaction_time_Hit_Tot             = 0;
    median_reaction_time_Hit          = 0;
    std_reaction_time_Hit             = 0;
    sem_reaction_time_Hit             = 0;
    tone_eff_GO                       = 0;
    RT_pushes                         = 0;
end

if tone_num_NOGO ~= 0 && FalseAlarm > 0
    median_reaction_time_FalseAlarm   = median(Reaction_time_FA);
    std_reaction_time_FalseAlarm      = std(Reaction_time_FA);
    sem_reaction_time_FalseAlarm      = std_reaction_time_FalseAlarm/length(Reaction_time_FA);
    tone_eff_NOGO                     = (CorrectRejection / tone_num_NOGO)*100;
    tone_eff_tot                      = ((Hit + CorrectRejection)./(tone_num_GO + tone_num_NOGO))*100; 
else
    median_reaction_time_FalseAlarm   = 0;
    std_reaction_time_FalseAlarm      = 0;
    sem_reaction_time_FalseAlarm      = 0;
    tone_eff_NOGO                     = 0;
    tone_eff_tot                      = tone_eff_GO;
    Reaction_time_FA                  = 0;
    Reaction_time_FA_Tot              = 0;
end

CompletePEratio = (Preemptives_ITI_Complete / Preemptives_ITI)*100; 

%% Opto stuff
if Opto
    if Hit_OptoStim ~= 0
        median_reaction_time_Hit_OptoStim          = median(Reaction_time_Hit_OptoStim);
        std_reaction_time_Hit_OptoStim             = std(Reaction_time_Hit_OptoStim);
        sem_reaction_time_Hit_OptoStim             = std_reaction_time_Hit_OptoStim/length(Reaction_time_Hit_OptoStim);
        tone_eff_GO_OptoStim                       = (Hit_OptoStim / (Hit_OptoStim + Miss_OptoStim))*100; 
    else
        Reaction_time_Hit_OptoStim                 = 0;
        median_reaction_time_Hit_OptoStim          = 0;
        std_reaction_time_Hit_OptoStim             = 0;
        sem_reaction_time_Hit_OptoStim             = 0;
        tone_eff_GO_OptoStim                       = 0;
    end

    if Hit_NoStim ~= 0
        median_reaction_time_Hit_NoStim          = median(Reaction_time_Hit_NoStim);
        std_reaction_time_Hit_NoStim             = std(Reaction_time_Hit_NoStim);
        sem_reaction_time_Hit_NoStim             = std_reaction_time_Hit_NoStim/length(Reaction_time_Hit_NoStim);
        tone_eff_GO_NoStim                       = (Hit_NoStim / (Hit_NoStim + Miss_NoStim))*100; 
    else
        Reaction_time_Hit_NoStim                 = 0;
        median_reaction_time_Hit_NoStim          = 0;
        std_reaction_time_Hit_NoStim             = 0;
        sem_reaction_time_Hit_NoStim             = 0;
        tone_eff_GO_NoStim                       = 0;
    end

    if FalseAlarm_OptoStim > 0
        median_reaction_time_FalseAlarm_OptoStim   = median(Reaction_time_FA_OptoStim);
        std_reaction_time_FalseAlarm_OptoStim      = std(Reaction_time_FA_OptoStim);
        sem_reaction_time_FalseAlarm_OptoStim      = std_reaction_time_FalseAlarm_OptoStim/length(Reaction_time_FA_OptoStim);
        tone_eff_NOGO_OptoStim                     = (CorrectRejection_OptoStim / (CorrectRejection_OptoStim + FalseAlarm_OptoStim))*100;
        tone_eff_tot_OptoStim                      = ((Hit_OptoStim + CorrectRejection_OptoStim)./(CorrectRejection_OptoStim + FalseAlarm_OptoStim + Hit_OptoStim + Miss_OptoStim))*100; 
    else
        median_reaction_time_FalseAlarm_OptoStim   = 0;
        std_reaction_time_FalseAlarm_OptoStim      = 0;
        sem_reaction_time_FalseAlarm_OptoStim      = 0;
        tone_eff_NOGO_OptoStim                     = 0;
        tone_eff_tot_OptoStim                      = tone_eff_GO;
        Reaction_time_FA_OptoStim                  = 0;
    end

    if FalseAlarm_NoStim > 0
        median_reaction_time_FalseAlarm_NoStim   = median(Reaction_time_FA_NoStim);
        std_reaction_time_FalseAlarm_NoStim      = std(Reaction_time_FA_NoStim);
        sem_reaction_time_FalseAlarm_NoStim      = std_reaction_time_FalseAlarm_OptoStim/length(Reaction_time_FA_NoStim);
        tone_eff_NOGO_NoStim                     = (CorrectRejection_OptoStim / (CorrectRejection_OptoStim + FalseAlarm_NoStim))*100;
        tone_eff_tot_NoStim                      = ((Hit_NoStim + CorrectRejection_NoStim)./(CorrectRejection_NoStim + FalseAlarm_NoStim + Hit_NoStim + Miss_NoStim))*100; 
    else
        median_reaction_time_FalseAlarm_NoStim   = 0;
        std_reaction_time_FalseAlarm_NoStim      = 0;
        sem_reaction_time_FalseAlarm_NoStim      = 0;
        tone_eff_NOGO_NoStim                     = 0;
        tone_eff_tot_NoStim                      = tone_eff_GO;
        Reaction_time_FA_NoStim                  = 0;
    end

    CompletePEratio_OptoStim = (Preemptives_ITI_OptoStim_Complete ./ (Preemptives_ITI_OptoStim_Complete + Preemptives_ITI_OptoStim_Incomplete))*100; 
    CompletePEratio_NoStim = (Preemptives_ITI_NoStim_Complete ./ (Preemptives_ITI_NoStim_Complete + Preemptives_ITI_NoStim_Incomplete))*100; 
end