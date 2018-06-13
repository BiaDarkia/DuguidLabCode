function [ tone_starts, tone_ends, num_tones ] = FindToneStartV2(tone_vec)
% Finds all the time points at which the cue starts. 
% Each tone is consideredthe beginning of a trial 

tone_vec        = abs(tone_vec);
tone_vec_neg    = -tone_vec(2:length(tone_vec)); 
tone_vec_pos    = tone_vec(1:length(tone_vec)-1);

summa = tone_vec_pos + tone_vec_neg; 

tone_starts = find(summa<0);
tone_ends = find(summa>0);

if length(tone_starts) - length(tone_ends) == 1 % we are missing the end of a tone, was during the end of training session
    tone_starts = tone_starts(1:end-1); 
end

% For NOGO tones (Their signal is shaped to be ON-OFF-ON), avoid counting
% two tone ON times
for t = 2 : length(tone_starts)
    if tone_starts(t) - tone_starts(t-1) < 1000 % two tone starts within one second --> NOGO tone
        tone_starts(t) = 0;
    end
    if tone_ends(t) - tone_ends(t-1) < 1000
        tone_ends(t-1) = 0;
    end
end

% Creat final vectors
tone_starts = tone_starts(find(tone_starts));
tone_ends = tone_ends(find(tone_ends));
num_tones = size(tone_starts,1); 
