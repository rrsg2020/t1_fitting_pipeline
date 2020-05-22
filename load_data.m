function [data, hdr] = load_data(imagePath, datasetName)
%LOAD_DATA Summary of this function goes here
%   Detailed explanation goes here

disp(['Loading data...'])

[data, hdr] = nii_load([datasetName(1:end-5), filesep, imagePath],0,'linear');
data = double(data);

disp('Data loaded succesfully!')

end

