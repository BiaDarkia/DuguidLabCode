clear all

%%%%% Add info here
%%%%% Add info here%%%%% Add info here%%%%% Add info here

%JS: add folder "PawTracking" to Matlab path (Set Path)
%JS: change directory
%JS: keep folder structure as is in Dropbox, with daq etc. in
%JS: file names kept
%JS: output figure: black data extracted from _tones.csv, red data found trials (-1 NoGo, 1 Go)
%JS: quality check, red-black overlap, zoom in
%JS: check Fede_1, whiskers, paw
%JS: framesaroundtone = 1400, change if shorter section should be analysed
%/ plotted; test and decide if other value is better, maybe asymmetric
%JS: _tones to abf match: 
%JS: convfact: factor to downsample daq file to _tones
%JS: dropping frames!? check if consistent?





fprintf('Please select folder to analyse\n');
AnalysedDir     =   uigetdir('/Users/julia 1/Documents/MATLAB/PawTracking/170921_mouseF/170921F_day17_20171007_10-54-35_M2bilateral', 'Where are the analysed files?');
files           =   dir(AnalysedDir);
numFiles        =   length(files);

for f = 1:numFiles % loop through _analysed files and load the correct one for the mouse being analysed, then check number of days to skip
    if strfind(files(f).name, '_BlenderPawTracking.csv');
        PawFile = files(f).name;
        fprintf(sprintf('Found paw tracking .csv file: .... %s \n', PawFile));
    elseif strfind(files(f).name, '_tones.csv');
        LEDFile = files(f).name;
        fprintf(sprintf('Found tones .csv file: ........... %s \n', LEDFile));
    elseif strfind(files(f).name, '.daq');
        DaqFile = files(f).name;
        fprintf(sprintf('Found .daq file: ................. %s \n', DaqFile));
    end
end

figure_title = DaqFile(1:end-4); % Used to plot figure in the end

fprintf('Running\n')
%% Load LED data
fprintf('Loading  LED data...\n')
T = readtable(LEDFile);
C = table2cell(T);

Led_status = zeros(length(C),1);
for i = 1:length(C)
    val = char(C(i));
    Led_status(i) = str2num(val(27:49));
end
fprintf('     ... Loaded!\n')
%% Get LED times and plot
fprintf('Finding tones...\n')
% Assuming a framerate of approx 560 fps. This value might have to change
% in the future. The fps determines the number of frames for which the LED
% stays on, used below.
% For a framerate of 560 fps the tone (0.250s) stays on for 140 frames
% (0.0018 seconds per frame).

% Actually framerate is probably around: 551.625 fps

% Variables
Th = 4.5*var(Led_status);
led_times=zeros(length(C),1);
led_times(Led_status>Th) = 1; % Tiems at which the LED signal is above Threshold

% get only onset of pixel changes
summa = led_times(1:end-1) -  led_times(2:end);
led_on_times = find(summa < 0); % finds frames in which LED is SWITCHED on

% Determine Trial type from shape of LED activity
tone_type = zeros(length(led_times),1); % Vector that will save tone onset and trial tipe.

for l = 2:length(led_on_times);
    % This is based on the assumption that the framerate is 560fps and
    % thus a tone should happen within 140 frames
    if led_on_times(l) - led_on_times(l-1) < 140; % The LED went on twice very rapidly.
        if led_on_times(l) - led_on_times(l-1) < 40; % Too rapid to be a NOGO, must be NOISE
            tone_type(led_on_times(l)) = 1;  % It's a GO
            led_on_times(l) = 0;
        else
            tone_type(led_on_times(l-1)) = -1; %It's a NOGO tone
        end
        % Deal with the last timepoint
        if l == length(led_on_times);
            led_on_times(l) = 0;
        end
    else
        tone_type(led_on_times(l)) = 1;  % It's a GO
        if l == 2;
            tone_type(led_on_times(l-1)) = 1;
        end
        %         led_on_times(l-1) = 0;
    end
end
led_on_times = led_on_times(led_on_times > 0 );

% Last pass to remove artefacts: ARBRITARY refractory period after a tone (3.5s)
for t = 1:length(tone_type);
    if tone_type(t) ~= 0;
        if t+2000 < length(Led_status);
            tone_type(t+1:t+2000) = 0;
        else
            tone_type(t+1:end) = 0;
        end
    end
end

% Plot each tone that has been identified
% figure;
% pointstoplot = 300;
% for t= 1:length(led_on_times);
%     subplot(round(length(led_on_times)/5), 5, t);
%     plot(Led_status(led_on_times(t)-pointstoplot:led_on_times(t)+pointstoplot)); hold on;
%     plot(50*tone_type(led_on_times(t)-pointstoplot:led_on_times(t)+pointstoplot), 'r', 'LineWidth', 2);
%     axis([200,500, -150, 150])
% end

% Plot the led signal and the identified tones for a last check
figure;
plot(Led_status, 'k'); hold on;
plot(125*tone_type, 'r', 'LineWidth', 1.5);

fprintf('     ... Got tones!\n')
%% Paw stuff
fprintf('Reading Paw data...\n')
% Read data
T = readtable(PawFile);
C = table2cell(T);

% Get X and Y coords
Values = zeros(length(C), 3);
for i = 1:length(C)
    Values(i, 1:3) = cell2mat(textscan(C{i}, '%f64 %f64 %f64', 'Delimiter', ';'));
end

xcoord = Values(:,2);
ycoord = Values(:,3);

fprintf('     ... Loaded!\n')
%% Get aligned Paw data
fprintf('Processing paw data...\n')
gotones = find(tone_type == 1);
nogotones = find(tone_type == -1);
framesaroundtone = 1400;  % 1400 at 560 fps is 2.5 sec

xgo = zeros(length(gotones), (framesaroundtone*2)+1);
ygo = zeros(length(gotones), (framesaroundtone*2)+1);
for g = 1:length(gotones);
    try
        xgo(g,:) = xcoord(gotones(g)-framesaroundtone:gotones(g)+framesaroundtone);
        ygo(g,:) = ycoord(gotones(g)-framesaroundtone:gotones(g)+framesaroundtone);
    catch
        xgo(g,1:length(xcoord(gotones(g)-framesaroundtone:end))) = xcoord(gotones(g)-framesaroundtone:end);
        ygo(g,1:length(ycoord(gotones(g)-framesaroundtone:end))) = ycoord(gotones(g)-framesaroundtone:end);
    end
end


xngo = zeros(length(gotones), (framesaroundtone*2)+1);
yngo = zeros(length(gotones), (framesaroundtone*2)+1);
for g = 1:length(nogotones);
    try
        xngo(g,:) = xcoord(nogotones(g)-framesaroundtone:nogotones(g)+framesaroundtone);
        yngo(g,:) = ycoord(nogotones(g)-framesaroundtone:nogotones(g)+framesaroundtone);
    catch
        xngo(g,1:length(xcoord(nogotones(g)-framesaroundtone:end))) = xcoord(nogotones(g)-framesaroundtone:end);
        yngo(g,1:length(ycoord(nogotones(g)-framesaroundtone:end))) = ycoord(nogotones(g)-framesaroundtone:end);
    end
end

fprintf('     ... Done!\n')

%% Lever Data [Many functions borrowed from GoNogo analysis]
fprintf('Getting Lever data...\n')

ABF=loadAbfData(DaqFile);
sample_rate=    1000;   % Sample rate (Hz)
sensor_th=      2.5;      % Threshold for sensor state change
tone_th=        0.1;        % Threshold for detecting tone

%% Get vectors out of ABF file
[sensor_trigger_vec, sensor_reward_vec, reward_signal_vec, reset_vec, tone_vec, light_vec] = ...
    labelAbfWaves_Gonogo(ABF, sensor_th, tone_th);

% Find the times at which each tone starts (and ends) durig the
% session. Used for outlining the trials to analyse.
[tone_starts, tone_ends, num_tones] = FindToneStartV2(tone_vec);

% Get trial types
trial_type = zeros(length(tone_vec),1);
lev_tones = [];
for t = 1 :length(tone_starts);
    trial_tone_length =  tone_ends(t) - tone_starts(t);
    tone_sig = tone_vec(tone_starts(t):(tone_starts(t) + trial_tone_length));
    if mean(tone_sig) > 0.75
        trial_type(tone_starts(t)) = 1; % GO
        lev_tones = strvcat(lev_tones, 'G');
    else
        trial_type(tone_starts(t)) = -1; % NOGO
        lev_tones = strvcat(lev_tones, 'N');
    end
end

fprintf('     ... Done!\n')


%% Get order of trial types from lever data and from led data, then match
fprintf('Matching lever data with video data...\n')


Gotones = find(tone_type == 1);
Notones = find(tone_type == -1);
Alltones = [Gotones', Notones'];
Alltones = sort(Alltones);
Alltones = Alltones';

led_tones = [];
for i = 1:length(Alltones);
    if ~isempty(find(Gotones == Alltones(i)));
        led_tones = strvcat(led_tones, 'G');
    else
        led_tones = strvcat(led_tones, 'N');
    end
end

lev_tones = lev_tones';
led_tones = led_tones';

% Matching lev and led trial times
Match = strfind(lev_tones, led_tones);
if isempty(Match);
    fprintf('Something went wrong (no match), couldnt match video with lever data\n');
    fprintf('Stopping script... \n');
    return
elseif length(Match) > 1;
    fprintf('Something went wrong (>1 match), found more than one match\n');
    fprintf('Stopping script... \n');
    return
end
lastMatch = Match+length(led_tones)-1;

fprintf('     ... Done!\n')


%% Get aligned lever data
fprintf('Aligning lever data...\n')

% Measure number of points to left of first tone and right of last tone in
% LED data

t_margin_left = find(tone_type,1,'first') - 1;
t_margin_right = length(tone_type) - find(tone_type,1,'last');

% Multiply per conversion factor to get corresponding number of data points
% at 1000 samples per second
convfact = 1000/551.625;   % Need to check that framerate is actually 540
l_margin_left = t_margin_left*convfact;
l_margin_right = t_margin_right*convfact;

% Cut out the relevant part of the lever data
% 2500 is based on the fact that the sampl rate is 1000 and we want 2.5 seconds around each tone onset
samplestotake = 2500;
Match_start = tone_starts(Match)-l_margin_left;
Match_end   = tone_starts(lastMatch)+l_margin_right;

match_trigger_sensor       = sensor_trigger_vec(Match_start : Match_end);
match_reward_sensor        = sensor_reward_vec(Match_start : Match_end);
match_reward               = reward_signal_vec(Match_start : Match_end);
match_reset                = reset_vec(Match_start : Match_end);
match_tone                 = tone_vec(Match_start : Match_end);

% Downsample lever data to match framerate of videos
idx = 1:length(match_tone);                                       % Index
idxq = linspace(min(idx), max(idx), length(tone_type));           % Interpolation Vector

ds_tone = interp1(idx, double(match_tone), idxq, 'pchip' );       % Downsampled Vector
ds_trigger_sensor = interp1(idx, double(match_trigger_sensor), idxq, 'pchip' );
ds_reward_sensor = interp1(idx, double(match_reward_sensor), idxq, 'pchip' );
ds_reward = interp1(idx, double(match_reward), idxq, 'pchip' );
ds_reset = interp1(idx, double(match_reset), idxq, 'pchip' );



% Get the tone onset times from the ds_tone vector
summa = ds_tone(2:end) - ds_tone(1:end-1);
summa(summa ~= 0) = 1;
for i = 1:length(summa);
    if summa(i) ~= 0;
        summa(i+1:i+200) = 0;
    end
end

% check mismatch with the video extracted tones (in number of frames), plot
a = find(abs(tone_type));
b = find(abs(summa));
dist = b'-a;

% figure; subplot(2,1,1);
% plot(ds_tone, 'k'); hold on;
% plot(abs(tone_type*0.5),'r', 'LineWidth', 2);
% subplot(2,1,2); plot(abs(dist), 'o--k', 'LineWidth', 2);


% Tone Aligned lever data (and by trial type)
aligned_l_n_tone = zeros(length(led_tones(led_tones == 'N')), framesaroundtone*2 + 1);
aligned_l_n_trig = zeros(length(led_tones(led_tones == 'N')), framesaroundtone*2 + 1);
aligned_l_n_rewsens = zeros(length(led_tones(led_tones == 'N')), framesaroundtone*2 + 1);

aligned_l_g_tone = zeros(length(led_tones(led_tones == 'G')), framesaroundtone*2 + 1);
aligned_l_g_trig = zeros(length(led_tones(led_tones == 'G')), framesaroundtone*2 + 1);
aligned_l_g_rewsens = zeros(length(led_tones(led_tones == 'G')), framesaroundtone*2 + 1);

g = 1;
n = 1;
tone_times = find(tone_type);
for t = 1:(lastMatch-Match+1);
    if led_tones(t) == 'G';
        try
            aligned_l_g_tone(g,:) = ds_tone(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
            aligned_l_g_trig(g,:) = ds_trigger_sensor(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
            aligned_l_g_rewsens(g,:) = ds_reward_sensor(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
        catch
            aligned_l_g_tone(g,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_tone(tone_times(t)-framesaroundtone : end);
            aligned_l_g_trig(g,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_trigger_sensor(tone_times(t)-framesaroundtone : end);
            aligned_l_g_rewsens(g,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_reward_sensor(tone_times(t)-framesaroundtone : end);
        end
        g = g+1;
    else
        try
            aligned_l_n_tone(n,:) = ds_tone(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
            aligned_l_n_trig(n,:) = ds_trigger_sensor(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
            aligned_l_n_rewsens(n,:) = ds_reward_sensor(tone_times(t)-framesaroundtone : tone_times(t)+framesaroundtone);
        catch
            aligned_l_n_tone(n,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_tone(tone_times(t)-framesaroundtone : end);
            aligned_l_n_trig(n,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_trigger_sensor(tone_times(t)-framesaroundtone : end);
            aligned_l_n_rewsens(n,1:length(ds_tone(tone_times(t)-framesaroundtone : end))) = ds_reward_sensor(tone_times(t)-framesaroundtone : end);
        end
        n = n+1;
    end
end

% Calculate aligned lever trace
go_lev_trace = aligned_l_g_trig-(0.5*aligned_l_g_rewsens);
go_lev_trace( go_lev_trace == -0.5) = 0;
no_lev_trace = aligned_l_n_trig-(0.5*aligned_l_n_rewsens);
no_lev_trace( no_lev_trace == -0.5) = 0;


fprintf('     ... Done!\n')

%% Get preemptives data
% remove lever movements before the first tone because we don't know what
% caused them
ds_trigger_sensor(1:tone_times(1)) = 0;
ds_reward_sensor(1:tone_times(1)) = 0;
ds_reset(1:tone_times(1)) = 0;

% finds onset time of pushes, resets and rewards
push_times = ds_trigger_sensor(2:end) - ds_trigger_sensor(1:end-1);
push_times(push_times ~= 0) = 1;
for i = 1:length(push_times);
    if push_times(i) ~= 0;
        push_times(i+1:i+300) = 0;
    end
end
push_events = find(push_times);

reset_times = ds_reset(2:end) - ds_reset(1:end-1);
reset_times(reset_times > 0) = 1;
for i = 1:length(reset_times);
    if reset_times(i) ~= 0;
        reset_times(i+1:i+300) = 0;
    end
end
reset_times(reset_times < 0 )  = 0 ;
reset_events = find(reset_times);

reward_times = ds_reward(2:end) - ds_reward(1:end-1);
reward_times(reward_times ~= 0) = 1;
for i = 1:length(reward_times);
    if reward_times(i) ~= 0;
        reward_times(i+1:i+3000) = 0;
    end
end



% Find preemptives times
preempt_times = [];
for t = 1:length(tone_times); % loop over trials
    curr_tone = tone_times(t);
    if t < length(tone_times);
        next_tone = tone_times(t+1);
        % look for pushes between the two tones
        if ~isempty(push_events(push_events>curr_tone & push_events < next_tone)); % There has been a push in this trial
            % See if push happens after first reset (condition to be a
            % preemptive)
            trial_push_times = push_events(push_events>curr_tone & push_events < next_tone);
            trial_reset_times = reset_events(reset_events>curr_tone & reset_events < next_tone);
            
            if ~isempty(find(trial_push_times > trial_reset_times(1))+250); % There have been pushes after first reset
                % the +250 is due to the fact that some times pushes happen
                % at the same time or immediately after the reset and we
                % need to discard them
                preempt_times = vertcat(preempt_times,trial_push_times(trial_push_times > trial_reset_times(1)+250)');  %#ok<AGROW>
            end
        end
    end
end
%
% figure; plot(ds_tone*1.25, 'k', 'LineWidth', 2); hold on;
% plot(push_times*0.9, 'ob', 'LineWidth', 4);
% plot(reset_times*0.95, '*r', 'LineWidth', 3);
% plot(reward_times, 'og', 'LineWidth', 2);
% plot(tone_type*0.5, 'r', 'LineWidth', 2);
% plot(preempt_times*0.8, 'om', 'LineWidth', 2);
% axis([0, inf, -0.1, 1.1]);

% Get preemptives aligned lever and paw data
xpe = zeros(length(preempt_times), framesaroundtone*2 +1);
ype = zeros(length(preempt_times), framesaroundtone*2 +1);
aligned_l_trig_pe = zeros(length(preempt_times), framesaroundtone*2 + 1);
aligned_l_rewsens_pe = zeros(length(preempt_times), framesaroundtone*2 + 1);

for p = 1:length(preempt_times);
    try
        xpe(p,:) = xcoord(preempt_times(p)-framesaroundtone:preempt_times(p)+framesaroundtone);
        ype(p,:) = ycoord(preempt_times(p)-framesaroundtone:preempt_times(p)+framesaroundtone);
        aligned_l_trig_pe(p,:) = ds_trigger_sensor(preempt_times(p)-framesaroundtone : preempt_times(p)+framesaroundtone);
        aligned_l_rewsens_pe(p,:) = ds_reward_sensor(preempt_times(p)-framesaroundtone : tone_preempt_timestimes(p)+framesaroundtone);
    catch
        if preempt_times(p)+framesaroundtone>length(xcoord);
            xpe(p,1:length(xcoord-preempt_times(p))) = xcoord(preempt_times(p)-framesaroundtone:end);
            ype(p,1:length(xcoord-preempt_times(p))) = ycoord(preempt_times(p)-framesaroundtone:end);
            aligned_l_trig_pe(p,1:length(ds_trigger_sensor-preempt_times(p))) = ds_trigger_sensor(preempt_times(p)-framesaroundtone :end);
            aligned_l_rewsens_pe(p,1:length(ds_trigger_sensor-preempt_times(p))) = ds_reward_sensor(preempt_times(p)-framesaroundtone : end);
        end
    end
end

% Calculate aligned lever trace for preempt
pe_lev_trace = aligned_l_trig_pe-(0.5*aligned_l_rewsens_pe);
pe_lev_trace( pe_lev_trace == -0.5) = 0;

%% Summary plot
fprintf('Plotting\n');
nonan_xgo = xgo; nonan_ygo = ygo;
nonan_xngo = xngo; nonan_yngo = yngo;
nonan_xpe = xpe; nonan_ype = ype;

xgo(xgo == 0) = nan; ygo(ygo == 0) = nan;
xngo(xngo == 0) = nan; yngo(yngo == 0) = nan;
xpe(xpe == 0) = nan; ype(ype == 0) = nan;


space = linspace(0, size(xngo,2),size(xngo,2));
c = linspace(0,1,length(xpe)); sz = 5;

figure('Name',figure_title,'NumberTitle','off');
set(gcf,'Color',[1 1 1])

%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax(1) = subplot(4,3,1, 'Position', [0.08, 0.7275, 0.225, 0.225]);
for i = 1:size(xgo,1);
    scatter(xgo(i,:), ygo(i,:), sz, c, 'filled'); hold on;
end
colormap(autumn); set(gca,'Color',[0.25, 0.25, 0.25])
plot(mean(xgo), mean(ygo), 'g', 'LineWidth', 2); 
plot(xgo(:,1)', ygo(:,1)', 'or', 'MarkerFaceColor', 'r');
plot(xgo(:,end)', ygo(:,end)', 'ob', 'MarkerFaceColor', 'b');
axis([0,1,0,1]); ylabel('Paw trajectory','FontSize',12)
title('\fontsize{16} Go trials');

ax2(1) = subplot(4,3,10, 'Position',[0.05, 0.06, 0.28, 0.15]);
plot(go_lev_trace', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, go_lev_trace, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(go_lev_trace), -0.01, 1]);
xlabel('frames');  title('Lever Position');

ax3(1) = subplot(4,3,7, 'Position', [0.05, 0.25, 0.28, 0.18]);
plot(nonan_ygo', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_ygo, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(nonan_xgo), 0, 1]);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
title('Y displacement');

ax4(1) = subplot(4,3,4, 'Position', [0.05, 0.475, 0.28, 0.18]);
plot(nonan_xgo', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_xgo, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(nonan_xgo), 0, 1]);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
title('X displacement');



%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax(2) = subplot(4,3,2, 'Position',[0.425, 0.7275, 0.225, 0.225]);
for i = 1:size(xngo,1);
    scatter(xngo(i,:), yngo(i,:), sz, c, 'filled'); hold on;
end
colormap(autumn); set(gca,'Color',[0.25, 0.25, 0.25]);
plot(mean(xngo), mean(yngo), 'g', 'LineWidth', 2); 
plot(xngo(:,1)', yngo(:,1)', 'or', 'MarkerFaceColor', 'r');
plot(xngo(:,end)', yngo(:,end)', 'ob', 'MarkerFaceColor', 'b');
axis([0,1,0,1]);
title('\fontsize{16} Nogo trials');

ax2(2) = subplot(4,3,11, 'Position',[0.38, 0.06, 0.28, 0.15]);
plot(no_lev_trace', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, no_lev_trace, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(go_lev_trace), -0.01, 1]);
xlabel('frames');
title('Lever Trace');

ax3(2) = subplot(4,3,8, 'Position', [0.38, 0.25, 0.28, 0.18]);
plot(nonan_yngo', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_yngo, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
axis([0, length(xgo), 0, 1]);
title('Y displacement');

ax4(2) = subplot(4,3,5, 'Position', [0.38, 0.475, 0.28, 0.18]);
plot(xngo', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_xngo, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(xgo), 0, 1]);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
title('X displacement');


%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax(3) = subplot(4,3,3, 'Position', [0.75, 0.7275, 0.225, 0.225]);
for i = 1:size(xpe,1);
    scatter(xpe(i,:), ype(i,:), sz, c, 'filled'); hold on;
end
colormap(autumn); set(gca,'Color',[0.25, 0.25, 0.25]);
plot(mean(xpe), mean(ype), 'g', 'LineWidth', 2); 
plot(xpe(:,1)', ype(:,1)', 'or', 'MarkerFaceColor', 'r');
plot(xpe(:,end)', ype(:,end)', 'ob', 'MarkerFaceColor', 'b');
axis([0,1,0,1]);
title('\fontsize{16} Preemptives');

ax2(3) = subplot(4,3,12, 'Position',[0.7, 0.06, 0.28, 0.15]);
plot(pe_lev_trace', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, pe_lev_trace, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(go_lev_trace), -0.01, 1]);
xlabel('frames');
title('Lever Trace');

ax3(3) = subplot(4,3,9, 'Position', [0.7, 0.25, 0.28, 0.18]);
plot(ype', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_ype, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(xgo), 0, 1]);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
title('Y displacement');

ax4(3) = subplot(4,3,6, 'Position', [0.7, 0.475, 0.28, 0.18]);
plot(xpe', 'color', [0.5, 0.5, 0.5]); hold on;
shadedErrorBar(space, nonan_xpe, {@mean, @std},'lineprops',{'-r','MarkerFaceColor','r', 'LineWidth', 2})
plot([1400 1400],[0 1], '- k', 'LineWidth', 2);
axis([0, length(xgo), 0, 1]);
set(gca,'xtick',[]);set(gca,'xticklabel',[]);
title('X displacement');

linkaxes(ax); linkaxes(ax2);
linkaxes(ax3); linkaxes(ax4);

fprintf('Script completed \n');


%%
test = 0;
numpts = 1000;

% Downsample lever data to match framerate of videos

xgo(isnan(xgo)) = 0; ygo(isnan(ygo)) = 0; 
xngo(isnan(xngo)) = 0; yngo(isnan(yngo)) = 0; 
xngo(isnan(xngo)) = 0; yngo(isnan(yngo)) = 0; 

if test;
    figure;
    
    subplot(1,3,1);
    idx = 1:length(xgo);                                       % Index
    idxq = linspace(min(idx), max(idx),numpts );           % Interpolation Vector
    for i = 1:size(xgo,1);
        ds_xgo = interp1(idx, double(xgo(i,:)), idxq, 'pchip' );       % Downsampled Vector
        ds_ygo = interp1(idx, double(ygo(i,:)), idxq, 'pchip' );       % Downsampled Vector
        plot3(ds_xgo, ones(length(ds_xgo))*i, ds_ygo, 'color', [1/size(xgo,1)*i,1/size(xgo,1)*i,1/size(xgo,1)*i], 'LineWidth', 2 ); hold on;
    end
    grid ON
    xlabel('x')
    ylabel('trial');
    zlabel('y');
    title('Go'); 
    
    subplot(1,3,2);
    idx = 1:length(xngo);                                       % Index
    idxq = linspace(min(idx), max(idx),numpts );           % Interpolation Vector
    for i = 1:size(xngo,1);
        ds_xngo = interp1(idx, double(xngo(i,:)), idxq, 'pchip' );       % Downsampled Vector
        ds_yngo = interp1(idx, double(yngo(i,:)), idxq, 'pchip' );       % Downsampled Vector
        plot3(ds_xngo, ones(length(ds_xngo))*i, ds_yngo, 'color', [1/size(xngo,1)*i,1/size(xngo,1)*i,1/size(xngo,1)*i], 'LineWidth', 2 ); hold on;
    end
    grid ON
     xlabel('x')
    ylabel('trial');
    zlabel('y');
    title('Nogo'); 
    
    subplot(1,3,3);
    idx = 1:length(xpe);                                       % Index
    idxq = linspace(min(idx), max(idx),numpts );           % Interpolation Vector
    for i = 1:size(xpe,1);
        ds_xpe = interp1(idx, double(xpe(i,:)), idxq, 'pchip' );       % Downsampled Vector
        ds_ype = interp1(idx, double(ype(i,:)), idxq, 'pchip' );       % Downsampled Vector
        plot3(ds_xpe, ones(length(ds_xpe))*i, ds_ype, 'color', [1/size(xpe,1)*i,1/size(xpe,1)*i,1/size(xpe,1)*i], 'LineWidth', 2 ); hold on;
    end
    grid ON
    xlabel('x')
    ylabel('trial');
    zlabel('y');
    title('Preempt.');    
    
end










