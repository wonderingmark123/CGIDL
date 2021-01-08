%% this is the whole traning process of DLCGI, please make sure you have clear the workspace.
% clear

%% what is your training and testing patterns?
% ie:
PatternNum=2;
% 1 white noise ortho
% 2 white noise (used in the paper)
% 3 red noise ortho
% 4 red noise (used in the paper)


%% what is the \beta for CGi? 
beta=0.03; %beta

%% the file folder to save the net
NetSaveFolder = './NET/DLnet12.08_54X98';

%% what is your size of traning input and output images?
sizex=54;
sizey=98;

%% generate the training set for the net
genarateCGIinput

%% training the net 
train_main
