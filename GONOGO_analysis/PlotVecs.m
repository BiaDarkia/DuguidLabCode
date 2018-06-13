figure; 

plot( sensor_reward_vec +6); hold on; %sensor reward
plot(sensor_trigger_vec+4); %sensor trigger
plot(reward_signal_vec+2); %rewards
plot(reset_vec); %Lever locked
plot(tone_vec-2); %Tone
plot(light_vec-4); %Light
legend('Sensor Reward', 'Sensor Trigger', 'Rewards', 'Lever locked', 'Tone', 'Light'); 
title('ABF VECS'); 