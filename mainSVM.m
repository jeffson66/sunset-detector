% clear;
load("features.mat");

%% Train and evaluate an SVM

net = fitcsvm(xTrain, yTrain, "Standardize", true, "KernelFunction", "rbf", "KernelScale",17.611, "BoxConstraint",2.8904, "ClassNames",[-1,1]);
% options = struct('MaxObjectiveEvaluations',60);
% net = fitcsvm(xTrain, yTrain, "Standardize", true, "KernelFunction", "rbf", "OptimizeHyperparameters","auto", "HyperparameterOptimizationOptions",options, "ClassNames",[-1,1]);
[detectedClasses, distances] = predict(net, xTest);

accuracy = sum(sum(detectedClasses == yTest)) / size(yTest, 1);

truePositiveIndices = find(detectedClasses == 1 & yTest == 1);
trueNegativeIndices = find(detectedClasses == -1 & yTest == -1);

falsePositiveIndices = find(detectedClasses == 1 & yTest == -1);
falseNegativeIndices = find(detectedClasses == -1 & yTest == 1);

rootdir = 'images/';

testImages = imageDatastore(...
    [rootdir 'test'], ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

for i = 1:100
    [img, fileinfo] = readimage(testImages, truePositiveIndices(i));
    disp(fileinfo.Label);
    imshow(img);
    pause(.1);
end
