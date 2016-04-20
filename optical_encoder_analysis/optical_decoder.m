function [speed,position] = optical_decoder(traceA,traceB,optencset,radius)
%given the two traces coming from the optical encoder, it gives:
%speed of the wheel in deg/sec for each timebin and position in deg for
%each timebin.


global TIMEPERBIN

position=zeros(size(traceA));
dirmovement=zeros(size(traceA));
speed=zeros(size(traceA));

position(traceA<=2.38 & traceB>=2.38)=1;
position(traceA>=2.38 & traceB>=2.38)=2;
position(traceA>=2.38 & traceB<=2.38)=3;

dirmovement((position(2:end)-position(1:end-1))==1 | (position(2:end)-position(1:end-1))==-3)=-1;
dirmovement((position(2:end)-position(1:end-1))==-1 | (position(2:end)-position(1:end-1))==3)=1;

movementtime=find(dirmovement~=0);
movementlag=[0;0;0;0;movementtime(5:end)-movementtime(1:end-4)];

speed(movementtime)=movementlag;

ii=0;
jj=0;
while ii<length(speed) && jj<length(movementtime)
   ii=ii+1;
   jj=jj+1;
   
   %speed(ii:movementtime(jj))=movementlag(jj);
   
   if dirmovement(movementtime(jj))>0
   speed(ii:movementtime(jj))=movementlag(jj);
   elseif dirmovement(movementtime(jj))<0
   speed(ii:movementtime(jj))=-movementlag(jj);
   end

   ii=movementtime(jj);
    
end


speed(speed~=0)=(radius*pi/optencset.cpr)./(speed(speed~=0)*TIMEPERBIN);



position=cumsum(dirmovement)*360/optencset.cpr/4;


end

