%% This script is to clean up the metadata file if anything untoward occurrs:

clear all

MetaPathList

currentfolder=pwd;
pathfolder=metadataPath;
cd(pathfolder);

mouse_metadata=[];

load('Lever_training_cued_metadata.mat');

%append row numbers for ease of use
[r c]=size(mouse_metadata);
a=(1:r)';
b=num2cell(a);
mouse_metadata=[b';mouse_metadata']';

sprintf('Diplaying current mouse_metadata:');
display(mouse_metadata)

reply=input('Enter the row number you would like to remove:');

mouse_metadata(reply,:)=[];
mouse_metadata(:,1)=[];

[r c]=size(mouse_metadata);
a=(1:r)';
b=num2cell(a);
mouse_metadata=[b';mouse_metadata']';

sprintf('Diplaying modified mouse_metadata:');
display(mouse_metadata)

reply2=input('Is this correct? Would you like to overwrite Lever_training_metadata? [Y/N]: ','s');
if isempty(reply)
    reply = 'N';
    mouse_metadata(:,1)=[];
end
if strcmp(reply2,'Y');
    mouse_metadata(:,1)=[];
        save('Lever_training_cued_metadata.mat','mouse_metadata');
end

reply3=input('Would you like to further modifiy Lever_training_metadata.mat? [Y/N]: ','s');

if strcmp(reply3,'Y')
    metadataCleanerCued
end