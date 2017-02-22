% def structure with following fields:
% pres_type: type name of event
% pres_codes: list of numerical codes that define a condition in SPM
% spm_termination_codes: list of numerical codes that defines the end
% of the condition in SPM, i.e. the duration will be calculated between
% events
% spm_termination_types: list of types
% spm_name: name of condition in SPM
% spm_fix_duration: duration of event (equal for all matched events), if
% left empty, and spm_termination_codes is not defined or empty, duration
% will be set to zero
% spm_pmod: list of values for parametric modulation matching the list of
% pres_codes
function model = get_effort_separado_parametric_CSO_model()

    categories = { 'cueFLA', 'cueSTI' ,'cueSELF', 'cueEFFORTONLYFLA', 'cueEFFORTONLYSTI', 'cueEFFORTONLYSELF', 'cueCUEONLY_FLA', 'cueCUEONLY_STI', 'cueCUEONLY_SELF', 'ClipFla.*', 'ClipAvai.*' };
    spm_names  = { 'CUE TEAM', 'CUE STI' ,'CUE SELF', 'CUE EFFORT TEAM', 'CUE EFFORT STI','CUE EFFORT SELF', 'CUEONLY TEAM', 'CUEONLY STI', 'CUEONLY SELF',  'CLIP TEAM', 'CLIP AVAI' };
    durations = [ 6.5*ones(1,9) ];
    
    for k=1:length( categories )-5

        def(k).pres_type = 'Picture';
        def(k).pres_codes = { categories{k} };
        def(k).pres_termination_codes = [] ; % { 'squeeze.*' };
        def(k).pres_termination_types = { 'Picture' };
        def(k).spm_name = spm_names{k};
        def(k).spm_fix_duration = durations(k);
        def(k).spm_pmod.name = @get_force_of_trial;
        def(k).spm_pmod.str = 'maxforceblock:';
    end
    
    for k=length( categories )-5:length( categories )-2

        def(k).pres_type = 'Picture';
        def(k).pres_codes = { categories{k} };
        def(k).pres_termination_codes = [] ; % { 'squeeze.*' };
        def(k).pres_termination_types = { 'Picture' };
        def(k).spm_name = spm_names{k};
        def(k).spm_fix_duration = durations(k);
        def(k).spm_pmod = '';
       
    end

    for k=length( categories )-1:length( categories )
        def(k).pres_type = 'Video';
        def(k).pres_codes = { categories{k} };
        def(k).pres_termination_codes = { 'fixposclip' };
        def(k).pres_termination_types = { 'Picture' };
        def(k).spm_name = spm_names{k};
        def(k).spm_fix_duration = [];
        def(k).spm_pmod = '';
    end
    
    

    model.name = 'PARAM_EFFORT_SEP_CSO';
    model.def  = def;
    
    ci = 0;
    %% contrastes com baseline implicito
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 1 0 0 0 0 0 0];
    model.contrast(ci).name = 'CS TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 1 0 0 0 0];
    model.contrast(ci).name = 'CS STI';
    
    ci= ci+1;
    model.contrast(ci).vec  = [ 0 0 0 0 1 0 0];
    model.contrast(ci).name = 'CS SELF';
    
    %% contrastes com baseline esforco
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'CS EFFORT TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'CS EFFORT STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'CS EFFORT SELF';
    
    %% contrastes entre condicoes
    ci= ci+1;
    model.contrast(ci).vec  = [ 1 0 -1 0  0];
    model.contrast(ci).name = 'CS TEAM > CS STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ -1 0 1 0 0];
    model.contrast(ci).name = 'CS STI > CS TEAM';
    
    ci= ci+1;
       
    model.contrast(ci).vec  = [ 1 0 0 0 -1];
    model.contrast(ci).name = 'CS TEAM > CS SELF';

    ci= ci+1;
       
    model.contrast(ci).vec  = [ -1 0 0 0 1];
    model.contrast(ci).name = 'CS SELF > CS TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 1 0 -1];
    model.contrast(ci).name = 'CS STI > CS SELF';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 -1 0 1];
    model.contrast(ci).name = 'CS SELF > CS STI';
    
    %% contrastes com baseline esforco
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'CS TEAM > CS EFFORT TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'CS STI > CS EFFORT STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'CS SELF > CS EFFORT SELF';
    
    %% contrastes de interacao com baseline esforco
    ci = ci+1;
    
    model.contrast(ci).vec  = [ 1 0 -1 0 0 0 -1 0 1];
    model.contrast(ci).name = 'INTER CS TEAM > CS STI';

    ci = ci+1;
    
    model.contrast(ci).vec  = [ -1 0 1 0 0 0 1 0 -1];
    model.contrast(ci).name = 'INTER CS STI > CS TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 1 0 0 0 -1 0 -1 0 0 0 1];
    model.contrast(ci).name = 'INTER CS TEAM > CS SELF';

    ci = ci+1;
    model.contrast(ci).vec  = [ -1 0 0 0 1 0 1 0 0 0 -1];
    model.contrast(ci).name = 'INTER CS SELF > CS TEAM';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 1 0 -1 0 0 0 -1 0 1];
    model.contrast(ci).name = 'INTER CS STI > CS SELF';
   
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 -1 0 1 0 0 0 1 0 -1];
    model.contrast(ci).name = 'INTER CS SELF > CS STI';
  


    %% contrastes com baseline sem esforco
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 1 0 0 0 0 0 0 0 0 0 0 0 -1];
    model.contrast(ci).name = 'CS TEAM > CUEONLY TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 1 0 0 0 0 0 0 0 0 0  0 -1];
    model.contrast(ci).name = 'CS STI > CUEONLY STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 1 0 0 0 0 0 0 0  0 0 -1];
    model.contrast(ci).name = 'CS SELF > CUEONLY SELF';
    
    %% contrastes com baseline implicito
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 1 0 0 0 0 0 0];
    model.contrast(ci).name = 'PARAM TEAM ';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 0 1 0 0 0 0];
    model.contrast(ci).name = 'PARAM STI ';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 1 0 0];
    model.contrast(ci).name = 'PARAM SELF';
    
    %% contrastes com baseline esforco
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'PARAM EFFORT TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'PARAM EFFORT STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 0 0 0 0 0 0 1];
    model.contrast(ci).name = 'PARAM EFFORT SELF';
    
    
    %% contrastes entre condicoes
    ci = ci+1;
    model.contrast(ci).vec  = [ 0 1 0 -1 0  0];
    model.contrast(ci).name = 'PARAM TEAM > PARAM STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 -1 0 1 0 0];
    model.contrast(ci).name = 'PARAM STI > PARAM TEAM';
    
    ci= ci+1;
       
    model.contrast(ci).vec  = [ 0 1 0 0 0 -1];
    model.contrast(ci).name = 'PARAM TEAM > PARAM SELF';

    ci= ci+1;
       
    model.contrast(ci).vec  = [ 0 -1 0 0 0 1];
    model.contrast(ci).name = 'PARAM SELF > PARAM TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 0 1 0 -1];
    model.contrast(ci).name = 'PARAM STI > PARAM SELF';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 -1 0 1];
    model.contrast(ci).name = 'PARAM SELF > PARAM STI';
    
    %% contrastes com baseline esforco
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'PARAM TEAM > PARAM EFFORT TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 0 0 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'PARAM STI > PARAM EFFORT STI';
    
    ci = ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 0 0 1 0 0 0 0 0 -1];
    model.contrast(ci).name = 'PARAM SELF > PARAM EFFORT SELF';
    
    %% contrastes de interacao com baseline esforco
    ci = ci+1;
    
    model.contrast(ci).vec  = [ 0 1 0 -1 0 0 0 -1 0 1];
    model.contrast(ci).name = 'INTER PARAM TEAM > PARAM STI';

    ci = ci+1;
    
    model.contrast(ci).vec  = [ 0 -1 0 1 0 0 0 1 0 -1];
    model.contrast(ci).name = 'INTER PARAM STI > PARAM TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 1 0 0 0 -1 0 -1 0 0 0 1];
    model.contrast(ci).name = 'INTER PARAM TEAM > PARAM SELF';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 -1 0 0 0 1 0 1 0 0 0 -1];
    model.contrast(ci).name = 'INTER PARAM SELF > PARAM TEAM';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 1 0 -1 0 0 0 -1 0 1];
    model.contrast(ci).name = 'INTER PARAM STI > PARAM SELF';
   
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 0 -1 0 1 0 0 0 1 0 -1];
    model.contrast(ci).name = 'INTER PARAM SELF > PARAM STI';
   
    
    %% videos
    ci = ci+1;
    model.contrast(ci).vec  = [ zeros(1,15) 1 0 ];
    model.contrast(ci).name = 'VIDEO TEAM';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,15) 0 1];
    model.contrast(ci).name = 'VIDEO AVAI';

    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,15) 1 -1];
    model.contrast(ci).name = 'VIDEO TEAM > AVAI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,15) -1 1];
    model.contrast(ci).name = 'VIDEO AVAI > TEAM';

    model.regressor_function_handle = '';

end