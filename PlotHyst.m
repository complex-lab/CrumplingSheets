function PlotHyst(Hstart,Hfin,vel,Repeat,AvgNum,ExpName,skip)

% boring variables for importing text
opts = delimitedTextImportOptions("NumVariables", 2);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["time", "data"];
opts.VariableTypes = ["double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

TempName=strcat(ExpName,'_AvgOn',string(AvgNum),'_',string(Hstart),'mm_',string(Hfin),'mm_',string(vel),'mms');
figure(); hold on; box on;

% y = 0.4939x - 1.7441 old calibration of the force 
for kk=1:1:Repeat-skip
    
    GradientColor = (kk/(Repeat-skip))*[0,0,1]+((Repeat-skip-kk)/(Repeat-skip))*[1, 0, 0]	;

    FilenameDown=strcat('D:\Negev\MATLAB\',TempName,'_down_',string(kk+skip));
    DataDown = readtable(FilenameDown, opts);
    plot(Hstart+vel.*DataDown.time,(DataDown.data)*-0.4923,'color',GradientColor,'LineWidth',1);

    FilenameUp=strcat('D:\Negev\MATLAB\',TempName,'_up_',string(kk+skip));
    DataUp = readtable(FilenameUp, opts);
    plot(Hstart+vel.*(max(DataUp.time)-DataUp.time),(DataUp.data)*-0.4923,'color',GradientColor,'LineWidth',1);
    
end
set(gca,'FontSize',14)
ylabel('Force [N]','fontsize',16);
xlabel('Displacement [mm]','fontsize',16);

saveas(gcf,[string(ExpName)+'.fig'])
end
