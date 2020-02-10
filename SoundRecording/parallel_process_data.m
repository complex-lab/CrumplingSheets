
%% Import data from text file
clear
txt_path = "D:\Yaniv\CrumplingSheets\oscillation_data1_2020_01_21.txt";
chunk_size = 1e7 ; 
first_line = 1 ; 

tot_secs = 3600*50 ; 
last_step = tot_secs * 40000 / chunk_size ; 
smooth_window = 5 ;
    
time_of_peaks = [0];

still_go = true ; 
first = true ; 
step = 1 ; 
parfor ii = 0:last_step - 1
    tic
    
    first_line = (chunk_size*ii) + 1 ; 
    [data, time] = read_data_from_txt(txt_path, chunk_size, first_line);
    
    fs = 1/(time(2) - time(1));
    smooth = movmean(data, smooth_window) ;
    filtered = bandpass(smooth,[1000, 3000], fs) ;


    [~,locs] = findpeaks(filtered,'MinPeakHeight',0.014 ,'MinPeakDistance',(1/(time(2)-time(1))/50)) ;
    if isempty(locs)
        disp('empty locs on step %d !! \n', step)
        continue
    end
    

    curr_time_of_peaks = time(locs) ; 
    time_of_peaks = [time_of_peaks; curr_time_of_peaks] ;
    
    fprintf('processed line %d to %d \n', first_line, first_line + chunk_size)
    fprintf('finished step number %d \n', ii)

    toc
    if mod(step, 10) == 0
        save('parallel_time_of_peaks_final' + string(step) +'.mat','time_of_peaks')
    end
end
disp('finished!!')

temp_peaks = temp_peaks(and(mod(temp_peaks, 25) > 15/40000 ,(25 - mod(temp_peaks, 25)) > 20/40000)) ; 
figure
% loglog(time_of_peaks(2:end), time_of_peaks(2:end) - time_of_peaks(1:end-1), '.')
loglog(temp_peaks(2:end), temp_peaks(2:end) - temp_peaks(1:end-1), '.')
xlabel('time')
ylabel('waiting time')

