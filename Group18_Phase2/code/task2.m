% Feature Extraction
dirPath = '/Users/sangeethaswaminathan/Desktop/572proj/finalcsv/';
gestureList = ["about","and","can","cop","deaf","decide","father","find","go_out","hearing"];
alxMinGestureList = [];
alxMaxGestureList = [];
alxFftGestureList = [];
aryMinGestureList = [];
alyMaxGestureList = [];
alyFftGestureList = [];
orlStdGestureList = [];
orlRmsGestureList = [];
emg0lfftGestureList = [];
glxfftGestureList = [];
featureMatrix = [];
gestureCountList = [];

% Extracting 10 features using the 5 feature extraction method
for i = 1 : length(gestureList)
    allFiles = dir(strcat(dirPath,'*.csv'));
    gestureCount = 0;
    for j = 1 : length(allFiles)
        if contains(allFiles(j).name,gestureList(i),'IgnoreCase',true)
            allFiles(j).name
            file = readtable(strcat(allFiles(j).folder,'/',allFiles(j).name));

            alx = table2array(file(1:34:end,:));
            alxMin = min(alx,[],2);
            alxMin(:,2) = alxMin(:,1);
            alxMin(:,1) = i;
            alxMinGestureList = [alxMinGestureList;alxMin];

            alxMax = max(alx,[],2);
            alxMax(:,2) = alxMax(:,1);
            alxMax(:,1) = i;
            alxMaxGestureList = [alxMaxGestureList;alxMax];

            alxFft = fft(alx,1,2);
            alxFft(:,2) = alxFft(:,1);
            alxFft(:,1) = i;
            alxFftGestureList = [alxFftGestureList;alxFft];
           
            ary = table2array(file(5:34:end,:));
            aryMin = min(ary,[],2);
            aryMin(:,2) = aryMin(:,1);
            aryMin(:,1) = i;
            aryMinGestureList = [aryMinGestureList;aryMin];
            
            aly = table2array(file(2:34:end,:));
            alyMax = max(aly,[],2);
            alyMax(:,2) = alyMax(:,1);
            alyMax(:,1) = i;
            alyMaxGestureList = [alyMaxGestureList;alyMax];
            
            alyFft = fft(aly,1,2);
            alyFft(:,2) = alyFft(:,1);
            alyFft(:,1) = i;
            alyFftGestureList = [alyFftGestureList;alyFft];
            
            orl = table2array(file(29:34:end,:));
            orlStd = std(orl,0,2);
            orlStd(:,2) = orlStd(:,1);
            orlStd(:,1) = i;
            orlStdGestureList = [orlStdGestureList;orlStd];

            orlRms = rms(orl,2);
            orlRms(:,2) = orlRms(:,1);
            orlRms(:,1) = i;
            orlRmsGestureList = [orlRmsGestureList;orlRms];
            
            emg0l = table2array(file(7:34:end,:));
            emg0lfft = fft(emg0l,1,2);
            emg0lfft(:,2) = emg0lfft(:,1);
            emg0lfft(:,1) = i;
            emg0lfftGestureList = [emg0lfftGestureList;emg0lfft];
            
            glx = table2array(file(23:34:end,:));
            glxfft = fft(glx,1,2);
            glxfft(:,2) = glxfft(:,1);
            glxfft(:,1) = i;
            glxfftGestureList = [glxfftGestureList;glxfft];
            
            [nr,nc] = size(glxfft);
            gestureCount = gestureCount + nr;
        end
    end
    gestureCountList = [gestureCountList;gestureCount];
end

% All the 10 features are added in the matrix to perform PCA
featureMatrix(:,1) = alxMinGestureList(:,2);
featureMatrix(:,2) = alxMaxGestureList(:,2);
featureMatrix(:,3) = alxFftGestureList(:,2);
featureMatrix(:,4) = aryMinGestureList(:,2);
featureMatrix(:,5) = alyMaxGestureList(:,2);
featureMatrix(:,6) = alyFftGestureList(:,2);
featureMatrix(:,7) = orlStdGestureList(:,2);
featureMatrix(:,8) = orlRmsGestureList(:,2);
featureMatrix(:,9) = emg0lfftGestureList(:,2);
featureMatrix(:,10) = glxfftGestureList(:,2);

% The selected 5 features are added in the matrix to plot
finalFeatureMatrix(:,1) = alxMaxGestureList(:,2);
finalFeatureMatrix(:,2) = aryMinGestureList(:,2);
finalFeatureMatrix(:,3) = orlRmsGestureList(:,2);
finalFeatureMatrix(:,4) = emg0lfftGestureList(:,2);
finalFeatureMatrix(:,5) = glxfftGestureList(:,2);

startIndex = 1;
figure;

% Generates the plot for the selected 5 features
for i = 1 : 5
    classFeatureList = finalFeatureMatrix(startIndex:startIndex+gestureCountList(i)-1,2);
    startIndex = startIndex + gestureCountList(i);
    plot(classFeatureList);  
    hold on;
end
legend("ALX","ARY","ORL","EMG0L","GLX");

startIndex = 1;
newGestureList=["About","And","Can","Cop","Deaf","Decide","Father","Find","Go out","Hearing"];

% Generate 10 plots each corresponding to a gesture
for i = 1 : 10
    classFeatureList = finalFeatureMatrix(startIndex:startIndex+gestureCountList(i)-1,:);
    startIndex = startIndex + gestureCountList(i);
    figure
    plot(classFeatureList);
    hold on;
    title(newGestureList(i));
    legend("ALX","ARY","ORL","EMG0L","GLX");
end





