Picker = uicontrol('Style', 'listbox', ...
    'Position', [20 600 130 140], ...
    'Tag', 'List',...
    );

str{1}  = 'Delay/tone';
str{2}  =  'Windows';
str{3}  = 'Hits';
str{4}  =  'Misses';
str{5}  = 'False Alarms';
str{6}  =  'Correct Rejections';
str{7}  = 'Preemptives Delay';
str{8}  =  'Preemptives ITI';
str{9}  = 'Tone Efficiency GO';
str{10} =  'Tone Efficiency NOGO';
str{11} = 'Reaction Time';
str{12} =  'Discimination Index';
set(Picker,'String',str);

Selected = get(Picker, 'value');
ListSelected = get(Picker, 'String');

Plotter = uicontrol('Style', 'pushbutton', ...
    'String', 'Plot!',...
    'Position', [50 575 65 20]);