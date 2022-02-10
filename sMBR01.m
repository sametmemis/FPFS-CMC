%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Citation:
% Enginoğlu, S., Memiş, S., 2018. Comment on "Fuzzy Soft Sets" [The Journal
% of Fuzzy Mathematics, 9(3), 2001, 589–602],International Journal of Latest
% Engineering Research and Applications, 3(9), 1-9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviation of Journal Title: Int. J. Latest Eng. Res. Appl.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% http://www.ijlera.com/papers/v3-i9/1.201809134.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://www.researchgate.net/profile/Serdar_Enginoglu2
% https://www.researchgate.net/profile/Samet_Memis2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Demo: 
% clc;
% clear all;
% % a is an fpfs-matrix
% % s is a score matrix
% % dm is a decision matrix
% % op is a optimum alternatives' matrix 
% a=rand(5,4); 
% [s,dm,op]=sMBR01(a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [s,dm,op]=sMBR01(a)
%% Step 1
[m,n]=size(a);
%% Step 2
s=zeros(m-1,1);
    for i=2:m
        for k=2:m
            for j=1:n
                s(i-1,1)=s(i-1,1)+a(1,j)*sign(a(i,j)-a(k,j));
            end
        end
    end
%% Step 3    
    for i=1:m-1
        if max(s)==0 && min(s)==0
            dm(i,1)=1;
        else    
            dm(i,1)=(s(i,1)+abs(min(s)))/((max(s)+abs(min(s))));
        end
    end
count=1;
    for i=1:m-1        
        if(dm(i,1)==max(dm))
            op(count)=i;
            count=count+1;
        end
    end

end