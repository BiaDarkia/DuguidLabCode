figure; 

plot(ABF(:,2)+18); hold on; %sensor reward
plot(ABF(:,1)+12); %sensor trigger
plot(ABF(:,3)+6); %rewards
plot(ABF(:,4)); %Lever locked
plot(ABF(:,5)-6); %Tone
plot(ABF(:,6)-12); %Light
legend('Sensor Reward', 'Sensor Trigger', 'Rewards', 'Lever locked', 'Tone', 'Light'); 
title('ABF WAVES'); 