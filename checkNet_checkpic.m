% this code is used to check the network using the data of other pictures
% from check_pic firefolder.
% global txt
% load('./Noise patterns/pattern4.mat')


root=[pwd,'\'];
img_ori =imread([root,'check_pic\1.bmp']);
imgOriSize = size(img_ori);
if(imgOriSize(3)==3)
    img_ori = rgb2gray(img_ori);
end
target=(double(img_ori));

% ͼ�� 28x28 ���δ���
% background=zeros(54,98);
% target=imresize(target,[54 54]);
% background(1:54,23:76)=target+background(1:54,23:76);
% target=background;
% 
% background=zeros(54,98);
% target=imresize(target,[54 54]);
% background(1:54,23:76)=target+background(1:54,23:76);
% target=background;


% widen the target
% target=imresize(target(:,23:76),[54 98]);
target = imresize(target,[54 98]);


beta=0.05;
target = norm_mat(target);
% target(target<200)=0;
% target(target>=220)=255;
%get the CGI pic
result=generateCGI(target,beta);
%get the predicted pic using net
% Predicted_result=predict(net,result);
% Predicted_result=reshape(Predicted_result,54,98);
%% plot results
subplot 311
imshow(target)
title('target')
set(gca,'FontName','Times New Roman','FontSize',25,'LineWidth',1.5);
% colorbar
subplot 312
imshow(result)
title('CGI result')
set(gca,'FontName','Times New Roman','FontSize',25,'LineWidth',1.5);
% colorbar
subplot 313

% imshow(Predicted_result)
% title('CGI DL result')
% set(gca,'FontName','Times New Roman','FontSize',25,'LineWidth',1.5);
% % colorbar
