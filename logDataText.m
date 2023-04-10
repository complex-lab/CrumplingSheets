% a method for the listener of the load-controller
% writes the code to a matlab file (m file)
function logDataTextVar(src, event, fileID)
    timeanddata = [event.TimeStamps, event.Data];
%    fprintf(fileID,'%f, %f\n',timeanddata);
    fprintf(fileID,'%f, %f\n',mean(timeanddata,1));
%     fwrite(fileID,timeanddata,'double');
end

% function logData(src, event, filename)  
% event
%     timeanddata = [event.TimeStamps, event.Data]';
%     csvwrite(filename,timeanddata);
% end

% function logData(src, evt, fid)
% % Add the time stamp and the data values to data. To write data sequentially,
% % transpose the matrix.
% 
% %   Copyright 2011 The MathWorks, Inc.
% 
% data = [evt.TimeStamps, evt.Data]' ;
% fwrite(fid,data,'double');
% end