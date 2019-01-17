function O=mean_filter(I1,size_)
%I=I1;
%I1=rgb2gray(I);
%size_=5;
[m1,n1]=size(I1);
I1=cat(1,I1(1,:),I1(2,:),I1,I1(m1-1,:),I1(m1,:));
I1=cat(2,I1(:,1),I1(:,2),I1,I1(:,n1-1),I1(:,n1));
%I2=[I1(:,1),I1(:,2),[I1,I1(:,n1-1)],I1(:,n1)];
for i=3:m1+2
    for j=3:n1+2
        for p=1:size_
            for q=1:size_
            Im(p,q)=I1(i-(size_-1)/2+p-1,j-(size_-1)/2+q-1);
            end
        end    
        O(i-2,j-2)=mean(Im(:));
        %j=j+1;
    end
end
%imshow(O,[0,255])
end