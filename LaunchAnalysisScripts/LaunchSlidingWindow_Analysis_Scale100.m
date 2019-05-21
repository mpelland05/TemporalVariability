files_in.path = '/home/mpelland/database/blindVariability/fmri/AveragedTseries/Scale_100/';
files_in.run = {'rest' 'task'};
files_in.WinSiz = 21;
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';

mkdir(files_out);

SlidingWindow_Analysis(files_in,files_out)