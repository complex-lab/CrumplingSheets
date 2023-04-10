function StageOsc(Stage,Hstart,Hfin,vel,repeat,AvgNum,ExpName)
% oscillate between Hstart and Hfin, repeat times
% move at vel; save the average of every AvgNum input values

MoveStage(Stage,Hstart,151);
while IsMoving(Stage)==1
end

pausetime=0.001;
lc = daq.createSession('ni');
addAnalogInputChannel(lc,'Dev1',0,'Voltage');
lc.Rate = 48000;
lc.IsContinuous = true;
lc.NotifyWhenDataAvailableExceeds = AvgNum; %1500
Stage.SetVelParams(0,0,10,vel);
TempName=strcat(ExpName,'_AvgOn',string(AvgNum),'_',string(Hstart),'mm_',string(Hfin),'mm_',string(vel),'mms');

global RunNum
mkdir('data\'+string(RunNum))

for ii=1:repeat
    FilenameDown=strcat(TempName,'_down_',string(ii),'.txt');
    data_fid = fopen(FilenameDown,'w');
    lh = addlistener(lc,'DataAvailable',@(src, event)logDataText(src, event, data_fid));
    MoveStage(Stage,Hfin,151);
    startBackground(lc);
    while IsMoving(Stage)==1
    end
    pause(pausetime)
    lc.stop;
    delete (lh)
    fclose(data_fid);
    pause(pausetime)
    FilenameUp=strcat(TempName,'_up_',string(ii),'.txt');
    data_fid = fopen(FilenameUp,'w');
    lh = addlistener(lc,'DataAvailable',@(src, event)logDataText(src, event, data_fid));
    MoveStage(Stage,Hstart,151);
    startBackground(lc);
    while IsMoving(Stage)==1
    end
    pause(pausetime)
    lc.stop;
    delete (lh)
    fclose(data_fid);
    pause(pausetime)
    
    ii
end
end