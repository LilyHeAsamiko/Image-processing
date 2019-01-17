function img=sliceCube(img,dist_)
%img=imread('cheetah.jpg');
%dist_=2;
C=impixel(img);
img=double(img);
[m,n]=size(img);
for i=1:m
    for j=1:n
        if abs(img(i,j)-C(1))+abs(img(i,j)-C(2))+abs(img(i,j)-C(3))>dist_
        img(i,j)=127;
        end
    end
end
img=uint8(img);


