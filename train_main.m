% load('training_output_norm')
% load('training_input_rednoise_ortho_norm')

%% if the images are colored, the Multi should be 3.
Multi=1;
layers = [
    imageInputLayer([sizex sizey Multi])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    averagePooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    averagePooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    dropoutLayer(0.2)
    fullyConnectedLayer(sizex*sizey*Multi)
    
    regressionLayer];

% epoch=[10 100 300 500];
% for i=1:4
%
%     options = trainingOptions('sgdm', ...
%     'MaxEpochs',epoch(i), ...
%     'InitialLearnRate',1e-3, ...
%     'LearnRateSchedule','piecewise', ...
%     'LearnRateDropFactor',0.1, ...
%     'LearnRateDropPeriod',75, ...
%     'Shuffle','every-epoch', ...
%     'Plots','training-progress', ...
%     'Verbose',true);
%     netEPOCH{i} = trainNetwork(image_input,output',layers,options);
% end


%% if GPU memory is out of range, lower MiniBatchSize is recommanded.
options = trainingOptions('sgdm', ...
    'MaxEpochs',600, ...
    'InitialLearnRate',1e-3, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',75, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
         'MiniBatchSize' ,32,...
    'Verbose',true);
%       'MiniBatchSize' ,32,...

colors={'white','pink'};
color = colors{ceil(PatternNum/2)};

net = trainNetwork(image_input,output',layers,options);
mkdir(NetSaveFolder)
save([NetSaveFolder,'/net_',color,num2str(beta,'%.3f'),'.mat'],'net')