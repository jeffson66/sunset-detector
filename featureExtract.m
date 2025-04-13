function [featureVector] = featureExtract(image, nBlocks)
% calculate the feature vector for a given image

    featureVector = [];

    R = double(image(:,:,1));
    G = double(image(:,:,2));
    B = double(image(:,:,3));

    L = R + G + B;
    S = R - B;
    T = R - 2*G + B;

    blockHeight = floor(size(image, 1) / nBlocks);
    blockWidth = floor(size(image, 2) / nBlocks);

    for i=0:nBlocks-1
        for j=0:nBlocks-1
            rowIdxs = 1 + (i*blockHeight:((i+1)*blockHeight-1));
            columnIdxs = 1 + (j*blockWidth:((j+1)*blockWidth-1));

            LSection = L(rowIdxs, columnIdxs);
            SSection = S(rowIdxs, columnIdxs);
            TSection = T(rowIdxs, columnIdxs);

            LMean = mean(LSection(:));
            SMean = mean(SSection(:));
            TMean = mean(TSection(:));

            LStd = std(LSection(:));
            SStd = std(SSection(:));
            TStd = std(TSection(:));
            
            featureVector(end+1) = LMean;
            featureVector(end+1) = LStd;

            featureVector(end+1) = SMean;
            featureVector(end+1) = SStd;

            featureVector(end+1) = TMean;
            featureVector(end+1) = TStd;
        end
    end
end