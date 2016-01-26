clc;
clear all;
threshold = 40;
datasetName = 'highway';
basepath = sprintf('img/%s/input/', datasetName);
resultpathpattern =  sprintf('img/%s/result/', datasetName);

img = imread(sprintf('%sin000001.jpg', basepath));
grayImg = double(rgb2gray(img));
[hImg wImg] = size(grayImg);
fileNames = dir(fullfile(basepath,'*.jpg'));
N = length(fileNames);

h1 = figure(1);
for f = 1:N
    filepath = sprintf('%s%s', basepath, fileNames(f).name);
      
    B = grayImg; 
    img = imread(filepath);
    grayImg = double(rgb2gray(img)); 

    % Substraction version
    frameDiff = abs(grayImg - B);
    for j = 1 : wImg
        for k = 1 : hImg
            if (frameDiff(k,j) > threshold)
                lastImg(k,j) = grayImg(k,j);
            else
                lastImg(k,j) = 0;
            end
        end
    end

    subplot(2,2,1) , imagesc(img), title(['Original frame #', int2str(f)]);
    subplot(2,2,2) , imshow(mat2gray(grayImg)), title('Previous Frame');
    subplot(2,2,3) , imshow(mat2gray(B)), title('Next Frame');
    subplot(2,2,4) , imagesc(lastImg), title ('Foreground');
        
    %hold on;
    pause (.001);
    %imwrite(lastImg, strcat(resultpathpattern, num2str(f), '.png'), 'png');
end




