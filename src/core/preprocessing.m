function preprocessing( config )
import utils.Var;

preproc_name = config.preproc_name;
dir_base = config.dir_base;       
raw_base = config.raw_base;        
preproc_base = config.preproc_base;    
nrun = config.nrun;
nvol = config.nvol;
ncorte = config.ncorte;
TR = config.TR; 
TA = config.TA;
if( isfield(config, 'sliceorder') )
    sliceorder = config.sliceorder;
else
    sliceorder = [1:ncorte];
end
smooth = config.smooth; 
export_from_raw_data = config.export_from_raw_data; 
runs_prefix = config.runs_prefix; 
run_file_prefix = config.run_file_prefix;
run_file_suffix = config.run_file_suffix; 
anat_prefix = config.anat_prefix; 
anat_file = config.anat_file; 
subjs = config.subjs;
subj_prefix = config.subj_prefix;
preserve_indir = ~isempty( Var.get(config, 'runs_dir', [])) && (length(config.runs_dir) == length(config.runs_prefix));
fieldmap_prefix = Var.get(config, 'fieldmap_prefix', []);

% Steps
fieldmap = Var.get(config, 'fieldmap', 0);
realign = ~isfield(config, 'realign') || config.realign;
slice_timing = ~isfield(config, 'slice_timing') || config.slice_timing;
norm_anat = ~isfield(config, 'norm_anat') || config.norm_anat;
norm_EPI = ~isfield(config, 'norm_EPI') || config.norm_EPI;
smoothing = ~isfield(config, 'smoothing') || config.smoothing;

if ~isfield(config, 'start_prefix')
    config.start_prefix = '';
end
start_prefix = Var.get(config, 'start_prefix', '');

spm_dir = fileparts( which( 'spm' ) );

%% start of pipeline
if ~isdir( preproc_base ), mkdir( preproc_base ); end

for i = 1:length(subjs)
    files = {};
    name_subj{i} = get_subjid(config, subjs(i));
    
    disp (['Preprocessing for subject: ', name_subj{i} ]);
    
    %%%%%%%%%%%%%Prepare Directory structure%%%%%%%%%
    % create subject directory for preprocessing data
    sdirs = dir( fullfile( raw_base, [get_subjid(config, subjs(i), false) '*']) );
    
    % treat first and second visit
    for vis = 1:length(sdirs)
        current_prefix = start_prefix;
        preproc_dir = fullfile( preproc_base, name_subj{i} ) ;
        
        if vis == 3
           error( 'found %s directories for subject %i', [sdirs.name]', i );
        end
        
        if vis == 2 && ( str2num( sdirs(2).name(9:end) ) > sdirs(1).name(9:end) )
            preproc_dir = [preproc_dir '_2' ];
        end
        
        if ~isdir( preproc_dir ),
            mkdir( preproc_dir );
        else
            disp( sprintf('preproc directory %s already exists', preproc_dir ) );
        end
    
        
        if export_from_raw_data
            raw_dir = fullfile( raw_base, sdirs(vis).name );
        
            for r=1:nrun

                raw_dir_run = dir( fullfile( raw_dir, runs_prefix{r} ) );
                if length(raw_dir_run) ~= 1 
                    error( 'run not found or several matches found. Please clean up directory %s\n', fullfile( raw_dir, runs_prefix{r} )  );
                end
                
                infile = fullfile( raw_dir, raw_dir_run(1).name, sprintf( '%s%s.nii.gz', run_file_prefix, run_file_suffix ) );
                infile = strrep(infile, '{rn}', num2str(r) );
                if( ~exist(infile, 'file') )
                    dirfs = dir( infile );
                    infile = fullfile( raw_dir, raw_dir_run(1).name, dirfs(1).name );
                end
                if preserve_indir
                    outdir = fullfile( preproc_dir, config.runs_dir{r} );
                else
                    outdir = fullfile( preproc_dir, sprintf( 'RUN%i', r) );
                end
                gunzip( infile , outdir );
            end
            
            if norm_anat
                raw_dir_run = dir( fullfile( raw_dir, anat_prefix ) );
                if length(raw_dir_run) ~= 1
                    error( 'anatomical directory not found or several matches found. Please clean up directory %s\n', fullfile( raw_dir, anat_prefix )  );
                end
                infile = fullfile( raw_dir, raw_dir_run(1).name, anat_file );
                outdir = fullfile( preproc_dir, sprintf( 'ANAT') );
                if( exist(infile, 'file') )
                    mkdir( outdir );
                    copyfile( infile, outdir );
                else
                    gunzip( [infile '.gz'] , outdir );
                end
            end
            
            if fieldmap
                
                fieldmap_dir = dir( fullfile( raw_dir, fieldmap_prefix ) );
                fms = sort({fieldmap_dir.name});
                if length(fms) ~= 2 
                    error('two files for fieldmap expected')
                end
                fmfile = dir( fullfile( raw_dir, fms{1},  '*.nii.gz' ) ); 
                if length(fmfile) ~= 1 
                     error('one file per fieldmap directory expected')
                end
                fmnames = { 'MAG.nii.gz', 'PHASE.nii.gz' };
                for k=1:2
                    infile = fullfile( raw_dir, fms{k}, fmfile(1).name);
                    outdir = fullfile( preproc_dir, sprintf( 'FIELDMAP') );
                    outfile = fullfile(outdir, fmnames{k});
                    fmapfiles{k} = outfile(1:end-3);
                    if exist(infile, 'file') 
                        mkdir(outdir)
                        copyfile(infile, outfile);
                        system(['gunzip ' outfile]);
                    end
                end
                
            end
            
        end
        
        cd( preproc_dir )
        
        %%%%%%%Fieldmap%%%%%%%%%%%%
        if fieldmap
            fmap.phase       = fmapfiles{2};
            fmap.mag         = fmapfiles{1};
            fmap.TEs         = config.fieldmapTEs;
            fmap.readoutTime = config.fieldmapReadoutTime;
            fmap.anat        = fullfile( preproc_dir, 'ANAT', anat_file );
            clear matlabbatch;
            calculate_VDM
            files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_UNWARP.mat');
            files(end).matlabbatch = matlabbatch;
            files(end).message = sprintf( 'Unwarping for subject: %s\n%s\n', name_subj{i}, preproc_dir);
            
        end
        
        %%%%%%%Realignment%%%%%%%%%%%%
        if realign
            clear matlabbatch;
            realignment;
            files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_REALIGN.mat');
            files(end).matlabbatch = matlabbatch;
            files(end).message = sprintf( 'Realignment for subject: %s\n%s\n', name_subj{i}, preproc_dir);

            normpdf = utils.correctFilename( sprintf('mov_%s.pdf', name_subj{i} ) );
            files(end).execs = {'utils.ps2pdf_alt( ''psfile'', [''spm_'' datestr(now, ''yyyymmmdd'') ''.ps''], ''pdffile'', ''' normpdf ''');'};
            current_prefix = ['r' current_prefix];
        end
        
        %%%%%%Slicetiming%%%%%%%%%%%%
        if slice_timing
            clear matlabbatch;
            slicetiming;
            files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_SLICETIME.mat');
            files(end).matlabbatch = matlabbatch;
            files(end).message = sprintf( 'Slicetiming for subject: %s\n%s\n', name_subj{i}, preproc_dir);
            current_prefix = ['a' current_prefix];
        end
        
        %%%%%%% Normalization %%%%%%%
        if norm_anat
            if strcmp(spm('Ver'), 'SPM8')
                preproc_norm_anat_spm8
                current_prefix = ['w' current_prefix];
            else
                clear matlabbatch
                preproc_norm_anat;
                
                %% Setting execution script
                files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_NORM_ANAT.mat');
                files(end).matlabbatch = matlabbatch;
                files(end).message = sprintf( 'Normalization structural images for subject: %s\n%s\n', name_subj{i}, preproc_dir );
                
                normpdf = utils.correctFilename( sprintf('norm_%s.pdf', name_subj{i} ) );
                files(end).execs = {'utils.ps2pdf_alt( ''psfile'', [''spm_'' datestr(now, ''yyyymmmdd'') ''.ps''], ''pdffile'', ''' normpdf ''');'};
                current_prefix = ['w' current_prefix];
            end
        elseif norm_EPI
            %%%%%%% Normalization %%%%%%%%%%%%
            clear matlabbatch;
            normalize_affine
            files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_NORM_AFFINE.mat');
            files(end).matlabbatch = matlabbatch;
            files(end).message = sprintf( 'Normalization structural images for subject: %s\n%s\n', name_subj{i}, preproc_dir );
            
            normpdf = utils.correctFilename( sprintf('norm_%s.pdf', name_subj{i} ) );
            files(end).execs = {'utils.ps2pdf_alt( ''psfile'', [''spm_'' datestr(now, ''yyyymmmdd'') ''.ps''], ''pdffile'', ''' normpdf ''');'};
            current_prefix = ['w' current_prefix];
        end
       
        
        %%%%%%% Smoothing functional images  %%%%%%%%%%%%
        if smoothing
            clear matlabbatch;
            smooth_batch;
            files(end+1).name = fullfile( preproc_dir, 'BATCH_%d_SMOOTH.mat');
            files(end).matlabbatch = matlabbatch;
            files(end).message = sprintf( 'Smoothing functional images for subject: %s\n%s\n', name_subj{i}, preproc_dir);
            current_prefix = ['s' current_prefix];
        end
        
        if ~config.only_batch_files
            execSpmFiles( files )
        end;
        
    end; % visit
end;

cd ..

try
    ps2pdf( 'psfile', ['spm_' datestr(now, 'yyyymmmdd') '.ps'], 'pdffile', ['all_' datestr(now, 'yyyymmmdd') '.pdf'] );
catch
    warning( 'could not find ps file' )
end
end


