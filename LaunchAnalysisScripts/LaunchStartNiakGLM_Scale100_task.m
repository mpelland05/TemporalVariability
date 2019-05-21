files_in.model = 'F:\Variability\Models\blindVariability_model_group_CBSC_Only_task.csv';
files_in.data = 'F:\Variability\fmri\Windowed\Scale100\CompiledWindowedResults.mat';
files_in.rPath = {'VarResults.CBxxx.task.Std' 'VarResults.SCxxx.task.Std'};
files_out = 'F:\Variability\results\GLMResults_full_connectome_task.mat';

StartNiakGLM(files_in,files_out);