%% script that save all open figures with their name in the folder selected by the user

current_folder = cd; 

folder_name = uigetdir;
cd(folder_name);


h = get(0,'children');
mkdir(folder_name, 'FIG');  cd('FIG');
for i=1:length(h)
    Title = h(i).Name;
    saveas(h(i),[Title '.fig']); % Save all figs as .FIG matlab file files
end

cd(folder_name);
mkdir(folder_name, 'PNG'); cd('PNG');
for i=1:length(h)
    Title = h(i).Name;
    saveas(h(i),[Title '.png']); % Save all figs as .PNG matlab file files
end

cd(current_folder); 