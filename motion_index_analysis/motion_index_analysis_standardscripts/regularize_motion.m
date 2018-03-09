function        [timevidreg,motionindexreg]=regularize_motion(timevid,motionindex)
%regularize_motion normalises the motion index, ignoring the first 20
%frames of the video

timevid(1:20)=[];
timevidreg=timevid;
motionindex(:,1:20)=[];
motionindex(:,length(timevidreg)+1:end)=[];

minmotion=min(motionindex,[],2);

motionindexreg=bsxfun(@minus,motionindex,minmotion);


end