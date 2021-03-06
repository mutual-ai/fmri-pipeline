preproc_name = config.preproc_name 
dir_base = config.dir_base       
raw_base = config.raw_base        
preproc_base = config.preproc_base    
nrun = config.nrun
nvol = config.nvol
ncorte = config.ncorte
TR = config.TR 
TA = config.TA 
smooth = config.smooth 
export_from_raw_data = config.export_from_raw_data 
runs_prefix = config.runs_prefix 
run_file_prefix = config.run_file_prefix 
run_file_suffix = config.run_file_suffix 
anat_prefix = config.anat_prefix 
anat_file = config.anat_file 
subjs = config.subjs
subj_prefix = config.subj_prefix;


%% start of pipeline
if ~isdir( preproc_base ), mkdir( preproc_base ); end


for i=subjs
    
    name_subj{i} = sprintf( '%s%03i', subj_prefix, i );
    disp (['Preprocessing for subject: ', name_subj{i} ]);
    
    %%%%%%%%%%%%%Prepare Directory structure%%%%%%%%%
    % create subject directory for preprocessing data
    sdirs = dir( fullfile( raw_base, [name_subj{i} '*']) );
    
    % treat first and second visit
    for vis = 1:length(sdirs)
        
        if vis == 3
           error( 'found %s directories for subject %i', [sdirs.name]', i );
        end
        
        if vis == 2
            if str2num( sdirs(2).name(9:end) ) > sdirs(1).name(9:end)
                preproc_dir = fullfile( preproc_base, [name_subj{i} '_2' ]) ;
            else
                preproc_dir = fullfile( preproc_base, [name_subj{i}]) ;
            end
        else
            preproc_dir = fullfile( preproc_base, [name_subj{i} ]) ;
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

                infile = fullfile( raw_dir, raw_dir_run(1).name, sprintf( '%s%i%s.nii.gz', run_file_prefix, r, run_file_suffix ) );
                outdir = fullfile( preproc_dir, sprintf( 'RUN%i', r) ); 
                gunzip( infile , outdir );
            end
            
            raw_dir_run = dir( fullfile( raw_dir, anat_prefix ) );
            if length(raw_dir_run) ~= 1
                error( 'anatomical directory not found or several matches found. Please clean up directory %s\n', fullfile( raw_dir, anat_prefix )  );
            end
            
            infile = fullfile( raw_dir, raw_dir_run(1).name, sprintf( '%s.gz', anat_file) );
            outdir = fullfile( preproc_dir, sprintf( 'ANAT') );
            gunzip( infile , outdir );
            
            
        end
        
        cd( preproc_dir )
        %%%%%%%Realignment%%%%%%%%%%%%
        
        clear matlabbatch;
        realignment;
        save( fullfile( preproc_dir, 'BATCH_1_REALIGN.mat'), 'matlabbatch' );
        disp (sprintf( 'Realignment for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        ps2pdf( 'psfile', ['spm_' datestr(now, 'yyyymmmdd') '.ps'], 'pdffile', sprintf('mov_%s.pdf', name_subj{i} ) );
        
        %%%%%%Slicetiming%%%%%%%%%%%%
        
        clear matlabbatch;
        slicetiming;
        save( fullfile( preproc_dir, 'BATCH_2_SLICETIME.mat'), 'matlabbatch' );
        disp (sprintf( 'Slicetiming for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        %%%%%%%Coregristration anatomy to mean, estimate only %%%%%%%%%%%%
        
        clear matlabbatch;
        coregristration_ana_mean
        save( fullfile( preproc_dir, 'BATCH_3_COREG_ANA_MEAN.mat'), 'matlabbatch' );
        disp (sprintf( 'Coregristration anatomy to mean for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        %%%%%%%Coregristration mean and all images to T1 (in order to move images to the MNI space)%%%%%%%%%%%%
        
        clear matlabbatch;
        coregistration_T1
        save( fullfile( preproc_dir, 'BATCH_4_COREG_T1.mat'), 'matlabbatch' );
        disp (sprintf( 'Coregristration all images to T1 (MNI space) for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        ps2pdf( 'psfile', ['spm_' datestr(now, 'yyyymmmdd') '.ps'], 'pdffile', sprintf('cor_%s.pdf', name_subj{i} ) );

        %%%%%%% Segmentation anatomy %%%%%%%%%%%%
        
        clear matlabbatch;
        segmentation
        save( fullfile( preproc_dir, 'BATCH_5_SEGMENTATION.mat'), 'matlabbatch' );
        disp (sprintf( 'Segmentation anatomy for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        %%%%%%% Normalization functional images (using parameters from segmentation) %%%%%%%%%%%%
        
        clear matlabbatch;
        normalize_functional
        save( fullfile( preproc_dir, 'BATCH_6_NORM_FUNCT.mat'), 'matlabbatch' );
        disp (sprintf( 'Normalization functional images for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        %%%%%%% Normalization anatomy (using parameters from segmentation) %%%%%%%%%%%%
        clear matlabbatch;
        normalize_structural
        save( fullfile( preproc_dir, 'BATCH_7_NORM_STRUCT.mat'), 'matlabbatch' );
        disp (sprintf( 'Normalization structural images for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
        %%%%%%% Smoothing functional images  %%%%%%%%%%%%
        clear matlabbatch;
        smooth_batch;
        save( fullfile( preproc_dir, 'BATCH_8_SMOOTH.mat'), 'matlabbatch' );
        disp (sprintf( 'Smoothing functional images for subject: %s\n%s\n', name_subj{i}, preproc_dir) );
        spm_jobman('run',matlabbatch);
        
    end; % visit
end;

cd ..

try
    ps2pdf( 'psfile', ['spm_' datestr(now, 'yyyymmmdd') '.ps'], 'pdffile', ['all_' datestr(now, 'yyyymmmdd') '.pdf'] );
catch
    warning( 'could not find ps file' )
end


