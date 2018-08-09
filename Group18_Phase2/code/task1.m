% Segmentation
gestureList=["about","and","can","cop","deaf","decide","father","find","go_out","hearing"];
dirPath = '/Users/sangeethaswaminathan/Desktop/572/CSE572_A2_data/';
headerFile = importdata(strcat(dirPath,'DM01/about100233AM.csv'),' ',1);
sensorList = strsplit(headerFile{1},',');
finalSensorList = sensorList(1,1:34);
finalSensorListTable = cell2table(finalSensorList);
zeroRow = array2table(zeros([1 34]));

% Generates 10 csv file - One for each Gesture
% Clean up is done in the process by elimating noise
for i = 1 : length(gestureList)
    finalActionTable=[]
    for folderIter = 1:37  
        if folderIter < 10
            folderName=strcat('DM0',int2str(folderIter));
        else
            folderName=strcat('DM',int2str(folderIter));
        end   
        folderPath = strcat('/Users/sangeethaswaminathan/Desktop/572/CSE572_A2_data/',folderName);
        folderPath = strcat(folderPath,'/');
        allFiles=dir(strcat(folderPath,'*.csv'));
        for j = 1 : length(allFiles)
            if contains(allFiles(j).name,gestureList(i),'IgnoreCase',true)
                allFiles(j).name
                file = readtable(strcat(allFiles(j).folder,'/',allFiles(j).name));                
                [nr,nc] = size(file);
                if nr > 10
                    file = file(:,1:34);
                    if nr >= 40
                        file=file(1:40,:);
                    else 
                        while nr < 40
                            file = [file;zeroRow];
                            nr = nr+1;
                        end
                    end
                    finalActionTable = [finalActionTable;transpose(table2cell(file))];
                end                
            end
        end
    end
    ft = cell2table(finalActionTable);
    writetable(ft,(gestureList(i)+'.csv'));
end
