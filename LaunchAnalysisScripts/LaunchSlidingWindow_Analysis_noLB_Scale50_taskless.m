files_in.path = '/home/mpelland/database/blindVariability/fmri/AveragedTseries_noLB/Scale_50/';
files_in.run = {'rest'};
files_in.WinSiz = 21;
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale50/';

mkdir(files_out);

SlidingWindow_Analysis_special(files_in,files_out)


files_in.path = '/home/mpelland/database/blindVariability/fmri/AveragedTseries_noLB/Scale_100/';
files_in.run = {'rest'};
files_in.WinSiz = 21;
files_out = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/';

mkdir(files_out);

SlidingWindow_Analysis(files_in,files_out)