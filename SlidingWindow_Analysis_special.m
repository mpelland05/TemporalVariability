function SlidingWindow_Analysis_special(files_in,files_out),
%This script takes matrixes of Time x Parcels of data (Parcels can be
%voxels or larger netwokrs) and calculates a correlation matrix for
%temporal windows. It then calculates the variability in connectivity for
%each connections and provides the average variability in connection for
%each parcels. 
%
%files_in
%       .path   string, full path to the folder containing the .mat files
%               of Time x Parcels data.
%       .run    Name of different runs that need to be analyzed
%       .WinSiz int, size in time points of the analysis window. If not an
%               odd number, the script will transform it into an odd number
%
%files_out      string, full path to outputfolder

%START!

%%%
% set defaults
%%%
fs = filesep;

%%Assign defaults to variables that were not included in files_in
list_fields    = { 'path',  'run', 'WinSiz'};
list_defaults  = { NaN   ,  NaN  , 21};
files_in = psom_struct_defaults(files_in,list_fields,list_defaults);
%%%%%%

%Make sure WinSiz is an odd number.
nn = files_in.WinSiz;
if nn/2 == round(nn/2),
    files_in.WinSiz = files_in.WinSiz + 1;
    'The size of the analysis window was increased by 1 TR to obtain an odd number'
end


%%%%%%%%%%%%%%%%
%List of files %
%%%%%%%%%%%%%%%%
tdir = dir( files_in.path );

for tt = 3:length(tdir),
    pnames{tt-2} = tdir(tt).name;
end

%Get list of names
pnames = unique(tpnames);


%%%%%%%%
% Compute correlations
%%%%%%%
WinSiz = files_in.WinSiz;

for pp = 1:length(pnames),
    pnames{pp}
        
        load(strcat( files_in.path, pnames{pp} ));
	tseries = ets;
        
        [nTPoint nNet] = size(tseries);
        
        nWin = nTPoint - WinSiz + 1;
        CorrMat = zeros( (nNet*(nNet-1))/2,nWin); 
        
        %Extract corr from window
        for ww = 1:nWin,
            wStart = ww;
            wEnd = ww+WinSiz-1;
            t_tseries = tseries(wStart:wEnd,:);
            
            [t1 CorrMat(:, ww)] = niak_build_srup(t_tseries,1); %Note that the output is vectorized. 
        end
        
        mask = parameters.mask;
        sNam = strcat( pnames{pp} );
        save( strcat( files_out,sNam ) , 'CorrMat', 'WinSiz');
  
end
end
 