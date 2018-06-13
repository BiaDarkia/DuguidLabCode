% This script is to plot the latency of preemptives ITI in the GoNogo task
Mod2Start = find(DayMode(:,mouse_ID) == 2,1);
DaysToPlot = round(num_days - Mod2Start);

PEI_times = all_var.PE_ITI_times;
PEI_times(PEI_times == 0) = NaN;
BW = 2000;

tone_starts = all_var.tone_starts; 
tone_starts ( tone_starts <= 0) = NaN; 


%%

p = 1; 
PEI_t = nan(size(tone_starts,1), 20); 


for d =  1 : size(tone_starts,2);
    tone_starts_day = tone_starts(:,d);
    PEI_day = PEI_times(:,d);
    
    
    for t = 1:length(tone_starts_day)
        
        PEI_tone = PEI_day(PEI_day < tone_starts_day(t));   % PEI before tone
        
        if t > 2
            PEI_tone = PEI_tone(PEI_tone > tone_starts_day(t-1)); % PEI before tone and after previous tone
        end
        
        
        if ~isempty(PEI_tone)
            for ii = 1:length(PEI_tone)
                PEI_t(p,ii) = tone_starts_day(t) - PEI_tone(ii);  %Time of preemptive before tone
            end
            p = p+1;
        end
    end
end

PEI_t(PEI_t == 0) = nan; % remove null values 
PEI_t = -PEI_t;  % Time is negative because before of tone



figure; 
histogram(PEI_t, 'BinWidth', 1000); 
axis([-50000, 0, 0, inf]); 






