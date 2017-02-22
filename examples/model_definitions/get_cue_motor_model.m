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
function model = get_cue_motor_model()

    categories = { 'cueFLA|cueCUEONLY_FLA', 'cueSTI|cueCUEONLY_STI' ,'cueSELF|cueCUEONLY_SELF', 'cueEFFORTONLY' 'ClipFla.*', 'ClipAvai.*'  };
    spm_names  = { 'CUE TEAM', 'CUE STI' ,'CUE SELF' , 'CUE EFFORT',  'CLIP TEAM', 'CLIP AVAI' };

    for k=1:length( categories )

        def(k).pres_type = 'Picture';
        def(k).pres_codes = { categories{k} };
        def(k).pres_termination_codes = [] ; % { 'squeeze.*' };
        def(k).pres_termination_types = { 'Picture' };
        def(k).spm_name = spm_names{k};
        def(k).spm_fix_duration = 1.5;
        def(k).spm_pmod = '';
    end

     for k=length(categories)-1:length(categories)
        def(k).pres_type = 'Video';
        def(k).pres_codes = { categories{k} };
        def(k).pres_termination_codes = { 'fixposclip' };
        def(k).pres_termination_types = { 'Picture' };
        def(k).spm_name = spm_names{k};
        def(k).spm_fix_duration = [];
        def(k).spm_pmod = '';
    end
    
    
    model.name = 'CUE_MOTOR';
    model.def  = def;
    
    ci = 1;
    model.contrast(ci).vec  = [ 1 0 0];
    model.contrast(ci).name = 'CUE TEAM';
    
    ci= ci+1;
    model.contrast(ci).vec  = [ 0 1 0];
    model.contrast(ci).name = 'CUE STI';
    
    ci= ci+1;
    model.contrast(ci).vec  = [ 0 0 1];
    model.contrast(ci).name = 'CUE SELF';
    
    ci= ci+1;
    model.contrast(ci).vec  = [ 0 0 0 1];
    model.contrast(ci).name = 'CUE EFFORT ONLY';
    
    ci= ci+1;
    model.contrast(ci).vec  = [ 1 -1 0];
    model.contrast(ci).name = 'CUE TEAM > CUE STI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ -1 1 0];
    model.contrast(ci).name = 'CUE STI > CUE TEAM';
    
    ci= ci+1;
       
    model.contrast(ci).vec  = [ 1 0 -1];
    model.contrast(ci).name = 'CUE TEAM > CUE SELF';

    ci= ci+1;
       
    model.contrast(ci).vec  = [ -1 0 1];
    model.contrast(ci).name = 'CUE SELF > CUE TEAM';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 1 -1];
    model.contrast(ci).name = 'CUE STI > CUE SELF';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 -1 1];
    model.contrast(ci).name = 'CUE SELF > CUE STI';
    
    %% contrastes com baseline
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 1 0 0 -1];
    model.contrast(ci).name = 'CUE TEAM > CUE EFFORT';

    ci = ci+1;
    model.contrast(ci).vec  = [ 0 1 0 -1];
    model.contrast(ci).name = 'CUE STI > CUE EFFORT';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ 0 0 1 -1];
    model.contrast(ci).name = 'CUE SELF > CUE EFFORT';
    
     %% videos
    ci = ci+1;
    model.contrast(ci).vec  = [ zeros(1,length(categories)-2) 1 0 ];
    model.contrast(ci).name = 'VIDEO TEAM';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,length(categories)-2) 0 1];
    model.contrast(ci).name = 'VIDEO AVAI';
    
    ci = ci+1;
    model.contrast(ci).vec  = [ zeros(1,length(categories)-2) 1 -1 ];
    model.contrast(ci).name = 'VIDEO TEAM > VIDEO AVAI';
    
    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,length(categories)-2) -1 1];
    model.contrast(ci).name = 'VIDEO AVAI > VIDEO TEAM';

    ci= ci+1;
    
    model.contrast(ci).vec  = [ zeros(1,length(categories)) 1];
    model.contrast(ci).name = 'MOTOR';

    model.regressor_function_handle = @get_motor_data;

end