
%% Import data from text file
clear
txt_path = "D:\Yaniv\CrumplingSheets\oscillation_data1_2020_01_21.txt";
chunk_size = 1e7 ; 
first_line = 1 ; 

smooth_window = 5 ;

[data, time] = read_data_from_txt(txt_path, chunk_size, first_line);

num_lines = 5e7 ;

    
time_of_peaks = [0];
time_between_peaks = [];

still_go = true ; 
first = true ; 
step = 1 ; 
while still_go 
    tic
% while first_line < chunk_size * 20 
    try
        [data, time] = read_data_from_txt(txt_path, chunk_size, first_line);
    catch
        warning('end of file')
        still_go = false ; 
        break
    end
    
    fs = 1/(time(2) - time(1));
    smooth = movmean(data, smooth_window) ;
    filtered = bandpass(smooth,[1000, 3000], fs) ;


    [~,locs] = findpeaks(filtered,'MinPeakHeight',0.014 ,'MinPeakDistance',(1/(time(2)-time(1))/50)) ;
    if isempty(locs)
        first_line = first_line + chunk_size ; 
        disp('empty locs on step %d !! \n', step)
        step = step + 1 ;
        continue
    end
%     plot(time, flat, 'b')
%     hold on
%     plot(time(locs), pks, '.r')
%     hold off

    if not(first)
        time_between_peaks = [time_between_peaks; time(locs(1)) - time_of_peaks(end)] ; 
    end
    curr_time_of_peaks = time(locs) ; 
    time_of_peaks = [time_of_peaks; curr_time_of_peaks] ;
    time_between_peaks = [time_between_peaks; curr_time_of_peaks(2:end)- curr_time_of_peaks(1:end-1)];

    
    first = false ;   
    fprintf('processed line %d to %d \n', first_line, first_line + chunk_size)
    fprintf('finished step number %d \n', step)

    first_line = first_line + chunk_size ;
    step = step + 1 ;
    toc
    if mod(step, 10) == 0
        save('time_of_peaks_final' + string(step) +'.mat','time_of_peaks')
    end
end
disp('finished!!')

temp_peaks = temp_peaks(and(mod(temp_peaks, 25) > 15/40000 ,(25 - mod(temp_peaks, 25)) > 20/40000)) ; 
figure
% loglog(time_of_peaks(2:end), time_of_peaks(2:end) - time_of_peaks(1:end-1), '.')
loglog(temp_peaks(2:end), temp_peaks(2:end) - temp_peaks(1:end-1), '.')
xlabel('time')
ylabel('waiting time')

save('time_of_peaks_final.mat','time_of_peaks')
