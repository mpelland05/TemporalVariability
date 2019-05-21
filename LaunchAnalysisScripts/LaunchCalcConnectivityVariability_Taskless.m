files_in.path = '/home/mpelland/database/blindVariability/fmri/Windowed_taskless/Scale50/';

files_in.fisher = 1;

files_in.groups = {'CBxxx' 'SCxxx'};

files_in.run = {'task'};

files_out = '/home/mpelland/database/blindVariability/fmri/Windowed_taskless/Scale50/';


CalcConnectivityVariability(files_in,files_out)

