function CalcConnectivityFFT(files_in,files_out),
%This script will take 
%
%files_in
%       .path   string, full path to 
%       .groups cell of strings, name of groups
%       .fisher int, 0 if fisher is not used, 1 if it is. 
%       .run    cell of strings, name of runs
%
%files_out      full path to a .mat file containing the results.
%
%Output is a structure ... describe


%START

fs = filesep;

%%Assign defaults to variables that were not included in files_in
list_fields    = { 'path' ,  'groups', 'fisher', 'run'};
list_defaults  = { NaN    ,   NaN    ,  1     ,   NaN};
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
        fftResults.(files_in.groups{gg}).(files_in.run{rr}).Raw = zeros( [size(CorrMat) sum(GroupMat == gg)] );
        fftResults.(files_in.groups{gg}).(files_in.run{rr}).Avg = zeros( size(CorrMat) );
        
        for pp = 1:length(tList),
            
            tList(pp)
            
            load(strcat( files_in.path, tList{pp},'_',files_in.run{rr},'.mat' ));
            
            if files_in.fisher,
                CorrMat = niak_fisher(CorrMat);
            end
            
            fftResults.(files_in.groups{gg}).(files_in.run{rr}).Raw(:,:,pp) = fft(CorrMat,[],2);


        end   
        fftResults.(files_in.groups{gg}).(files_in.run{rr}).Raw(:,:,pp) = mean(real(fftResults.(files_in.groups{gg}).(files_in.run{rr}).Raw(:,:,pp)) ,3);
    end
end
    
fftResults.Mask = mask;
fftResults.WindowSize = WinSiz;
fftResults.Labels_rois = labels_rois;
fftResults.Info = {'Mask: Volume that was used for parcels'; 'WindowSize: Size of Analysis Window in TRs'; 'Avg: Average connectivity throught all windows'; ...
                    'Std: standard deviation of a connection'};
fftResults.Fisher = files_in.fisher;
save( strcat( files_out,'CompiledFFT.mat' ) ,'fftResults');

end