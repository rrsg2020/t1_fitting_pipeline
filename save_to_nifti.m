function save_to_nifti(FitResults, hdr, t1MapPath, fileName)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
disp(['Saving T1 map to NIFTI...'])

old_dir = pwd;
mkdir(t1MapPath)
cd(t1MapPath)

hdr.file_name=fileName;
nii_save(FitResults.T1,hdr,hdr.file_name);

cd(old_dir)

disp('Save complete!')

end


