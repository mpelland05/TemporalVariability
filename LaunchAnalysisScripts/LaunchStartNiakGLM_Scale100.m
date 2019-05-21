files_in.model = 'F:\Variability\Models\blindVariability_model_group_CBSC_Only.csv';
files_in.data = 'F:\Variability\fmri\Windowed\Scale100\CompiledWindowedResults.mat';
files_in.rPath = {'VarResults.CBxxx.rest.Std' 'VarResults.SCxxx.rest.Std'};
files_out = 'F:\Variability\results\GLMResults_full_connectome.mat';

StartNiakGLM(files_in,files_out);