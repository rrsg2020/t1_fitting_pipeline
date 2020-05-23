
classdef filter_map < AbstractModel & FilterClass
    % filter_map:   Applies spatial filtering (2D or 3D)
    %
    % Assumptions: If a 3D volume is provided and 2D filtering is requested, each slice will be processsed independently
    %
    % Inputs:
    %   Raw                Input data to be filtered
    %   (Mask)             Binary mask to exclude voxels from smoothing
    %
    % Outputs:
    %	Filtered           Filtered output map (see FilterClass.m for more info)
    %
    % Protocol:
    %	NONE
    %
    % Options:
    %   (inherited from FilterClass)
    %
    % Example of command line usage:
    %
    %   For more examples: <a href="matlab: qMRusage(filter_map);">qMRusage(filter_map)</a>
    %
    % Author: Ilana Leppert Dec 2018
    %
    % References:
    %   Please cite the following if you use this module:
    %     Cabana J-F, Gu Y, Boudreau M, Levesque IR, Atchia Y, Sled JG,
    %     Narayanan S, Arnold DL, Pike GB, Cohen-Adad J, Duval T, Vuong M-T and
    %     Stikov N. (2016), Quantitative magnetization transfer imaging made
    %     easy with qMTLab: Software for data simulation, analysis, and
    %     visualization. Concepts Magn. Reson.. doi: 10.1002/cmr.a.21357
    properties (Hidden=true)
        onlineData_url = 'https://osf.io/d8p4h/download?version=1';
    end
    
    properties
        MRIinputs = {'Raw','Mask'};
        xnames = {};
        voxelwise = 0; % 0, if the analysis is done matricially
        % 1, if the analysis is done voxel per voxel
        % Protocol
        Prot = struct();
    end
    % Inherit these from public properties of FilterClass
    % Model options
    % buttons ={};
    % options = struct(); % structure filled by the buttons. Leave empty in the code
    
    methods
        % Constructor
        function obj = filter_map()
            obj.options = button2opts(obj.buttons);
            obj = UpdateFields(obj);
        end
        function FitResult = fit(obj,data)
            % call the superclass (FilterClass) fit function
            FitResult.Filtered=cell2mat(struct2cell(fit@FilterClass(obj,data,[obj.options.Smoothingfilter_sizex,obj.options.Smoothingfilter_sizey,obj.options.Smoothingfilter_sizez])));
            % note: can't use struct2array because dne for octave...
        end
        
    end
    methods(Access = protected)
        function obj = qMRpatch(obj,loadedStruct, version)
            obj = qMRpatch@AbstractModel(obj,loadedStruct, version);
            
        end
        
    end
    
end
    
