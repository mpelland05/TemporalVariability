function StartNiakGLM(files_in,files_out),
%This script launches an analysis to compare two groups using the GLM. 
%
%files_in  
%       .model  string, full path to .csv file containing the covariates. 
%               Note, the last column of the model should contain the
%               contrast of interest and should bear the name that you
%               desire the results to take.
%       .data   string, full path to .mat file containing the data.
%       .rPath  cell of strings, must contain a path for both group that
%               will be compaired. This path must be that path inside the
%               structure found in files_in.data. 
%               Example:  'VarResults.CBxxx.rest.Std'
%
%files_out      string, full path to a .mat file which will contain the
%               results.
%Output consist of 


%%%%%%
% Load model
%%%%%
[model.x,model.labels_x,model.labels_y] = niak_read_csv(files_in.model); %Load model

%Set up contrast (assign all covariates that are not the last as covariates
%of interest
TestLabel = model.labels_y{length(model.labels_y)};

for ff = 1:length(model.labels_y)-1,
    opt.test.(TestLabel).group.contrast.(model.labels_y{ff}) = 0;
end
opt.test.(TestLabel).group.contrast.(TestLabel) = 1;

model = niak_normalize_model(model, opt.test.(TestLabel).group);

model.c
model.x

%%%%%%
% Load data
%%%%%%
load(files_in.data);

model.y = [ eval(files_in.rPath{1}) eval(files_in.rPath{2}) ];


%%%%%%
% run GLM
%%%%%%
opt.test  = 'ttest' ;
opt.flag_beta = true ; 
opt.flag_residuals = true ;
yxc.x = model.x;
yxc.y = model.y';
yxc.c = model.c; 
[GLM_Results, opt] = niak_glm( yxc , opt );

if exist('VarResults'),
    GLM_Results.Mask = VarResults.Mask;
    GLM_Results.WindowSize = VarResults.WindowSize;
    GLM_Results.Labels_rois =  VarResults.Labels_rois;
    GLM_Results.Fisher = VarResults.Fisher;
    GLM_Results.Info = 'See niak_glm for information on outputs';
end

save(files_out, 'GLM_Results')
end