files_in.path = '/home/mpelland/database/blindtvr/fmri/fmri_preprocess_01_noFD/';
files_in.fType = '.mnc.gz';
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest' 'task'};
files_in.mask = '/home/mpelland/database/blindtvr/fmri/BascSpecial101/stability_group/sci1_scg1_scf1/brain_partition_consensus_group_sci1_scg1_scf1.mnc.gz';
files_in.scale = 101;
files_out = '/home/mpelland/database/blindtvr/fmri/AveragedTseries/';

mkdir(strcat( files_out,'Scale_',num2str(files_in.scale) ));

ExtractTseries4WindowAnalysis(files_in,files_out)
