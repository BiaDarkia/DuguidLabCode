function [timevid,motionindexsq]=make_motion_analysis_flexible(vidname,save_path,varargin)
% makevideoanalysis calculates the motion index of the whole video and the
% selected ROI


fprintf('Opening video: %s \n\n',vidname)

if exist(vidname,'file')
    
    videoObj = VideoReader(vidname);
    
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
    
    xrange=floor(min(xrange):max(xrange));
    yrange=floor(min(yrange):max(yrange));
    
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
            
            [timevidreg,motionindexsqreg]=regularize_motion_flexible(timevid,motionindexsq);
            
            est=sprintf('.csv');
            vidnamesave=sprintf(vidname,frameID,est);
            %fprintf('Saving .csv file: %s \n\n',vidnamesave)
            
            A=[timevidreg', motionindexsqreg(1,:)'];
            %save(vidnamesave,'A','-ascii','-double','-tabs')
            
        end
        
    end
    
    timevid=d_time:d_time:d_time*num_frames;
    
    motionindexsq(1,:)=motionindexsq(1,:)./(vid_height*vid_width);
    motionindexsq(2,:)=motionindexsq(2,:)./(length(xrange)*length(yrange));
    
    [timevidreg,motionindexsqreg]=regularize_motion_flexible(timevid,motionindexsq);
    
    A   =[timevidreg', motionindexsqreg(1,:)'];
    Aroi=[timevidreg', motionindexsqreg(2,:)'];
    
    est=sprintf('.csv');
    
    vidnamesavesq=sprintf('%s\%s_%s%s',save_path,vidname,'MI',est);
    fprintf('Saving .csv file: %s \n\n',vidnamesavesq)
    save(vidnamesavesq,'A','-ascii','-double','-tabs')

    vidnamesaveroi=sprintf('%s\%s_%s%s',save_path,vidname,'MI_ROI',est);
    fprintf('\n\nSaving the .csv file: %s%s \n',video_data_path,vidnamesaveroi)
    save(vidnamesaveroi,'Aroi','-ascii','-double','-tabs')
    
else
    fprintf('Did not found .m4v video: %s %s \n',video_data_path,vidname)
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