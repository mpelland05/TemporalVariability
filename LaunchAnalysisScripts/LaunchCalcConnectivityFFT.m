files_in.path = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';
files_in.fisher = 1;
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest' 'task'};
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';

CalcConnectivityFFT(files_in,files_out)