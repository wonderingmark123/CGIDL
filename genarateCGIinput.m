%% Generate training patterns


% sizex=28;
% sizey=28;
global txt
% root='D:\study\GHOST\deeplearning_ghostimage\';
root=[pwd,'\'];

%% load output
%% Here we adopted standard output for the training, you can change it to any outputs you want
% load([root,'training_output_norm2828.mat'])
load([root,'training_output_norm_widen'])


%% initail 
load([root,'Noise patterns\pattern',num2str(PatternNum)])

txt=txt(1:sizex,1:sizey,1:sizex*sizey);

[LenOutput,WidOutput]=size(output);
img_num=WidOutput;
image_input=zeros(sizex,sizey,1,img_num);

% output_minus=output.*0;
% output_fft=zeros(sizex*sizey*2,img_num);
% image_input_fft=zeros(sizex,sizey,1,img_num);

for i=1:img_num
    target=reshape(output(:,i),sizex,sizey).*255;
    target(target<200)=0;
    target(target>=200)=255;
%     target=eval(['image',num2str(i),';']);
    result=generateCGI(target,beta,sizex,sizey);
    image_input(:,:,1,i)=result;
%     output_minus(:,i)=output(:,i)-reshape(norm_mat(result),sizex*sizey,1);
%     image_input(:,:,1,i)=result-norm_mat(target);

%% fft process
% 
%     image_input_fft(:,:,1,i)=norm_mat(angle(fft2(result)));
%     image_input_fft(:,:,2,i)=norm_mat(abs(fft2(result)));
%     imshow(result)
%     figure
%     imshow(ifft2(fft2(result)))
%     output_fft(1:sizex*sizey,i)=reshape( norm_mat(angle(fft2(target))),sizex*sizey,1);
%     output_fft(sizex*sizey+1:end,i)=reshape( norm_mat(abs(fft2(target))),sizex*sizey,1);

    %% wavelet process
%      waveletScattering2('ImageSize',[54 96])
    
end
% output_minus_norm=norm_mat(output_minus);

