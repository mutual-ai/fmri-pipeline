function populaMatlabbatch( obj )
%BATCH Summary of this function goes here
%   Detailed explanation goes here

matlabbatch{1} = struct();
matlabbatch{2} = struct();
matlabbatch{3} = struct();

%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev$)
%-----------------------------------------------------------------------
obj.matlabbatch{1}.spm.stats.fmri_spec.dir = { fullfile(obj.outDir, obj.subject.code) }; %Definindo diretorio de saida
matlabbatch{1}.spm.stats.fmri_spec.timing.units = obj.units;
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;

%% Definindo sess�es e condi��es
numCond = obj.numConditions();
for nses=1:obj.numSessions
  %% Alterando definicoes do RUN
  %Inserindo imagens da sess�o
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).scans = ProcessamentoSPM.selectFilesDir(obj.subject.getSesDir(nses), obj.prefixFirstLvlImgs );
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).hpf = obj.filter; %Ajusta o filtro
  %Inserindo condi��es
  
  for ncond=1:numCond
    if isstruct(obj.conditions)
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).name = obj.conditions.sess(nses).cond(ncond).name;
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).onset = obj.conditions.sess(nses).cond(ncond).onset;
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).duration = obj.conditions.sess(nses).cond(ncond).duration;
    else
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).name = obj.conditions{ncond}(1);
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).onset = obj.conditions{ncond}(2);
      matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).duration = obj.conditions{ncond}(3);
    end
    
    %Gerando informa��es para as modula��es param�tricas
    if isstruct(obj.paramModulation)
      condName = matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).name;
      totalOnsets = length(matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).onset);
      try
        params = obj.paramModulation.(obj.subject.code).run(nses).(condName);
        paramsNames = fields( params );
        if( length(params.(paramsNames{1}).vals) == totalOnsets ) %S� insere se a quantidade de onsets for igual
          for nPar = 1:length(paramsNames)
            matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).pmod(nPar).name = paramsNames{nPar};
            matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).pmod(nPar).param = params.(paramsNames{nPar}).vals;
            matlabbatch{1}.spm.stats.fmri_spec.sess(nses).cond(ncond).pmod(nPar).poly = 1;
          end
        end
      catch exception
      end
    end
  end
  
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).multi_reg = {''};
  %Inserindo regressores
  if ~isempty(obj.multipleReg) & ~isempty(obj.multipleReg(nses))
    matlabbatch{1}.spm.stats.fmri_spec.sess(nses).multi_reg = obj.multipleReg(nses);
  elseif ~isempty(obj.regressores) & obj.regressores
    unificado = ~isempty( strfind( obj.prefixFirstLvlImgs, 'ru' ) );
    matlabbatch{1}.spm.stats.fmri_spec.sess(nses).multi_reg = { obj.subject.getRegFile(nses, unificado ) };
  end;
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).regress = obj.subject.getOutrosRegressores( obj.outrosRegressoresPrefix, nses );
  
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).tmod = 0;
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).pmod = struct('name', {}, 'param', {}, 'poly', {});
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).multi = {''};
  matlabbatch{1}.spm.stats.fmri_spec.sess(nses).hpf = obj.filter;
end

%%
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mask = { [which('apriori\brainmask.nii') ',1' ] };
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'fMRI model specification: SPM.mat File';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep;
matlabbatch{3}.spm.stats.con.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.stats.con.spmmat(1).sname = 'Model estimation: SPM.mat File';
matlabbatch{3}.spm.stats.con.spmmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.stats.con.spmmat(1).src_output = substruct('.','spmmat');
%% DEFINICAO DOS CONTRASTES
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'NOME';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1 0 0 1 -1 0 0 1 -1 0 0];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;

obj.matlabbatch = matlabbatch;

end