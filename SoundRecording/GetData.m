clear all
close all
devices = daq.getDevices ; 
lc = daq.createSession('ni');
% addAnalogInputChannel(s,'Dev1', 0, 'Voltage');  % cDAQ1Mod4
addAnalogInputChannel(lc,'Dev1', 1, 'Voltage');  % cDAQ1Mod4

lc.Rate = 40000 ; 
% s.DurationInSeconds = 2 ;

% data = s.inputSingleScan ; 

% [data,time] = s.startForeground ;
data_fid = fopen('oscillation_data1_2020_01_21.txt','w');
lh = lc.addlistener('DataAvailable',@(src, event)logDataText(src, event, data_fid));

%%
% https://www.mathworks.com/help/daq/examples/log-analog-input-data-to-a-file-using-ni-devices.html
% fid1 = fopen('log.bin','w');
% lh = addlistener(s,'DataAvailable',@(src, event)logData(src, event, fid1));
% s.IsContinuous = true;
% s.startBackground;

% s.stop;
% delete(lh);
% fclose(fid1);
tic

lc.IsContinuous = true;
lc.startBackground;
disp('Starting!!!')
pause(3600 * 50)
% pause(30)
lc.stop;
pause(1)
delete(lh);
fclose(data_fid);
toc

process_data
%%

% data1 = data(:, 1) ;
% data2 = data(:, 2) ;
% smooth1 = movmean(data1, window) ;
% smooth2 = movmean(data2, window) ;

% % plot(time, smooth1, '.') ;
% plot(time, data,'.');
% xlabel('Time (secs)') ;
% ylabel('Voltage')