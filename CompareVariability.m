function CompareVariability(files_in,files_out),
%
%files_in
%       .path   string, full path to folder that will contain the results
%       .groups cell of string, name of the groups that will be compared
%       .runs   string, condition that will be studied (so conditions cannot be
%               compared with this script
%       .nperm  number of permutations to be applied
%
%files_out      string, full path to .mat file where results will be saved

files_in.path = '/home/mpelland/database/blindVariability/fmri/Windowed/Scale100/CompiledWindowedResults.mat';
files_in.groups = {'CBxxx' 'SCxxx'};
files_in.run = 'rest';
files_in.nperm = 10000;
files_out = '/home/mpelland/database/blindVariability/results/CompiledResults_'

%START!
load(files_in.path);

group1 = VarResults.(files_in.groups{1}).(files_in.run).Std;
group2 = VarResults.(files_in.groups{2}).(files_in.run).Std;

[pvalues Average STDev] = PermutationTest(group1,group2,files_in.nperm,files_in.groups);
[fdr,test_q] = niak_fdr(pvalues, 'LSL',0.05);

VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).pvalues = pvalues;
VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).average = Average;
VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).STDev = STDev;
VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).nperm = files_in.nperm;
VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).fdr = fdr;
VarResults.(strcat( files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run )).test_q = test_q;

tmat = niak_vec2mat(pvalues,0);
siz = size(tmat,1);

rNam = strcat( files_out, files_in.groups{1},'_vs_',files_in.groups{2},'_',files_in.run, '_Scale', num2str(siz),'.mat' );

save( rNam , 'VarResults');

end

