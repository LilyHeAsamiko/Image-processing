function img1=sliceSphere(img,dist_)
%img=imread('cheetah.jpg');
%dist_=2;
C=impixel(img);
img=double(img);
[m,n]=size(img);
for i=1:m
    for j=1:n
        if (img(i,j)-C(1))^2+(img(i,j)-C(2))^2>dist_^2
        img(i,j)=0;
        end
    end
end

img1=zeros(m,n,3);
img1(:,:,3)=uint8(img);

%img=uint8(img);
