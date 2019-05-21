function CalcConnectivityVariability(files_in,files_out),
%This script will take 
%
%files_in
%       .path   string, full path to 
%       .fisher logical, 1 if used, 0 if not.
%       .groups cell of strings, name of groups
%       .run    cell of strings, name of runs
%
%files_out      full path to a .mat file containing the results.
%
%Output is a structure ... describe


%START

fs = filesep;

%%Assign defaults to variables that were not included in files_in
list_fields    = { 'path' , 'fisher', 'groups', 'run'};
list_defaults  = { NaN    , 1,        NaN,      NaN};
files_in = psom_struct_defaults(files_in,list_fields,list_defaults);
%%%%%%


%%%%%%%%%%%%%%%%
%List of files %
%%%%%%%%%%%%%%%%
tdir = dir( files_in.path );

for tt = 3:length(tdir),
    pnames{tt-2} = tdir(tt).name;
end

%Get list of names
for pp = 1:length(pnames),
    temp = strsplit(pnames{pp},'_');
    tpnames{pp} = temp{1};
end
clear pnames;
pnames = unique(tpnames);

%Get list of whom is in which group
GroupMat = zeros(1,length(pnames));
for gg = 1:length(files_in.groups),
    GroupMat(not(cellfun('isempty',strfind(pnames,files_in.groups{gg})))) = gg;
end


%%%%%%%%
% Calculate and write results
%%%%%%%%
for gg = 1:length(files_in.groups),
    tList = pnames(find(GroupMat == gg));
    
    for rr = 1:length(files_in.run),
        
        files_in.run{rr}
        
        load(strcat( files_in.path, tList{1},'_',files_in.run{rr},'.mat' ));
        
        %Create results matrices
        VarResults.(files_in.groups{gg}).(files_in.run{rr}).Avg = zeros( size(CorrMat,1) , sum(GroupMat == gg) );
        VarResults.(files_in.groups{gg}).(files_in.run{rr}).Std = zeros( size(CorrMat,1) , sum(GroupMat == gg) );
        
        for pp = 1:length(tList),
            
            tList(pp)
            
            load(strcat( files_in.path, tList{pp},'_',files_in.run{rr},'.mat' ));
            
            if files_in.fisher,
                CorrMat = niak_fisher(CorrMat);
            end
            
            VarResults.(files_in.groups{gg}).(files_in.run{rr}).Avg(:,pp) = mean(CorrMat,2);
            VarResults.(files_in.groups{gg}).(files_in.run{rr}).Std(:,pp) = std(CorrMat,0,2);

        end        
    end
end
    
VarResults.Mask = mask;
VarResults.WindowSize = WinSiz;
VarResults.Labels_rois = labels_rois;
VarResults.Info = {'Mask: Volume that was used for parcels'; 'WindowSize: Size of Analysis Window in TRs'; 'Avg: Average connectivity throught all windows'; ...
                    'Std: standard deviation of a connection'};
VarResults.Fisher = files_in.fisher;
save( strcat( files_out,'CompiledWindowedResults.mat' ) ,'VarResults');

end