function [] = download_data(OSF_link, datasetName)
%DOWNLOAD_DATA Summary of this function goes here
%   Detailed explanation goes here
disp(['Downloading dataset: ', OSF_link])
cmd = ['curl -L -o rrsg_dataset.zip', ' ', OSF_link];
[STATUS,MESSAGE] = unix(char(cmd));
unzip('rrsg_dataset.zip', datasetName(1:end-5));
delete rrsg_dataset.zip
disp(['Dataset downloaded succesfully!'])
end

