function [timevid,motionindexsq]=make_motion_analysis(date,file_num,video_data_path,varargin)
% makevideoanalysis calculates the motion index of the whole video and the
% selected ROI

est1=sprintf('.m4v');
est2=sprintf('.mp4');
filename1=sprintf('%s%s_%s%s',video_data_path,date,file_num,est1);
filename2=sprintf('%s%s_%s%s',video_data_path,date,file_num,est2);


if exist(filename1,'file')
    est=est1;
elseif exist(filename2,'file')
    est=est2;
end


filename=sprintf('%s%s_%s%s',video_data_path,date,file_num,est);
fprintf('Opening video: %s \n\n',filename)

if exist(filename,'file')
    
    videoObj = VideoReader(filename);
    
    num_frames = videoObj.NumberOfFrames;
    vid_height = videoObj.Height;
    vid_width = videoObj.Width;
    d_time=1/videoObj.FrameRate;
    
    if ~isempty(varargin)
        xrange=varargin{1};
        yrange=varargin{2};
    else
        xrange=[1;vid_width];
        yrange=[1;vid_heigth];
    end
    
    xrange=min(xrange):max(xrange);
    yrange=min(yrange):max(yrange);
    
    % Read one frame at a time.
    frameID=1;
    frameA = read(videoObj, frameID);
    
    motionindexsq=zeros(3,num_frames);
    
    tic
    for frameID = 2 : num_frames
        
        frameB=read(videoObj, frameID);
        difference=(frameB(:,:,1)-frameA(:,:,1));
        differenceRoi=(frameB(yrange,xrange,1)-frameA(yrange,xrange,1));
        
        motionindexsq(1,frameID)=sum(sum(difference.^2));
        motionindexsq(2,frameID)=sum(sum(differenceRoi.^2));
        
        clear difference
        clear differenceRoi
        
        frameA=frameB;
        
        
        if motionindexsq(1,frameID)==0 && frameID>3
            frameA(100,100,:)
            beep
        end
        
        
        if rem(frameID,500)==0
            toc
            fprintf('Analysing %i / %i frames\n',frameID,num_frames);
            tic
            
            timevid=d_time:d_time:d_time*frameID;
            
            [timevidreg,motionindexsqreg]=regularize_motion(timevid,motionindexsq);
            
            est=sprintf('.csv');
            filenamesave=sprintf('%s%s_%s_%d%s',video_data_path,date,file_num,frameID,est);
            %fprintf('Saving .csv file: %s \n\n',filenamesave)
            
            A=[timevidreg', motionindexsqreg(1,:)'];
            %save(filenamesave,'A','-ascii','-double','-tabs')
            
        end
        
    end
    
    timevid=d_time:d_time:d_time*num_frames;
    
    motionindexsq(1,:)=motionindexsq(1,:)./(vid_height*vid_width);
    motionindexsq(2,:)=motionindexsq(2,:)./(length(xrange)*length(yrange));
    
    [timevidreg,motionindexsqreg]=regularize_motion(timevid,motionindexsq);
    
    A   =[timevidreg', motionindexsqreg(1,:)'];
    Aroi=[timevidreg', motionindexsqreg(2,:)'];
    
    est=sprintf('.csv');
    filenamesavesq=sprintf('%s%s_%s%s',video_data_path,date,file_num,est);
    fprintf('Saving .csv file: %s %s \n\n',video_data_path,filenamesavesq)
    
    save(filenamesavesq,'A','-ascii','-double','-tabs')
    
    filenamesaveroi=sprintf('%s%s_%s_Roi%s',video_data_path,date,file_num,est);
    fprintf('\n\nSaving the .csv file: %s%s \n',video_data_path,filenamesaveroi)
    save(filenamesaveroi,'Aroi','-ascii','-double','-tabs')
    
else
    fprintf('Did not found .m4v video: %s %s \n',video_data_path,filename)
end

figure
plot(timevidreg,motionindexsqreg(1,:));
hold on
plot(timevidreg,motionindexsqreg(2,:),'r');
xlabel('time (s)')
ylabel('M.I.')
legend('FullFrame','Roi')


clear videoObj

end
