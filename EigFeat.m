function [MinEigFeat, objectFrame] = EigFeat(objectFrame)
%EIGFEAT finds a significant point in the specified region
%   Detailed explanation goes here

figure()
imshow(objectFrame); 
title('Choose region of reference point...')
fprintf('Choose region of reference point...')
objectRegion=round(getPosition(imrect))
MinEigFeat = detectMinEigenFeatures(rgb2gray(objectFrame),'MinQuality',0.6,'ROI',objectRegion);

if size(MinEigFeat.Location,1) ~= 1
    print('MinEigFeat ~= 1')
    MinEigFeat=MinEigFeat.Location(1,:);
end
close(gcf)

referenceImage = insertMarker(objectFrame,MinEigFeat,'+','Color','green','size',20);
figure();
imshow(referenceImage);
print(num2str(MinEigFeat))

end

