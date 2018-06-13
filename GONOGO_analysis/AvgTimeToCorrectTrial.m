%% Time inbetween consecutive correct trials
% Calculates the avarage time between consecutive correct trials and the
% avarage number of trials 

% Find which trials had a correct outcome
CorrectTimes   = CorrectTimes'; 
CorrectTrIndex = find(CorrectTimes); 



% Initialise variables
NumTrList  = zeros(length(CorrectTrIndex)-1,1);
TimeTrList = zeros(length(CorrectTrIndex)-1,1);


if Opto
    CorrectTimes_OptoStim   = CorrectTimes_OptoStim'; 
    CorrectTrIndex_OptoStim = find(CorrectTimes_OptoStim); 
    CorrectTimes_NoStim   = CorrectTimes_NoStim'; 
    CorrectTrIndex_NoStim = find(CorrectTimes_NoStim); 

    NumTrList_OptoStim  = zeros(length(CorrectTrIndex_OptoStim)-1,1);
    TimeTrList_OptoStim = zeros(length(CorrectTrIndex_OptoStim)-1,1);
    NumTrList_NoStim  = zeros(length(CorrectTrIndex_NoStim)-1,1);
    TimeTrList_NoStim = zeros(length(CorrectTrIndex_NoStim)-1,1);
end
% Calculate
for i = 2:length(CorrectTrIndex)
    NumTrList(i-1)  = CorrectTrIndex(i) - CorrectTrIndex(i-1);
    TimeTrList(i-1) = CorrectTimes(CorrectTrIndex(i)) - CorrectTimes(CorrectTrIndex(i-1));
    
    if Opto
        NumTrList_OptoStim(i-1)  = CorrectTrIndex_OptoStim(i) - CorrectTrIndex_OptoStim(i-1);
        TimeTrList_OptoStim(i-1) = CorrectTimes_OptoStim(CorrectTrIndex_OptoStim(i)) - CorrectTimes_OptoStim(CorrectTrIndex_OptoStim(i-1));
        NumTrList_NoStim(i-1)  = CorrectTrIndex_NoStim(i) - CorrectTrIndex_NoStim(i-1);
        TimeTrList_NoStim(i-1) = CorrectTimes_NoStim(CorrectTrIndex_NoStim(i)) - CorrectTimes_NoStim(CorrectTrIndex_NoStim(i-1));
    end 
end

% Stats
TimeTrList    = TimeTrList./1000;
AvgNumTrials  = mean(NumTrList, 1);
SemNumTrials  = std(NumTrList)/sqrt(length(NumTrList));
AvgTimeTrials = mean(TimeTrList, 1);
SemTimeTrials = std(TimeTrList)/sqrt(length(TimeTrList));

if Opto
    TimeTrList_OptoStim    = TimeTrList_OptoStim./1000;
    AvgNumTrials_OptoStim  = mean(NumTrList_OptoStim, 1);
    SemNumTrials_OptoStim  = std(NumTrList_OptoStim)/sqrt(length(NumTrList_OptoStim));
    AvgTimeTrials_OptoStim = mean(TimeTrList_OptoStim, 1);
    SemTimeTrials_OptoStim = std(TimeTrList_OptoStim)/sqrt(length(TimeTrList_OptoStim));

    TimeTrList_NoStim    = TimeTrList_NoStim./1000;
    AvgNumTrials_NoStim  = mean(NumTrList_NoStim, 1);
    SemNumTrials_NoStim  = std(NumTrList_NoStim)/sqrt(length(NumTrList_NoStim));
    AvgTimeTrials_NoStim = mean(TimeTrList_NoStim, 1);
    SemTimeTrials_NoStim = std(TimeTrList_NoStim)/sqrt(length(TimeTrList_NoStim));
end