% Example of using a datastore, see 

clc;
% clear;

rootdir = 'images/';

trainImages = imageDatastore(...
    [rootdir 'train'], ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

testImages = imageDatastore(...
    [rootdir 'test'], ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

validateImages = imageDatastore(...
    [rootdir 'validate'], ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

% Make datastores for the validation and testing sets similarly.

fprintf('Read images into datastores\n');

xTrain = imageDatastoreReader(trainImages);
yTrain = trainImages.Labels;

xTest = imageDatastoreReader(testImages);
yTest = testImages.Labels;

xVal = imageDatastoreReader(validateImages);
yVal = validateImages.Labels;

temp = zeros(size(yTrain, 1), 1);
temp(yTrain == "sunset") = 1;
temp(yTrain == "nonsunset") = -1;
yTrain = temp;
temp = zeros(size(yTest, 1), 1);
temp(yTest == "sunset") = 1;
temp(yTest == "nonsunset") = -1;
yTest = temp;
temp = zeros(size(yVal, 1), 1);
temp(yVal == "sunset") = 1;
temp(yVal == "nonsunset") = -1;
yVal = temp;

save("features.mat", "xTrain", "yTrain", "xTest", "yTest", "xVal", "yVal");

fprintf('Done read images into datastores\n');