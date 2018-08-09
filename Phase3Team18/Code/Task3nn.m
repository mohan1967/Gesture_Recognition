load newFeatureMatrix;
finaltrainingData = [];
finalTrainingLabel = [];
  
%Class Label number. 1 for About, 2 for And
i = 4;


[nr,nc] = size(newFeatureMatrix{i});

% Generates Overall Data. The data is divided into training and test using
% Neural Network ToolBox

finaltrainingData = [finaltrainingData;newFeatureMatrix{i}];
otherTrainingData = round(nr/9);

for j = 1:10
   if i~=j
       finaltrainingData = [finaltrainingData;newFeatureMatrix{i}(1:otherTrainingData,:)];
    end
end
   
[finalnr,finallnc] = size(finaltrainingData);

% Preparing Label for the data generated
finalTrainingLabel(1:finalnr,1) = 0;
finalTrainingLabel(1:nr,1) = 1;


    
