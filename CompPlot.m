function CompPlot(Hstart1,Hfin1,vel1,AvgNum1,ExpName1,skip1,name1,Hstart2,Hfin2,vel2,AvgNum2,ExpName2,skip2,name2)

% boring variables for importing text
opts = delimitedTextImportOptions("NumVariables", 2);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["time", "data"];
opts.VariableTypes = ["double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

TempName1=strcat(ExpName1,'_AvgOn',string(AvgNum1),'_',string(Hstart1),'mm_',string(Hfin1),'mm_',string(vel1),'mms');
TempName2=strcat(ExpName2,'_AvgOn',string(AvgNum2),'_',string(Hstart2),'mm_',string(Hfin2),'mm_',string(vel2),'mms');
figure(20); hold on; box on;

legend()

for kk=5:1:5
 
    FilenameDown=strcat('D:\Negev\MATLAB\',TempName1,'_down_2');
    DataDown = readtable(FilenameDown, opts);
    plot(Hstart1+vel1.*DataDown.time,(DataDown.data)*-0.4923-0.30963,'LineWidth',1, 'DisplayName',name1);
    offset = find(DataDown.time,1,"first");

    %{
    FilenameUp=strcat('D:\Negev\MATLAB\',TempName,'_up_',string(kk+skip));
    DataUp = readtable(FilenameUp, opts);
    plot(Hstart+vel.*(max(DataUp.time)-DataUp.time),(DataUp.data)*-0.4923,'color',GradientColor,'LineWidth',1);
    %}
    
end
set(gca,'FontSize',14)
ylabel('Force [N]','fontsize',16);
xlabel('Displacement [mm]','fontsize',16);

for kk=2:1:2
 
    FilenameDown=strcat('D:\Negev\MATLAB\',TempName2,'_down_',string(kk+skip2));
    DataDown = readtable(FilenameDown, opts);
    plot(Hstart2+vel2.*DataDown.time,(DataDown.data)*-0.4923-0.30963,'LineWidth',1, 'DisplayName',name2);
    
    %{
    FilenameUp=strcat('D:\Negev\MATLAB\',TempName,'_up_',string(kk+skip));
    DataUp = readtable(FilenameUp, opts);
    plot(Hstart+vel.*(max(DataUp.time)-DataUp.time),(DataUp.data)*-0.4923,'color',GradientColor,'LineWidth',1);
    %}
    
end
set(gca,'FontSize',14)
ylabel('Force [N]','fontsize',16);
xlabel('Displacement [mm]','fontsize',16);


end
