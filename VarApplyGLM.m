%% Files in
list_fields   = { 'fmri' , 'model'  , 'mask' , 'atoms'           };
list_defaults = {  NaN   , struct() ,  NaN   , 'gb_niak_omitted' };
files_in = psom_struct_defaults(files_in,list_fields,list_defaults);

list_fields   = { 'group'             , 'individual' };
list_defaults = { 'gb_niak_omitted'   , struct       };
files_in.model = psom_struct_defaults(files_in.model,list_fields,list_defaults);

list_fields   = { 'results'         , 'ttest'           , 'effect'          , 'std_effect'      , 'fdr'             , 'perc_discovery'  };
list_defaults = { 'gb_niak_omitted' , 'gb_niak_omitted' , 'gb_niak_omitted' , 'gb_niak_omitted' , 'gb_niak_omitted' , 'gb_niak_omitted' };
files_out = psom_struct_defaults(files_out,list_fields,list_defaults);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


























[model_group.x,model_group.labels_x,model_group.labels_y] = niak_read_csv(files_in.model.group); %Load model    
opt.test.(label).group.labels_x = fieldnames(files_in.fmri) ;                                    %Prepare the name of people for the test?

model_group = niak_normalize_model(model_group, opt.test.(label).group);






















%in niak glm N is for atom or voxels or parcels


%% Estimate the group-level model
if opt.flag_verbose
   fprintf('Estimate model...\n')
end
opt_glm_gr.test  = 'ttest' ;
opt_glm_gr.flag_beta = true ; 
opt_glm_gr.flag_residuals = true ;
y_x_c.x = model_group.x;
y_x_c.y = model_group.y;
y_x_c.c = model_group.c; 
[results, opt_glm_gr] = niak_glm(y_x_c , opt_glm_gr);

%% Reformat the results of the group-level model
beta =  results.beta; 
e  = results.e ;
std_e = results.std_e ;
ttest = results.ttest ;
pce = results.pce ; 
eff =  results.eff ;
std_eff =  results.std_eff ; 
switch type_measure
    case 'correlation'
        ttest_mat = niak_vec2mat (ttest);
        eff_mat   = niak_vec2mat (eff);
        std_mat   = niak_vec2mat (std_eff);
    case 'glm'
        ttest_mat = reshape (ttest,[sqrt(length(ttest)),sqrt(length(ttest))]);
        eff_mat   = reshape (eff,[sqrt(length(eff)),sqrt(length(eff))]);
        std_mat   = reshape (std_eff,[sqrt(length(std_eff)),sqrt(length(std_eff))]);
    otherwise
        error('%s is an unkown type of intra-run measure',opt.test.(label).run.type)
end

%% Run the FDR estimation
q = opt.fdr;
[fdr,test_q] = niak_glm_fdr(pce,opt.type_fdr,q,opt.test.(label).run.type);
nb_discovery = sum(test_q,1);
perc_discovery = nb_discovery/size(fdr,1);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Build volumes
if ~strcmp(files_out.perc_discovery,'gb_niak_omitted')||~strcmp(files_out.fdr,'gb_niak_omitted')||~strcmp(files_out.effect,'gb_niak_omitted')||~strcmp(files_out.std_effect,'gb_niak_omitted')
    if opt.flag_verbose
       fprintf('Generating volumes ...\n')
    end    
    nb_net = size(ttest_mat,1);
    mask(mask>nb_net) = 0;
    t_maps   = zeros([size(mask) nb_net]);
    fdr_maps = zeros([size(mask) nb_net]);
    eff_maps = zeros([size(mask) nb_net]);
    std_maps = zeros([size(mask) nb_net]);
    for num_net = 1:nb_net
        t_maps(:,:,:,num_net)   = niak_part2vol(ttest_mat(:,num_net),mask);    
        eff_maps(:,:,:,num_net) = niak_part2vol(eff_mat(:,num_net),mask);
        std_maps(:,:,:,num_net) = niak_part2vol(std_mat(:,num_net),mask);
        ttest_thre = ttest_mat(:,num_net);
        ttest_thre( ~test_q(:,num_net) ) = 0;
        fdr_maps(:,:,:,num_net) = niak_part2vol(ttest_thre,mask);
    end
    discovery_maps = niak_part2vol(perc_discovery,mask);
end

% t-test maps
if ~strcmp(files_out.ttest,'gb_niak_omitted')
    hdr.file_name = files_out.ttest;
    niak_write_vol(hdr,t_maps);
end

% perc_discovery
if ~strcmp(files_out.perc_discovery,'gb_niak_omitted')
    hdr.file_name = files_out.perc_discovery;
    niak_write_vol(hdr,discovery_maps);
end

% FDR-thresholded t-test maps
if ~strcmp(files_out.fdr,'gb_niak_omitted')
    hdr.file_name = files_out.fdr;
    niak_write_vol(hdr,fdr_maps);
end

% effect maps
if ~strcmp(files_out.effect,'gb_niak_omitted')
    hdr.file_name = files_out.effect;
    niak_write_vol(hdr,eff_maps);
end

% std maps
if ~strcmp(files_out.std_effect,'gb_niak_omitted')
    hdr.file_name = files_out.std_effect;
    niak_write_vol(hdr,std_maps);
end

%% Save results in mat form
if ~strcmp(files_out.results,'gb_niak_omitted')
    save(files_out.results,'all_run','all_inter','type_measure','test_white','model_white','model_group','beta','eff','std_eff','ttest','pce','fdr','test_q','q','perc_discovery','nb_discovery')
end
