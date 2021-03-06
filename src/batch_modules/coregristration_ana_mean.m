
fmri_file = sprintf( '%s%s.nii', run_file_prefix, run_file_suffix );
fmri_file = strrep( fmri_file, '{nr}', '1' );

if preserve_indir
   run1 = config.runs_dir{1};
else
   run1 = 'RUN1';
end

if( ~exist( fullfile(preproc_dir, run1, fmri_file), 'file' ) )
    dirFs = dir( fullfile(preproc_dir, run1, fmri_file) );
    fmri_file = dirFs(1).name;
end
fmri_file = ['mean' fmri_file ',1'];

matlabbatch{1}.spm.spatial.coreg.estimate.ref    = {fullfile( preproc_dir, run1, fmri_file )};
matlabbatch{1}.spm.spatial.coreg.estimate.source = {fullfile( preproc_dir, 'ANAT', anat_file )};
matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
