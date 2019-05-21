files_in.path = '/home/mpelland/database/blindtvr/fmri/AveragedTseries/Scale_101/';
files_in.run = {'rest' 'task'};
files_in.WinSiz = 21;
files_out = '/home/mpelland/database/blindtvr/fmri/Windowed/Scale101/';

mkdir(files_out);

SlidingWindow_Analysis(files_in,files_out)
