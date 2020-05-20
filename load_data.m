function [data, hdr] = load_data(imagePath)
%LOAD_DATA Summary of this function goes here
%   Detailed explanation goes here

disp(['Loading data...'])

[data, hdr] = nii_load(strcat('data/', imagePath),0,'linear');
data = double(data);

disp('Data loaded succesfully!')

end

