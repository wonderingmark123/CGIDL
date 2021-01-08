function CGIpic=generateCGI(target,beta,varargin)
% please load the pattern and global txt
% CGIpic is normalized, and target is range from 0 to 255

% the CGIpic is normalized to [0,1]
global txt

sizex=54;
sizey=98;
if(length(varargin)==2)
    sizex=round(varargin{1});
    sizey=round(varargin{2});
end

% target=norm_mat(target).*255;

Npixel=sizex*sizey;
Nth=beta*Npixel;


PI=zeros(sizex,sizey);
P=zeros(sizex,sizey);
I=[];
for j=1:1:Nth
    pass=target.*txt(:,:,j);
    I(j)=sum(pass(:));
%     P=P+eval(['txt',num2str(j),'(1:sizex,1:sizey)']);
    P=P+txt(:,:,j);
%     PI=PI+eval(['I(',num2str(j),').*txt',num2str(j),'(1:sizex,1:sizey)']);
    PI=PI+I(j).*txt(:,:,j);
end
PI_mean=PI/Nth;
P_mean=P/Nth;
I_mean=sum(I(:))/Nth;
result=PI_mean-(P_mean*I_mean);
% eval(['image_input',num2str(i),'=result;']);
CGIpic=norm_mat(result);
% CGIpic=result;
end

