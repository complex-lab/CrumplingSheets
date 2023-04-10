function Stage=InitializeStage

clear; close all; clc;
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height 
f = figure('Position', fpos,'Menu','None',...
           'Name','APT GUI');
Stage = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);
Stage.StartCtrl;
% SN = 45859847;
SN=45912350;
set(Stage,'HWSerialNum', SN);
Stage.Identify;
Stage.SetBLashDist(0,0);
% pause(5);