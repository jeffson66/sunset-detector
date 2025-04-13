% Plot an ROC curve for an image. 

actualPositives = sum(sum(yTest == 1));
actualNegatives = sum(sum(yTest == -1));

left = -2;
right = 2;
numPoints = 50;
truePosRate = zeros(numPoints, 1);
falsePosRate = zeros(numPoints, 1);
for i=1:numPoints
    t = right - ((right-left)/numPoints)*i;
    truePosRate(i) = sum((distances(:, 2) >= t) & (yTest == 1)) / actualPositives;
    falsePosRate(i) = sum((distances(:, 2) >= t) & (yTest == -1)) / actualNegatives;
end

% Create a new figure. You can also number it: figure(1)
figure;
% Hold on means all subsequent plot data will be overlaid on a single plot
hold on;
% Plots using a blue line (see 'help plot' for shape and color codes 
plot(falsePosRate, truePosRate, 'b-', 'LineWidth', 2);
% Overlaid with circles at the data points
plot(falsePosRate, truePosRate, 'bo', 'MarkerSize', 4, 'LineWidth', 2);

% You could repeat here with a different color/style if you made 
% an enhancement and wanted to show that it outperformed the baseline.

% Title, labels, range for axes
title('ROC Curve', 'fontSize', 18); % Really. Change this title.
xlabel('False Positive Rate', 'fontWeight', 'bold');
ylabel('True Positive Rate', 'fontWeight', 'bold');
% TPR and FPR range from 0 to 1. You can change these if you want to zoom in on part of the graph.
axis([0 1 0 1]);