close all;
clear all;
clc;

%load the image
y = imread('grayscale.jpg');
y = y(:,:,1);

%show original image
imshow(y);
title('Original 368x512 Pixel Image');
y = double(y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downsample rows and columns by 2
y_new1 = dyaddown(y,'m');
y_new1 = uint8(y_new1);

figure;
imshow(y_new1);
title('Decimated 184x256 Pixel Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downsample rows and columns by 2
y_new2 = dyaddown(y_new1,'m');
y_new2 = uint8(y_new2);

figure;
imshow(y_new2);
title('Decimated 92x128 Pixel Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downsample rows and columns by 2
y_new3 = dyaddown(y_new2,'m');
y_new3 = uint8(y_new3);

figure;
imshow(y_new3);
title('Decimated 46x64 Pixel Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downsample rows and columns by 2
y_new4 = dyaddown(y_new3,'m');
y_new4 = uint8(y_new4);

figure;
imshow(y_new4);
title('Decimated 23x32 Pixel Image');

%now reconstruct images uses "2-D Sinc Interpolation" to get back to
%original image size.

y_new1 = imresize(y_new1,[368 512]);
figure;
imshow(y_new1);
title('Reconstructed Image from 184x256 Pixel Image');

y_new2 = imresize(y_new2,[368 512]);
figure;
imshow(y_new2);
title('Reconstructed Image from 92x128 Pixel Image');

y_new3 = imresize(y_new3,[368 512]);
figure;
imshow(y_new3);
title('Reconstructed Image from 46x64 Pixel Image');

y_new4 = imresize(y_new4,[368 512]);
figure;
imshow(y_new4);
title('Reconstructed Image from 23x32 Pixel Image');
