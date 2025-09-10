close all;
clear all;
clc;

%load the image
[y map] = imread('grayscale.jpg');

%show original image
imshow(y);
y = double(y);
title('Original 8-bit Image');

%quantize to different bit levels
for m = 7:-1:1
    %load the image
    y = imread('grayscale.jpg');

    %compute number of grayscale levels
    M = 2^m;

    %quantize original colors to new number of colors
    fact = round(255/(M-1));
    y    = double(y);
    y    = round(y./fact);
    y    = y*fact;
    
    %convert back to unsigned integer format
    y = uint8(y);
    
    %display quantized image
    figure;
    imshow(y);
    title([num2str(m) '-bit Quantization']);
end