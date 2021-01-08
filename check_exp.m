%% this program is an example for generating CGIDL from experiment results 

%% please load the experiment results first!
load('./experiment_results/experiment_intensity_1_pink54x98_20201223.mat')

EXP_num = 1;

PatternNum = 2  ;
% 1 white noise ortho
% 2 white noise (used in the paper)
% 3 red noise ortho
% 4 red noise (used in the paper)

% size of images 
sizex=54;
sizey=98;

% the beta tested 
betaBOX = [1 0.5 0.1 0.05 0.01 0.005 0.003 0.002 0.001];

% filefolder name of results
fileFolder_job = ['./test',color ];





root=[pwd,'\'];
colors={'white','pink',};
color = colors{ceil(PatternNum/2)};

mkdir(fileFolder_job)
load([root,'Noise patterns\pattern',num2str(PatternNum)])
for beta = betaBOX
%% initail
% load('D:\study\GHOST\deeplearning_ghostimage\experiment_intensity_2_',color,'54x98_20201218.mat')
% load(['./NET/net_1_created_b',num2str(beta),'_widen.mat'])
load(['./NET/DLnet12.08_54X98/net_',color,num2str(beta,'%.3f'),'.mat'],'net')

Nth= round(sizex * sizey * beta);
for NAME = 'generate CGI image'
    
    PI = zeros(sizex,sizey);
    P= zeros(sizex,sizey);
    for i = 1:Nth
        PI = PI + txt(1:sizex,1:sizey,i) .* I(i);
        P = P + txt(1:sizex,1:sizey,i);
    end
    PI_mean=PI/Nth;
    P_mean=P/Nth;
    CGI_img=PI_mean-P_mean.*mean(I(:));
    CGI_img = norm_mat(CGI_img);
end



imshow(CGI_img)
% title(['beta = ',num2str(beta),'  |   CGI image' ])
FILE_NAME_jpg = [fileFolder_job   ,'/CGI_',num2str(EXP_num),'_',color,num2str(beta),'.jpg'];
FILE_NAME_mat =  [fileFolder_job   ,'/CGI_',num2str(EXP_num),'_',color,num2str(beta),'.mat'];
imwrite(CGI_img,FILE_NAME_jpg);
save(FILE_NAME_mat,'CGI_img')
predicted_image= predict(net,reshape(CGI_img,54,98));
predicted_image = reshape(predicted_image,54,98);
% title(['beta = ',num2str(beta),'  |   CGI DL image' ])
imshow(predicted_image)
FILE_NAME_jpg = [fileFolder_job  ,'/CGIDL_',num2str(EXP_num),'_',color,num2str(beta),'.jpg'];
FILE_NAME_mat =  [fileFolder_job   ,'/CGIDL_',num2str(EXP_num),'_',color,num2str(beta),'.mat'];
imwrite(predicted_image,FILE_NAME_jpg);
save(FILE_NAME_mat,'predicted_image')
end