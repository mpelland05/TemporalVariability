files_in.path = '/home/mpelland/database/blindtvr/fmri/Windowed/Scale101/';
files_in.fisher = 1;
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest' 'task'};
files_out = '/home/mpelland/database/blindtvr/fmri/Windowed/Scale101/';

CalcConnectivityVariability(files_in,files_out)