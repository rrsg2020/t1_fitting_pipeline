function [data, hdr] = load_data(dataType, imagePath)
%LOAD_DATA Summary of this function goes here
%   Detailed explanation goes here

disp(['Loading data of type: ', dataType])

switch dataType
    case "Magnitude"
        [data, hdr] = nii_load(strcat('data/', imagePath),0,'linear');
        data = double(data);
    case "Complex"
        [data_re, hdr_re] = nii_load(strcat('data/', imagePath{1}),0,'linear');
        [data_im, hdr_im] = nii_load(strcat('data/', imagePath{2}),0,'linear');
        data = double(data_re) + i*double(data_im);
        hdr = hdr_re;
    otherwise
        error("dataType must be either Magnitude or Complex. Stop.")
end

disp('Data loaded succesfully!')

end

