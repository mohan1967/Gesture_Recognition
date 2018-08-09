% PCA
[eigVectors,score,eigValues] = pca(featureMatrix);

n = 10 ;
newFeatureMatrix = cell(n, 1) ;
startIndex = 1;
classFeatureMatrix = [];
newFeatureMatrix = [];
gestureList=["about";"and";"can";"cop";"deaf";"decide";"father";"find";"go out";"hearing"];

% Generating new feature matrix - 10 matrices - one for each gesture 
for i = 1:10
    classFeatureMatrix = featureMatrix(startIndex:startIndex+gestureCountList(i)-1,:);
    startIndex = startIndex + gestureCountList(i); 
    newClassFeatureMatrix = classFeatureMatrix*eigVectors;
    figure
    plot(newClassFeatureMatrix);
    title(gestureList(i,:));
    legend("ALX Max","ALX FFT","ARY Min","ALY Max","ALY FFT","ORL Std","ORL Rms","EMG0L FFT","GLX FFT");
    newFeatureMatrix{i} = newClassFeatureMatrix;
end



    

