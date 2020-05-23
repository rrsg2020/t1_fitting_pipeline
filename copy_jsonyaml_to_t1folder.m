function copy_jsonyaml_to_t1folder(filepath, name, osfDataset, dataType, dataSubType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if strcmp(dataType, 'Complex')
        if  strcmp(dataSubType, 'phase')
            srcYamlFile = [osfDataset(1:end-5), filesep, filepath, filesep, name, '.yaml'];
            srcJsonFile = [osfDataset(1:end-5), filesep, filepath, filesep, name,'.json'];
    
            destYamlFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name(1:end-9), 'Complex_t1map', '.yaml'];
            destJsonFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name(1:end-9), 'Complex_t1map', '.json'];
        elseif strcmp(dataSubType, 'imaginary')
            srcYamlFile = [osfDataset(1:end-5), filesep, filepath, filesep, name, '.yaml'];
            srcJsonFile = [osfDataset(1:end-5), filesep, filepath, filesep, name,'.json'];
    
            destYamlFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name(1:end-4), 'Complex_t1map', '.yaml'];
            destJsonFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name(1:end-4), 'Complex_t1map', '.json'];
        end
    else
        srcYamlFile = [osfDataset(1:end-5), filesep, filepath, filesep, name, '.yaml'];
        srcJsonFile = [osfDataset(1:end-5), filesep, filepath, filesep, name, '.json'];
    
        destYamlFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name, '_t1map', '.yaml'];
        destJsonFile  = [osfDataset(1:end-5), '_t1map', filesep, filepath, filesep, name, '_t1map','.json'];
    end
    
    copyfile(srcYamlFile, destYamlFile);
    copyfile(srcJsonFile, destJsonFile);
end

