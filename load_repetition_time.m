function TR = load_repetition_time(imagePath, datasetName)
%LOAD_REPETITION_TIME Summary of this function goes here
%   Detailed explanation goes here

disp(['Loading repetition time...'])

[filepath,name,ext] = fileparts(imagePath);

if strcmp(name(end-3:end),'.nii')
   [tmp1,name,tmp2] = fileparts(name);
end
json_path = strcat(name, '.json');
image_config = loadjson([datasetName(1:end-5), filesep, filepath, filesep, json_path]);

TR = image_config.sequence.repetition_time;

disp(['Repetition time for ', [datasetName(1:end-5), filesep, filepath, filesep, json_path], ' loaded succefully!'])

end

