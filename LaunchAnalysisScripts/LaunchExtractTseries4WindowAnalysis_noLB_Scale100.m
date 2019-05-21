files_in.path = '/home/mpelland/database/blindVariability/fmri/fmri_preprocess_01/';
files_in.fType = '.mnc.gz';
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = {'rest'};
files_in.mask = '/home/mpelland/database/blindtvr/fmri/basc_02_noLB/stability_group/sci100_scg100_scf100/brain_partition_consensus_group_sci100_scg100_scf100.mnc.gz';
files_in.scale = 100;
files_out = '/home/mpelland/database/blindVariability/fmri/AveragedTseries_noLB/';

mkdir(strcat( files_out,'Scale_',num2str(files_in.scale) ));

ExtractTseries4WindowAnalysis(files_in,files_out)