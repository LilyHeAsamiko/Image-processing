clear all;
close all;
%%Noise processing 
%example on figure 7 and 8
I1=imread ('9.jpg');
I2=imread ('10.jpg');

%1.Mean filter:noise average
tic
m=3;
n=3;
k=40;
for i=1:k
I_1=imnoise(I1,'gaussian');
O1=mean_filter(I_1,5);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
end
figure
subplot 121
imshow(I1,[0 255]);
subplot 122
imshow(O1,[0 255]);
toc
k=10;
tic
for i=1:k
I_2=imnoise(I2,'gaussian');
O2=mean_filter(I_2,5);
end
figure
subplot 121
imshow(I2,[0 255]);
subplot 122
imshow(O2,[0 255]);
toc

%2.Mean filter:geometric mean
tic
m=3;
n=3;
I_1=imnoise(I1,'gaussian');
O1=exp(imfilter(log(double(I_1)),ones(m,n),'replicate')).^(1/(m*n));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
figure
subplot 121
imshow(I1,[0 255]);
subplot 122
imshow(O1,[0 255]);
toc
tic
I_2=imnoise(I2,'gaussian');
O2=exp(imfilter(log(double(I_2)),ones(m,n),'replicate')).^(1/(m*n));
figure
subplot 121
imshow(I2,[0 255]);
subplot 122
imshow(O2,[0 255]);
toc
%% 
% GHPF and BHPF
% example on figure 9 and 10
%1. Gaussian high-pass filter
clear all;
close all;

I1=imread('9.jpg');
I2=imread('10.jpg');
I_1=double(I1);
I_2=double(I2);

tic
fth1=fft2(I_1);
fh_=fftshift(fth1);
fh = gaussianfilter(I_1,12);
fh_1=fh.*fh_;
gh=ifft2(ifftshift(fh_1));
gh1=real(gh);
subplot 121
imshow(I1,[0,255]);
subplot 122
imshow(gh1,[0,255]);
toc

tic
fth2=fft2(I_2);
fh_2=fftshift(fth2);
fh2= gaussianfilter(I_2,15);
fh_2=fh2.*fh_2;
gh2=ifft2(ifftshift(fh_2));
gh2=real(gh2);
subplot 121
imshow(I2,[0,255]);
subplot 122
imshow(gh2,[0,255]);
toc


%2. BHPF filter
close all;
clear all;
tic
I1=imread('9.jpg');
subplot 121
imshow(I1,[0,255]);
f1=BWHPfilter(I1,15,2);
subplot 122
imshow(f1,[0,255]);
toc
tic
I2=imread('10.jpg');
figure;
subplot 121
imshow(I2,[0,255]);
f2=BWHPfilter(I2,12,2);
subplot 122
imshow(f2,[0,255]);
toc


%2. Histogram-equalization filter
clear all;
close all;
figure;
subplot 121
I1=imread('9.jpg');
imshow(I1,[0,255]);
subplot 122
imshow(localhistequal(I1,2^8),[0 255]);
figure;
subplot 121
I2=imread('10.jpg');
imshow(I2,[0,255]);
subplot 122
imshow(localhistequal(I2,2^8),[0 255]);

%% Enhancement
% log transform and power transform
% example on figure 1 and 2
I3=imread ('1.jpg');
I4=imread ('2.jpg');
c1=35;
c2=1.5;
c3=1;
T1=c1*log(double(I3)+1);
T2=c2*I3.^c3;
T_1=c1*log(double(I4)+1);
T_2=c2*I4.^c3;
figure;
subplot 121
imshow(I3,[0,255]);
subplot 122
imshow(T1,[0,255]);
figure;
subplot 121
imshow(I3,[0,255]);
subplot 122
imshow(T2,[0,255]);
figure;
subplot 121
imshow(I4,[0,255]);
subplot 122
imshow(T_1,[0,255]);
figure;
subplot 121
imshow(I4,[0,255]);
subplot 122
imshow(T_2,[0,255]);

%% Sharpening
% Sobel and Laplacian in space
% example on figure 3 and 4
I5=imread('7.jpg');
I6=imread('8.jpg');
OpSobel=[-1 -2 -1;0 0 0;1 2 1];
OpLaplacian=[-1 -1 -1;-1 8 -1;-1 -1 -1];
figure;
f5=imfilter(I5,OpSobel);
f6=imfilter(I6,OpSobel);
f_5=imfilter(I5,OpLaplacian);
f_6=imfilter(I6,OpLaplacian);
figure;
subplot 121
imshow(I5,[0 255]);
subplot 122
imshow(f5,[0 255]);
figure;
subplot 121
imshow(I6,[0 255]);
subplot 122
imshow(f6,[0 255]);
figure;
subplot 121
imshow(I5,[0 255]);
subplot 122
imshow(f_5,[0 255]);
figure;
subplot 121
imshow(I6,[0 255]);
subplot 122
imshow(f_6,[0 255]);


%% Detect and Color
% choose the anomalies to annote into blue
% example on picture 5 and 6
clear;
close all;
I1=imread('5.jpg');
I2=imread('6.jpg');
figure
imshow(sliceSphere(I1,20));
figure
imshow(sliceSphere(I2,20));

%% Experiment
%1. inverse filter
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

%2.power transform
c2=1.2;
c3=1;
T1=c2*Ih2.^c3;

figure;
subplot 121
imshow(T1,[0,255]);


% 3.Detect and Color
% choose the anomalies to annote into blue
subplot 122
imshow(sliceSphere(I,2));

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



