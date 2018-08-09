load newFeatureMatrix;

for i = 1:10
    
    trainingData = [];
    trainingLabel = [];
    testData = [];
    testLabel = [];
    Resultlabel = [];
    
    gestureMatrix = newFeatureMatrix{i};
    [nr,nc] = size(gestureMatrix);
    
    %Considering 60% of the Data for training and 40% for testing
    numCorrectTrainingData = round(nr*0.6);
    numCorrectTestData = round(nr*0.4);   
    
    %Filling training and testing Data with user data
    TotalTrainingData = 2 * numCorrectTrainingData;
    trainingData = [trainingData;gestureMatrix(1:numCorrectTrainingData,:)];
    testData = [testData;gestureMatrix(numCorrectTrainingData+1:nr,:)];
    
    %Filling training and testing Data with other user data
    eachClassTrainingRecord = round(numCorrectTrainingData / 9);
    eachClassTestRecord = round(numCorrectTestData/9);
    for j = 1:10
        if j ~= i           
            testDataBegin = eachClassTrainingRecord;
            testDataEnd = eachClassTrainingRecord+eachClassTestRecord;
            trainingData = [trainingData;newFeatureMatrix{j}(1:eachClassTrainingRecord,:)];
            testData = [testData;newFeatureMatrix{j}(testDataBegin:testDataEnd,:)];        
        end
    end
    
    % Preparing Training and Testing Label
    [trainingnr,trainingnc] = size(trainingData);
    trainingLabel(1:trainingnr,1) = 0;
    trainingLabel(1:numCorrectTrainingData,1) = 1;
    
    [testingnr,testingnc] = size(testData);
    testLabel(1:testingnr,1) = 0;
    testLabel(1:numCorrectTestData,1) = 1;
    
    %Training using support vector machines 
    svmModel = fitcsvm(trainingData,trainingLabel);
     
    %Testing Data and Computing accuracy using svm model generated
    Resultlabel = predict(svmModel,testData);
    [confusionMatrix,order] = confusionmat(testLabel,Resultlabel);
    
    % Precision
    PrecisionVal(1,i)= confusionMatrix(2,2)/(confusionMatrix(2,2)+confusionMatrix(1,2));
    % Recall
    RecallVal(1,i)=confusionMatrix(2,2)/(confusionMatrix(2,2)+confusionMatrix(2,1));
    % F1-score
    F1score(1,i)=2*RecallVal(1,i)*PrecisionVal(1,i)/(PrecisionVal(1,i)+RecallVal(1,i));
    disp(F1score(1,i));  
    
end  
    
    