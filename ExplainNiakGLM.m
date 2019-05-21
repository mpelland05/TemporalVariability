%% Read the individual fMRI datasets and generate the spc connectomes

    %% Read and prepare the group model
    [model_group.x,model_group.labels_x,model_group.labels_y] = niak_read_csv(files_in.model.group); %Load model    
    opt.test.(label).group.labels_x = fieldnames(files_in.fmri) ;                                    %Prepare the name of people for the test?
    model_group = niak_normalize_model(model_group, opt.test.(label).group);

%% Loop over subjects

    %% Extract the individual models
 
    %% Read the inter-run model if exists, to get the list of runs that needs to be processed
 
    %% Loop over runs

        %% Read the fMRI time series of the run
            model_run = sub_read_time_series(files_in,mask,subject,run);
                %% Read time series into a structure
                %% MODEL_RUN.TIME_SERIES : array of time series (column-wise)
                %% MODEL_RUN.TIME_FRAMES : time associated with each sample
                %% MODEL_RUN.MASK_SUPPRESSED : a boolean mask of the volumes that were suppressed in the original time series
                %% MODEL_RUN.CONFOUNDS : a matrix of confounds that were regressed out of time series (column-wise)
                %% MODEL_RUN.LABELS_CONFOUNDS : a cell of strings with the labels of the
                %% confounds
                
        %% Select the files for the intra-run model ("covariate" and "event")
                %adds to the model_run computed earlier to model events or
                %covariates (such as reaction times)
        %% Compute the statistical parametric connectome at the level of intra run        
        [spc_intra_run,all_run.(subject).(run),opt.test.(label).run] = niak_glm_connectome_run(model_run,opt.test.(label).run);        

        %% Compute the connectome associated with the run  
        spc_inter_run(num_r,:) = spc_intra_run ; % matrix of run x connections 
    % end of runs
    
    %% Estimate the inter-run model
    model_inter.y  = spc_inter_run;
    [results,opt_glm] = niak_glm(model_inter,opt_glm);   
 
    spc_subject(num_s,:) = results.eff ; %matrix of participant x connection
% end of subjects

%% Generate the group model
model_group.y = spc_subject;

%% Estimate the group-level model
opt_glm_gr.test  = 'ttest' ;
opt_glm_gr.flag_beta = true ; 
opt_glm_gr.flag_residuals = true ;
y_x_c.x = model_group.x;
y_x_c.y = model_group.y;
y_x_c.c = model_group.c; 
[results, opt_glm_gr] = niak_glm(y_x_c , opt_glm_gr);

