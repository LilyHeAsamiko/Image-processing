%% Experiment
%inverse filter
I=imread('1.jpg');
subplot(1,3,1);
imshow(I);
[row,col]=size(I);
[u,v]=meshgrid(-row/2+1:row/2,-col/2+1:col/2);
T=1;
% r=0.1/2/pi;
r=0.1;
%a=(1+2^(1/2)/2)*r;
%b=2^(1/2)/2*r;
a=0.1; 
b=0.1;
H=T./(pi*(u*a+v*b)+0.001)*sin(pi*(u*a+v*b)).*exp(-j*pi*(u*a+v*b));
I_=fft2(I);
I_=fftshift(I_);
G=H.*I_;
Ih=ifft2(fftshift(G));
%Ih=ifft2(G);
Ih=real(Ih);
subplot(1,3,2);
imshow(mat2gray(Ih));
%k=40;
%H2=exp(-k*((u-row/2)^2+(v-col/2)^2)^5/6);
H2=1./H;
G2=H2.*G;
Ih2=ifft2(fftshift(G2));
Ih2=real(Ih2);
subplot(1,3,3);
imshow(mat2gray(Ih2));
err1=immse(Ih,double(I));
err2=immse(Ih2,double(I));

%1.Laplacian operation
OpLaplacian=[-1 -1 -1;-1 8 -1;-1 -1 -1];
fgh=imfilter(I,OpLaplacian);
figure;
subplot 221
imshow(I,[0 255]);
subplot 222
imshow(fgh,[0 255]);
%2.Sobel operation
OpSobel=[-1 -2 -1;-2 0 -2;1 2 1];
subplot 223
f1=imfilter(I,OpSobel);
%3.Sobel+Laplacian;
subplot 224
f2=imfilter(I,OpSobel);
f2=imfilter(f2,OpLaplacian);

%4.geometric mean filter
m=3;
n=3;
I_1=imnoise(I,'gaussian');
O1=exp(imfilter(log(double(I_1)),ones(m,n),'replicate')).^(1/(m*n));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
figure
subplot 121
imshow(I,[0 255]);