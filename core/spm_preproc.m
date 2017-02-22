%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev$)
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.realign.estwrite.data = {
                                                    '<UNDEFINED>'
                                                    '<UNDEFINED>'
                                                    '<UNDEFINED>'
                                                    '<UNDEFINED>'
                                                    }';
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = {''};
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep;
matlabbatch{2}.spm.temporal.st.scans{1}(1).tname = 'Session';
matlabbatch{2}.spm.temporal.st.scans{1}(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.temporal.st.scans{1}(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.temporal.st.scans{1}(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.temporal.st.scans{1}(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.temporal.st.scans{1}(1).sname = 'Realign: Estimate & Reslice: Resliced Images (Sess 1)';
matlabbatch{2}.spm.temporal.st.scans{1}(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.temporal.st.scans{1}(1).src_output = substruct('.','sess', '()',{1}, '.','rfiles');
matlabbatch{2}.spm.temporal.st.scans{2}(1) = cfg_dep;
matlabbatch{2}.spm.temporal.st.scans{2}(1).tname = 'Session';
matlabbatch{2}.spm.temporal.st.scans{2}(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.temporal.st.scans{2}(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.temporal.st.scans{2}(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.temporal.st.scans{2}(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.temporal.st.scans{2}(1).sname = 'Realign: Estimate & Reslice: Resliced Images (Sess 2)';
matlabbatch{2}.spm.temporal.st.scans{2}(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.temporal.st.scans{2}(1).src_output = substruct('.','sess', '()',{2}, '.','rfiles');
matlabbatch{2}.spm.temporal.st.scans{3}(1) = cfg_dep;
matlabbatch{2}.spm.temporal.st.scans{3}(1).tname = 'Session';
matlabbatch{2}.spm.temporal.st.scans{3}(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.temporal.st.scans{3}(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.temporal.st.scans{3}(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.temporal.st.scans{3}(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.temporal.st.scans{3}(1).sname = 'Realign: Estimate & Reslice: Resliced Images (Sess 3)';
matlabbatch{2}.spm.temporal.st.scans{3}(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.temporal.st.scans{3}(1).src_output = substruct('.','sess', '()',{3}, '.','rfiles');
matlabbatch{2}.spm.temporal.st.scans{4}(1) = cfg_dep;
matlabbatch{2}.spm.temporal.st.scans{4}(1).tname = 'Session';
matlabbatch{2}.spm.temporal.st.scans{4}(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.temporal.st.scans{4}(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.temporal.st.scans{4}(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.temporal.st.scans{4}(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.temporal.st.scans{4}(1).sname = 'Realign: Estimate & Reslice: Resliced Images (Sess 4)';
matlabbatch{2}.spm.temporal.st.scans{4}(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.temporal.st.scans{4}(1).src_output = substruct('.','sess', '()',{4}, '.','rfiles');
matlabbatch{2}.spm.temporal.st.nslices = 22;
matlabbatch{2}.spm.temporal.st.tr = 2;
matlabbatch{2}.spm.temporal.st.ta = 1.90909090909091;
matlabbatch{2}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
matlabbatch{2}.spm.temporal.st.refslice = 11;
matlabbatch{2}.spm.temporal.st.prefix = 'a';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).tname = 'Source Image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).sname = 'Realign: Estimate & Reslice: Mean Image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.source(1).src_output = substruct('.','rmean');
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.wtsrc = '';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).tname = 'Images to Write';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).sname = 'Realign: Estimate & Reslice: Mean Image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(1).src_output = substruct('.','rmean');
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).tname = 'Images to Write';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).sname = 'Slice Timing: Slice Timing Corr. Images (Sess 1)';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(2).src_output = substruct('()',{1}, '.','files');
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).tname = 'Images to Write';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).sname = 'Slice Timing: Slice Timing Corr. Images (Sess 2)';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(3).src_output = substruct('()',{2}, '.','files');
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).tname = 'Images to Write';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).sname = 'Slice Timing: Slice Timing Corr. Images (Sess 3)';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(4).src_output = substruct('()',{3}, '.','files');
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5) = cfg_dep;
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).tname = 'Images to Write';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).sname = 'Slice Timing: Slice Timing Corr. Images (Sess 4)';
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.normalise.estwrite.subj.resample(5).src_output = substruct('()',{4}, '.','files');
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.template = {'C:\Program Files\MATLAB\R2009b\spm8\templates\EPI.nii,1'};
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.weight = {'C:\Program Files\MATLAB\R2009b\spm8\apriori\brainmask.nii,1'};
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.smosrc = 8;
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.smoref = 0;
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.regtype = 'mni';
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.cutoff = 25;
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.nits = 16;
matlabbatch{3}.spm.spatial.normalise.estwrite.eoptions.reg = 1;
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.preserve = 0;
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.bb = [-78 -112 -50
                                                             78 76 85];
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.vox = [3.75 3.75 5];
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.interp = 4;
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.wrap = [0 0 0];
matlabbatch{3}.spm.spatial.normalise.estwrite.roptions.prefix = 'w';
matlabbatch{4}.spm.spatial.smooth.data(1) = cfg_dep;
matlabbatch{4}.spm.spatial.smooth.data(1).tname = 'Images to Smooth';
matlabbatch{4}.spm.spatial.smooth.data(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{4}.spm.spatial.smooth.data(1).tgt_spec{1}(1).value = 'image';
matlabbatch{4}.spm.spatial.smooth.data(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.spm.spatial.smooth.data(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.spm.spatial.smooth.data(1).sname = 'Normalise: Estimate & Write: Normalised Images (Subj 1)';
matlabbatch{4}.spm.spatial.smooth.data(1).src_exbranch = substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{4}.spm.spatial.smooth.data(1).src_output = substruct('()',{1}, '.','files');
matlabbatch{4}.spm.spatial.smooth.fwhm = [7.5 7.5 10];
matlabbatch{4}.spm.spatial.smooth.dtype = 0;
matlabbatch{4}.spm.spatial.smooth.im = 0;
matlabbatch{4}.spm.spatial.smooth.prefix = 's';