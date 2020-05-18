function FitResults = fit_inversion_recovery(data, TI, dataType)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

disp('Starting to fit data...')

% Assign data to variables needed for qMRLab module
IRData = data;

% Format qMRLab inversion_recovery model parameters, and load them into the Model object
Model = inversion_recovery; 

% Set the customizable settings in the model
Model.Prot.IRData.Mat = [TI'];
Model.options.method = dataType;

% Format data structure so that they may be fit by the model
fitData = struct();
fitData.IRData= double(IRData);

FitResults = FitData(fitData,Model,0); % The '0' flag is so that no wait bar is shown.

disp('Data fit succesfully!')

end
