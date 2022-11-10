clc
clear
close all


A=imread("shadowed.png"); %shadowed input image

res=shadowRemoval(A); %removing shadows

B=imread("ground_truth.bmp"); %ground truth for reference
imshow([A,res]); %displaying the result


fprintf("MSE of shadowed image w.r.t Ground Truth: %f\n",immse(A,B));
fprintf("MSE of un-shadowed image w.r.t Ground Truth: %f\n",immse(res,B));






