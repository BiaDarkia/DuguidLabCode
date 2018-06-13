reps = 1000;
trials_v = [80, 100, 120, 140, 160]; 
sectionLength_v = [5, 10, 15, 20, 25];
numfinds = zeros(1,reps);
probs = zeros(1,5);
subpl = 1;
figure;
for t = 1:5;
    trials = trials_v(t);
    for s = 1:5;
        sectionLength = sectionLength_v(s);
        
        for i = 1:reps;
            stridx = randi([10,length(sequence)*0.6],1);
            sequence = rand(1,trials)>.5;
            section = sequence(stridx:stridx+sectionLength);
            numfinds(1, i) = length(strfind(sequence, section));
        end
        
        probs(1) = length(find(numfinds == 0))/reps;
        probs(2) = length(find(numfinds == 1))/reps;
        probs(3) = length(find(numfinds == 2))/reps;
        probs(4) = length(find(numfinds == 3))/reps;
        probs(5) = length(find(numfinds == 4))/reps;
        
        subplot(5,5,subpl);
        plot(probs, '-ok','LineWidth', 2);
        title(sprintf('%d trials, %d tr. section', trials,sectionLength));
        xlabel('num matches+1'); ylabel('probability');
        axis([0,5,0,1]);
        
        subpl = subpl + 1;
        
    end
end
