clc;clear all;close all;

tic

[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp','Pick an Image');
if isequal(FileName,0)||isequal(PathName,0)
    warndlg('user press cancel');
else 
    a=imread([PathName,FileName]);
a=rgb2gray(a);
a=imresize(a,[256 256]);
[R,C]=size(a);

iter=25;
out=arnold(a,iter);

outinv=iarnold(out,iter);

toc

figure,imshow(uint8(a));title('Original Image');
figure,imshow(uint8(out));title('Scrambled Image');
figure,imshow(uint8(outinv));title('Descrambled Image');

figure,hist(double(a));title('Original Image');
figure,hist(double(outinv));title('Descrambled Image');

MXN=R*C;
MSE=(sum(sum((((uint8(a))-(uint8(outinv))).^2))))/MXN;

PSNR=10*log10(255^2/MSE);
ssimval= ssim(uint8(outinv),uint8(a));


message=sprintf('The mean square error is %.2f.\nThe PSNR value is %.2f.\nThe SSIM value is %.2f.',MSE,PSNR,ssimval);
msgbox(message);


end