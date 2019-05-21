files_in.path = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';
files_in.fisher = 1;
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest'};
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';

CalcConnectivityVariability(files_in,files_out)


files_in.path = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale50/';
files_in.fisher = 1;
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest'};
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale50/';

CalcConnectivityVariability(files_in,files_out)