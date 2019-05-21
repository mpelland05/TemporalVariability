function ExtractTseries4WindowAnalysis(files_in,files_out),
%
%This function will take 4D volumes and extract the time series of each
%voxels for each participants. The resulting times series are saved under 

%files_in
%       .path   string, full path to folder containing the preprocessed 4D
%               volumes
%       .fType  string, opt, extension of the files containing the
%               volumes
%       .groups cell of strings, each cell contains a string that is unique
%               to a group
%       .run    cell of strings, each cell contains a string that is unique
%               to a run
%       .mask   string, full path to volume containing the mask (or
%               parcels, whatever. 
%       .scale  integer, number of networks. Will be used for the naming 
%
%files_out      string, full path to a folder which will contain the
%               results. The folder must be created prior to launching the
%               analysis.

fs = filesep;

%%Assign defaults to variables that were not included in files_in
list_fields    = { 'path' , 'fType' ,   'groups',     'run',    'mask', 'scale'};
list_defaults  = { NaN    , '.mnc.gz',  NaN ,         NaN,       NaN,   100 };
files_in = psom_struct_defaults(files_in,list_fields,list_defaults);
%%%%%%


%Variable containing the parameters/ legend for the saved file.
parameters = files_in;


%%%%%%%%%%%%%%%%
%List of files %
%%%%%%%%%%%%%%%%
tdir = dir( strcat( files_in.path,'fmri',fs ) );

for tt = 3:length(tdir),
    tpnames{tt-2} = tdir(tt).name;
end

%Keep only file_names containing the right type 
ReMat = zeros(1,length(tpnames));
ReMat = cellfun('isempty',strfind(tpnames,files_in.fType));
pnames = tpnames(ReMat ==0);
clear ReMat tpnames;

%Get list of names
for pp = 1:length(pnames),
    temp = strsplit(pnames{pp},'_');
    tpnames{pp} = temp{2};
end
clear pnames;
pnames = unique(tpnames);

%Get list of whom is in which group
GroupMat = zeros(1,length(pnames));
for gg = 1:length(files_in.groups),
    GroupMat(not(cellfun('isempty',strfind(pnames,files_in.groups{gg})))) = gg;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%
% Extract tseries for each voxels.
%%%%%
[hdr_mask,mask] = niak_read_vol(files_in.mask);

    for pp = 1:length(pnames),
        for rr = 1:length(files_in.run),
            
            tnam = strcat('fmri_',pnames{pp},'_',files_in.run{rr},'_run',files_in.fType)
            [hdr_fmri,vol] = niak_read_vol(strcat( files_in.path,'fmri',fs,tnam ));
            
            %opt.flag_all = 'true'; %Use if uninterested in the mask
            [tseries, std_ts, labels_rois] = niak_build_tseries(vol,mask);
            
            sName = strcat(pnames{pp},'_',files_in.run{rr},'.mat');
            save(strcat( files_out, 'Scale_', num2str(files_in.scale), fs, sName ) , 'tseries','std_ts','labels_rois','parameters');
        end
    end

end


%% Read time series into a structure
%% MODEL_RUN.TIME_SERIES : array of time series (column-wise)
%% MODEL_RUN.TIME_FRAMES : time associated with each sample
%% MODEL_RUN.MASK_SUPPRESSED : a boolean mask of the volumes that were suppressed in the original time series
%% MODEL_RUN.CONFOUNDS : a matrix of confounds that were regressed out of time series (column-wise)
%% MODEL_RUN.LABELS_CONFOUNDS : a cell of strings with the labels of the confounds

%    if isfield(hdr_fmri,'extra')
%        model_run.time_frames = hdr_fmri.extra.time_frames;
%        if isfield(hdr_fmri.extra,'confounds')
%            model_run.confounds = hdr_fmri.extra.confounds;
%            model_run.labels_confounds = hdr_fmri.extra.labels_confounds;
%        else
%            model_run.confounds = [];
%            model_run.labels_confounds = {};
%        end
%        if isfield(hdr_fmri.extra,'mask_suppressed')
%            model_run.mask_suppressed = hdr_fmri.extra.mask_suppressed;
%        else
%            model_run.mask_suppressed = false(size(model_run.tseries,1),1);
%        end
%    else
%        model_run.time_frames = (0:(size(model_run.tseries,1)-1))*hdr_fmri.info.tr;
%        model_run.confounds = [];
%        model_run.labels_confounds = {};
%        model_run.mask_suppressed = false(size(model_run.tseries,1),1);
%    end


    
   % niak_build_tseries
    
   % niak_build_srup