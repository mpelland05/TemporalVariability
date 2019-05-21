[model_group.x,model_group.labels_x,model_group.labels_y] = niak_read_csv('blindVariability_model_group_CBSC_Only.csv'); %Load model

opt.test.Var_CBvsSC.group.contrast.Var_CBvsSC        = 1;                      
opt.test.Var_CBvsSC.group.contrast.age           = 0;
opt.test.Var_CBvsSC.group.contrast.sex           = 0;
opt.test.Var_CBvsSC.group.contrast.FDrest        = 0;

model_group = niak_normalize_model(model_group, opt.test.Var_CBvsSC.group);

%model_group.c = [ones(1,14) zeros(1,17)];


load('C:\Users\Maxime Pelland\Desktop\Temp\CompiledWindowedResults.mat')

model_group.y = [VarResults.CBxxx.rest.Std VarResults.SCxxx.rest.Std];

opt_glm_gr.test  = 'ttest' ;
opt_glm_gr.flag_beta = true ; 
opt_glm_gr.flag_residuals = true ;
y_x_c.x = model_group.x;
y_x_c.y = model_group.y';
y_x_c.c = model_group.c; 
[results, opt_glm_gr] = niak_glm(y_x_c , opt_glm_gr);
