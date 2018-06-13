%% Discrimination Index
% Discrimination Index (D.I.) indicates how well the mouse discriminates
% between Go and Nogo ques (i.e. how likely it is to respond correctly to a
% given cue). 
% -1<D.I.<+1
% D.I. = 0 --> the mouse is behaving at chances level, 
% D.I. < 0 --> worse than chances level, the mouse is doing lots of False
% alarms and Misses
% D.I. > 0 --> Mouse is discriminating better than chance
% D.I. > 0.5 --> Twice as likely to respond correctly than incorrectly.
% Considered Threshold for learned behaviour. 

% Hit rate and FA rate
HR = tone_eff_GO./100; 
FAR = (100 - tone_eff_NOGO)./100; 


% Remove NaNs, 0s and 1s
FAR(isnan(FAR)) = 0.001;
HR(HR == 1) = 0.999; 
FAR(FAR == 1) = 0.999; 
HR(HR == 0) = 0.001; 
FAR(FAR == 0) = 0.999; 


% Calculate discrimination index
DiscrIndex = HR - FAR; 

% Bias Index (B)
% It reflects how likely is a mouse to push regardless of the trial tipe. 
% e.g. if B is high the mouse pushes is very likely to push regardless of trial type.
B = (HR + FAR)./2; 

%% Do the same for Opto variables
if Opto
    HR_OptoStim = tone_eff_GO_OptoStim./100; 
    HR_NoStim = tone_eff_GO_NoStim./100; 
    FAR_OptoStim = (100 - tone_eff_NOGO_OptoStim)./100; 
    FAR_NoStim = (100 - tone_eff_NOGO_NoStim)./100; 

    FAR_OptoStim(isnan(FAR_OptoStim)) = 0.001;
    HR_OptoStim(HR_OptoStim == 1) = 0.999; 
    FAR_OptoStim(FAR_OptoStim == 1) = 0.999; 
    HR_OptoStim(HR_OptoStim == 0) = 0.001; 
    FAR_OptoStim(FAR_OptoStim == 0) = 0.999; 

    FAR_NoStim(isnan(FAR_NoStim)) = 0.001;
    HR_NoStim(HR_NoStim == 1) = 0.999; 
    FAR_NoStim(FAR_NoStim == 1) = 0.999; 
    HR_NoStim(HR_NoStim == 0) = 0.001; 
    FAR_NoStim(FAR_NoStim == 0) = 0.999;
    
    DiscrIndex_OptoStim = HR_OptoStim - FAR_OptoStim;
    DiscrIndex_NoStim = HR_NoStim - FAR_NoStim; 

    B_OptoStim = (HR_OptoStim + FAR_OptoStim) ./ 2; 
    B_NoStim = (HR_NoStim + FAR_NoStim) ./ 2; 
end
