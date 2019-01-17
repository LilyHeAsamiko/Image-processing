function y2_=localhistequal(I,k)
I=cat(1,I(1,:),I);
I=cat(2,I(:,1),I);
[m,n]=size(I);
I=cat(1,I,I(m,:));
I=cat(2,I,I(:,n));
I=double(I);
[m,n]=size(I);
hist_=zeros(1,k);

for i=2:m-1
    for j=2:n-1
    hist_(round((I(i-1,j-1)+I(i-1,j)+I(i-1,j+1)+I(i,j-1)+I(i,j)+I(i,j+1)+I(i+1,j-1)+I(i+1,j)+I(i+1,j+1))/9)+1)=hist_(round((I(i-1,j-1)+I(i-1,j)+I(i-1,j+1)+I(i,j-1)+I(i,j)+I(i,j+1)+I(i+1,j-1)+I(i+1,j)+I(i+1,j+1))/9)+1)+1;
    end
end

p(1)=0;
for i=1:k
    p(i+1)=p(i)+hist_(i)/sum(hist_(:));
    lookup(i)=round(255*p(i+1)+0.5);
end

for i=1:m
    for j=1:n
    y2_(i,j)=lookup(I(i,j)+1);
    end
end

end