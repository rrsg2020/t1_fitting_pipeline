function save_qa_png(FitResults, t1MapPath, fileName)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


disp('Saving T1 map to PNG for quality assurance...')

old_dir = pwd;
cd(t1MapPath)

pngFilename = [fileName(1:end-7), '.png'];


% Handle 2D vs 3D case
dims = size(FitResults.T1);

if (length(dims) == 2) || (min(dims) == 1)
    fig = imagesc(squeeze(FitResults.T1)); 
else
    index_smallest_dim = find(dims==min(dims));
    numberOfSlices = dims(index_smallest_dim);
    midSlice = round(numberOfSlices);
    switch index_smallest_dim
        case 1
            fig = imagesc(squeeze(FitResults.T1(midSlice,:,:))); 
        case 2
            fig = imagesc(squeeze(FitResults.T1(:,midSlice,:))); 
        case 3
            fig = imagesc(squeeze(FitResults.T1(:,:,midSlice))); 
    end
end

% Make figure pretty
axis image
axis off
colorbar
caxis([0, 2500]);

% Save figure
saveas(fig, pngFilename);

% Return to original directory
cd(old_dir)

disp('Save complete!')
disp(['Quality assurance PNG file: ', pngFilename])


end

