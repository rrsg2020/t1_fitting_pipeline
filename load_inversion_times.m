function TI = load_inversion_times(imagePath)
%LOAD_INVERSION_TIMES Summary of this function goes here
%   Detailed explanation goes here

disp(['Loading inversion times...'])

[filepath,name,ext] = fileparts(imagePath);

if strcmp(name(end-3:end),'.nii')
   [tmp1,name,tmp2] = fileparts(name);
end
json_path = strcat(name, '.json');
image_config = loadjson(['data' filesep filepath filesep json_path]);
TI = image_config.sequence.inversion_times;

disp(['Inversion times for ', ['data' filesep filepath filesep json_path], ' loaded succefully!'])

end

