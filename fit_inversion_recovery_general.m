function FitResults = fit_inversion_recovery_general(data, Mask, TI, TR, dataType, fitModel)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

disp('Starting to fit data...')

% Assign data to variables needed for qMRLab module
IRData = data;

% Format qMRLab inversion_recovery model parameters, and load them into the Model object
Model = inversion_recovery; 

% Set the customizable settings in the model
Model.Prot.IRData.Mat = [TI'];
Model.Prot.TimingTable.Mat = TR;

Model.options.method = dataType;
Model.options.fitModel = fitModel;

% Format data structure so that they may be fit by the model
fitData = struct();
fitData.IRData = double(IRData);

if ~isempty(Mask)
    fitData.Mask= logical(Mask);

    % If singleton dimension exists in the middle, try adding it
    sizeData = size(fitData.IRData);
    sizeMask = size(fitData.Mask);
    if length(sizeMask) ~= length(sizeData(1:3)) | sizeMask ~= sizeData(1:3)
        switch find(sizeData==1)
            case 1
                fitData.Mask = permute(fitData.Mask, [3,1,2])
            case 2
                fitData.Mask = permute(fitData.Mask, [1,3,2])
            case 3
                fitData.Mask = permute(fitData.Mask, [1,2,3])
        end
    end
end

FitResults = FitData(fitData,Model,0); % The '0' flag is so that no wait bar is shown.

disp('Data fit succesfully!')

end
