%% Timed analysis of Gonogo Behaviour
% Uses the number of Bins specified in the Constants
% section to divide the session and measure the
% performance in each bin.

%% Initialise variables
BinsWidth = length(tone_vec)/TimedBins;

Tone_starts_bin  = zeros(1,TimedBins); 
Tones_GO_bin     = zeros(1,TimedBins); 
Tones_NOGO_bin   = zeros(1,TimedBins); 
Hit_timed        = zeros(1,TimedBins); 
Miss_timed       = zeros(1,TimedBins); 
FA_timed         = zeros(1,TimedBins); 
CR_timed         = zeros(1,TimedBins); 
PEI_timed        = zeros(1,TimedBins); 
GO_TE_timed      = zeros(1,TimedBins); 
NOGO_TE_timed    = zeros(1,TimedBins); 
PE_ITI_times(PE_ITI_times == 0) = NaN; 

if Opto 
    Hit_OptoStim_timed        = zeros(1,TimedBins); 
    Miss_OptoStim_timed       = zeros(1,TimedBins); 
    FA_OptoStim_timed         = zeros(1,TimedBins); 
    CR_OptoStim_timed         = zeros(1,TimedBins); 
    PEI_OptoStim_timed        = zeros(1,TimedBins); 
    PE_ITI_OptoStim_times(PE_ITI_OptoStim_times == 0) = NaN; 

    Hit_NoStim_timed        = zeros(1,TimedBins); 
    Miss_NoStim_timed       = zeros(1,TimedBins); 
    FA_NoStim_timed         = zeros(1,TimedBins); 
    CR_NoStim_timed         = zeros(1,TimedBins); 
    PEI_NoStim_timed        = zeros(1,TimedBins); 
    PE_ITI_NoStim_times(PE_ITI_NoStim_times == 0) = NaN; 
end



%% Analysis     
for b = 1:TimedBins
    if b == 1
        Hit_timed(1,b)  = size(Hit_times(Hit_times < (b*BinsWidth)),2);
        Miss_timed(1,b) = size(Miss_times(Miss_times < (b*BinsWidth)),2);
        FA_timed(1,b)   = size(FA_times(FA_times < (b*BinsWidth)),2);
        CR_timed(1,b)   = size(CR_times(CR_times < (b*BinsWidth)),2);
        PEI_timed(1,b)  = size(PE_ITI_times(PE_ITI_times < (b*BinsWidth)),2);
        
        if Opto
            Hit_OptoStim_timed(1,b)  = size(Hit_times_OptoStim(Hit_times_OptoStim < (b*BinsWidth)),2);
            Miss_OptoStim_timed(1,b) = size(Miss_times_OptoStim(Miss_times_OptoStim < (b*BinsWidth)),2);
            FA_OptoStim_timed(1,b)   = size(FA_times_OptoStim(FA_times_OptoStim < (b*BinsWidth)),2);
            CR_OptoStim_timed(1,b)   = size(CR_times_OptoStim(CR_times_OptoStim < (b*BinsWidth)),2);
            PEI_OptoStim_timed(1,b)  = size(PE_ITI_OptoStim_times(PE_ITI_OptoStim_times < (b*BinsWidth)),2);

            Hit_NoStim_timed(1,b)  = size(Hit_times_NoStim(Hit_times_NoStim < (b*BinsWidth)),2);
            Miss_NoStim_timed(1,b) = size(Miss_times_NoStim(Miss_times_NoStim < (b*BinsWidth)),2);
            FA_NoStim_timed(1,b)   = size(FA_times_NoStim(FA_times_NoStim < (b*BinsWidth)),2);
            CR_NoStim_timed(1,b)   = size(CR_times_NoStim(CR_times_NoStim < (b*BinsWidth)),2);
            PEI_NoStim_timed(1,b)  = size(PE_ITI_NoStim_times(PE_ITI_NoStim_times < (b*BinsWidth)),2);
        end
    else
        Hit_timed(1,b)  = size(Hit_times(Hit_times < (b*BinsWidth)),2) - sum(Hit_timed(1,1:(b-1)));
        Miss_timed(1,b) = size(Miss_times(Miss_times < (b*BinsWidth)),2) - sum(Miss_timed(1,1:(b-1)));
        FA_timed(1,b)   = size(FA_times(FA_times < (b*BinsWidth)),2) - sum(FA_timed(1,1:(b-1)));
        CR_timed(1,b)   = size(CR_times(CR_times < (b*BinsWidth)),2) - sum(CR_timed(1,1:(b-1)));
        PEI_timed(1,b)  = size(PE_ITI_times(PE_ITI_times < (b*BinsWidth)),2) - sum(PEI_timed(1,1:(b-1)));
        
        if Opto
            Hit_OptoStim_timed(1,b)  = size(Hit_times_OptoStim(Hit_times_OptoStim < (b*BinsWidth)),2) - sum(Hit_OptoStim_timed(1,1:(b-1)));
            Miss_OptoStim_timed(1,b) = size(Miss_times_OptoStim(Miss_times_OptoStim < (b*BinsWidth)),2) - sum(Miss_OptoStim_timed(1,1:(b-1)));
            FA_OptoStim_timed(1,b)   = size(FA_times_OptoStim(FA_times_OptoStim < (b*BinsWidth)),2) - sum(FA_OptoStim_timed(1,1:(b-1)));
            CR_OptoStim_timed(1,b)   = size(CR_times_OptoStim(CR_times_OptoStim < (b*BinsWidth)),2) - sum(CR_OptoStim_timed(1,1:(b-1)));
            PEI_OptoStim_timed(1,b)  = size(PE_ITI_OptoStim_times(PE_ITI_OptoStim_times < (b*BinsWidth)),2) - sum(PEI_OptoStim_timed(1,1:(b-1)));

            Hit_NoStim_timed(1,b)  = size(Hit_times_NoStim(Hit_times_NoStim < (b*BinsWidth)),2) - sum(Hit_NoStim_timed(1,1:(b-1)));
            Miss_NoStim_timed(1,b) = size(Miss_times_NoStim(Miss_times_NoStim < (b*BinsWidth)),2) - sum(Miss_NoStim_timed(1,1:(b-1)));
            FA_NoStim_timed(1,b)   = size(FA_times_NoStim(FA_times_NoStim < (b*BinsWidth)),2) - sum(FA_NoStim_timed(1,1:(b-1)));
            CR_NoStim_timed(1,b)   = size(CR_times_NoStim(CR_times_NoStim < (b*BinsWidth)),2) - sum(CR_NoStim_timed(1,1:(b-1)));
            PEI_NoStim_timed(1,b)  = size(PE_ITI_NoStim_times(PE_ITI_NoStim_times < (b*BinsWidth)),2) - sum(PEI_NoStim_timed(1,1:(b-1)));
        end
    end
    
    if Hit_timed(1,b) ~= 0
        GO_TE_timed(b) = (Hit_timed(1,b)/Tones_GO_bin(b))*100;
    else
        GO_TE_timed(b) =  0;
    end
    
    if FalseAlarm == 0
       FA_timed = zeros(1, TimedBins); 
    end
    
    if Opto
        if FalseAlarm_OptoStim == 0
            FA_OptoStim_timed = zeros(1, TimedBins); 
        elseif FalseAlarm_NoStim == 0
            FA_NoStim_timed = zeros(1, TimedBins); 
        end
    end
    
    if CR_timed(1,b) ~= 0
        NOGO_TE_timed(b) = (CR_timed(1,b)/Tones_NOGO_bin(b))*100; 
    else
        NOGO_TE_timed(b) = 0; 
    end
    
end


%% DEV MOD stuff
if dev_mod == 1 && question_timed_stuff == 'Y';
    fprintf(' *****************************\n'); 
        Hit_timed
        Miss_timed
        FA_timed
        CR_timed
      
        PEI_timed
        
        Tones_GO_bin
        Tones_NOGO_bin
        
        SumHit_timed(1, dayID) = sum(Hit_timed);
        SumMissed_timed(1, dayID) = sum(Miss_timed);
        SumFATimed(1, dayID) = sum(FA_timed);
        SumCRTImed(1, dayID) = sum(CR_timed);
        SUMPEITimed(1, dayID) = sum(PEI_timed);
        
        SumHit_timed(2, dayID) = Hit
        SumMissed_timed(2, dayID) = Miss
        SumFATimed(2, dayID) = FalseAlarm
        SumCRTImed(2, dayID) = CorrectRejection
        SUMPEITimed(2, dayID) = Preemptives_ITI
        
        fprintf('Press a key to continue\n'); 
        pause;
end


