%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Citation:
% S. Memi?, S. Engino?lu, and U. Erkan, 2022. A Classification Method in 
% Machine learning Based on Soft Decision-Making via Fuzzy Parameterized 
% Fuzzy Soft Matrices, Soft Computing, 26(3), 1165?1180.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviation of Journal Title: Soft Comput.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://doi.org/10.1007/s00500-021-06553-z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://www.researchgate.net/profile/Samet_Memis2
% https://www.researchgate.net/profile/Serdar_Enginoglu2
% https://www.researchgate.net/profile/Ugur_Erkan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Demo: 
% clc;
% clear all;
% DM = importdata('Wine.mat');
% [x,y]=size(DM);
% 
% data=DM(:,1:end-1);
% class=DM(:,end);
% if prod(class)==0
%     class=class+1;
% end
% k_fold=5;
% cv = cvpartition(class,'KFold',k_fold);
%     for i=1:k_fold
%         test=data(cv.test(i),:);
%         train=data(~cv.test(i),:);
%         T=class(cv.test(i),:);
%         C=class(~cv.test(i),:);
%     
%         sFPFSCMC=FPFSCMC(train,C,test);
%         accuracy(i,:)=sum(sFPFSCMC==T)/numel(T);
%     end
% mean_accuracy=mean(accuracy);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PredictedClass=FPFSCMC(train,C,test)
[em,en]=size(train);

  for j=1:en
      fw(1,j)=abs(corr(train(:,j),C,'Type','Pearson','Rows','complete'));
  end
  fw(isnan(fw))=0;

[tm,n]=size(test);

data=[train;test];
for j=1:n
    data(:,j)=normalise(data(:,j));
end
train=data(1:em,:);
test=data(em+1:end,:);


 for i=1:tm   
    clear cm dm;
    a=[fw ; test(i,:)];
    for j=1:em
        b=[fw ; train(j,:)];
        cm(j,1)=fpfss1(a,b);
        cm(j,2)=fpfss2(a,b);
        cm(j,3)=fpfss3(a,b);
        cm(j,4)=fpfss5(a,b);
        cm(j,5)=fpfss6(a,b,3);
    end

    for jj=1:size(cm,2)
        sd(1,jj)=std(cm(:,jj));
    end
     wm2(1,:)=1-normalise(sd)/4;
    
     dm(:,:)=[ wm2 ; cm];
    
    [~,~,op]=sMBR01(dm);
    PredictedClass(i,1)=C(op(1),1);
    
end
end

function na=normalise(a)
[m,n]=size(a);
    if max(a)~=min(a)
        na=(a-min(a))/(max(a)-min(a));
    else
        na=ones(m,n);
    end
end                                                                                                                                                                  

% Hamming pseudo similarity over fpfs-matrices
% 
% 
function X=fpfss1(a,b)
if size(a)~=size(b)
    
else
[m,n]=size(a);
d=0;
  for i=2:m
    for j=1:n
       d=d+abs(a(1,j)*a(i,j)-b(1,j)*b(i,j));
    end
  end
  X=1-(d/((m-1)*n));
end
end
% Chebyshev pseudo similarity over fpfs-matrices
% 
% 
function X=fpfss2(a,b)
if size(a)~=size(b)
    
else
[m,n]=size(a);

  for i=2:m
    for j=1:n
       d(j)=abs(a(1,j)*a(i,j)-b(1,j)*b(i,j));
    end
    e(i-1)=max(d);
  end
  X=1-max(e);
end
end
% Euclidean pseudo similarity over fpfs-matrices
% 
%
function X=fpfss3(a,b)
if size(a)~=size(b)
    
else
[m,n]=size(a);
d=0;
  for i=2:m
    for j=1:n
       d=d+abs(a(1,j)*a(i,j)-b(1,j)*b(i,j))^2;
    end
  end
  X=1-(sqrt(d)/(sqrt((m-1)*n)));
end
end
% Hamming-Hausdorff pseudo similarity over fpfs-matrices
% 
%
function X=fpfss5(a,b)
if size(a)~=size(b)
    
else
[m,n]=size(a);

  for i=2:m
    for j=1:n
       d(j)=abs(a(1,j)*a(i,j)-b(1,j)*b(i,j));
    end
    e(i-1)=max(d);
  end
  X=1-(sum(e)/(m-1));
end
end
% Generalized pseudo similarity over fpfs-matrices
% 
%
function X=fpfss6(a,b,p)
if size(a)~=size(b)
    
else
[m,n]=size(a);
d=0;
  for i=2:m
    for j=1:n
       d=d+abs(a(1,j)*a(i,j)-b(1,j)*b(i,j))^p;
    end
  end
  X=1-((d^(1/p))/(((m-1)*n)^(1/p)));
end
end
