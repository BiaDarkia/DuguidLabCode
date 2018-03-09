function [x,y] = define_roi_flexible(vidname)
% define_roi defines the region of interest within each video within which
% to calculate the motion index


if exist(vidname,'file')
    fprintf('Opening video: %s \n',vidname)
    videoObj = VideoReader(vidname);
    
    vid_height = videoObj.Height;
    vid_width = videoObj.Width;
    
    % Read one frame.
    frameID=40;
%     [I, cmap] = read(videoObj, frameID);
%     frame = im2frame(I, cmap);

        frame = im2frame(gray2rgb(read(videoObj, frameID)));
    set(gcf,'position', [150 150 vid_width vid_height])
    set(gca,'units','pixels');
    set(gca,'position',[0 0 vid_width vid_height])
    
    % Display one frame
    image(frame.cdata,'Parent',gca);
    axis off;
    
    % Define the corners of the ROI bounding box
    ii=0;
    while ii<2
        ii=ii+1;
        [x(ii),y(ii)] = ginput(1);
        hold on
        plot(x(ii),y(ii),'r.','MarkerSize',10)
        
        if ii==2
            plot(x(1),y(2),'r.','MarkerSize',10)
            plot(x(2),y(1),'r.','MarkerSize',10)
            
            
            
            if strcmp('Y',input('\nDo you want to reselect? [Y/N]: ', 's'))
                ii=0;
                plot(x(1),y(2),'k.','MarkerSize',10)
                plot(x(2),y(1),'k.','MarkerSize',10)
                plot(x(1),y(1),'k.','MarkerSize',10)
                plot(x(2),y(2),'k.','MarkerSize',10)
            end
        end
        
    end
    
    close all
end

