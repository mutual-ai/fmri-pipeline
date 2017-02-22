classdef Log < handle
    %LOG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        file, defCurrent;
        Subject, Trial, EventType, Code, Time, TTime, def, first_pulse, timereal;
    end
    
    methods
        %Construtor
        function obj = Log( logfile )
            obj.treatFile( logfile );
        end
        
        %Abre arquivo e remove os dados para serem tratados
        function treatFile( obj, logfile)
            obj.file = logfile;
            fid = fopen(obj.file);
            ret = textscan(fid,'%s %s %s %s %f %f %*[^\n]','delimiter','\t','headerlines',5);
            fclose(fid);
            obj.Subject = ret{1};
            obj.Trial = ret{2};
            obj.EventType = ret{3};
            obj.Code = ret{4};
            obj.Time = ret{5};
            obj.TTime = ret{6};
            % Uncertainty = ret{7};
            % Duration = ret{8};
            % Uncertainty = ret{9};
        end
        
        function [type_matches, code_matches, onset_matches] = getMatches( obj, def )
            if( ~exist('def', 'var') ); def = obj.defCurrent; end;
            [type_matches, code_matches, onset_matches] = ...
                obj.getMatches2( def.pres_type, def.pres_codes);
        end
        
        function [type_matches, code_matches, onset_matches] = getTerminations( obj, def )
            if( ~exist('def', 'var') ); def = obj.defCurrent; end;
            [type_matches, code_matches, onset_matches] = ...
                obj.getMatches2( def.pres_termination_types, def.pres_termination_codes);
        end
        
        function [type_matches, code_matches, onset_matches] = getMatches2( obj, types, codes )
            if( ~iscell(types) )
                types = {types};
            end
            % find onsets
            type_matches = obj.get_matches( types, obj.EventType );
            
            % find all code matches
            code_matches = obj.get_matches( codes, obj.Code );
            
            % require to match type and one of the codes
            onset_matches = type_matches & code_matches;
        end
    end
    
    methods (Static = true)
        function code_matches = get_matches( codes, Code )
            code_matches = ones(length(Code),1) == 0;
            for c=1:length(codes)
                %    code_matches = [code_matches | strcmp( num2str( codes{c} ), Code )];
                hit = ~cellfun( @isempty, regexp( Code, num2str( codes{c} ) ) );
                code_matches = code_matches | hit;
            end
            
        end
        
        function code_matches = get_matches_separate( codes, Code )
            code_matches = cell(1,length(codes));
            for c=1:length(codes)
                %    code_matches{c} = strcmp( num2str( codes{c} ), Code );
                code_matches{c}  = ~cellfun( @isempty, regexp( Code, num2str( codes{c} ) ) );
            end
            
        end
    end
    
end

