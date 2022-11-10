function result = shadowRemoval(img)


gray=rgb2gray(img); % gray version of image for intensity operations


T = adaptthresh(gray, 0.7);
imbinary=imbinarize(gray,T);
% making binary image with with Bradley's Adaptive Thresholding to get
% precise positions for determining global reference color


for i = 1 : size(imbinary,1)
    for j = 1 : size(imbinary,2)
        if imbinary(i,j) == 1
            imbinary(i,j) = 255;
        else
            imbinary(i,j) = 0;
        end
    end
end

%three iteration to get the consistent background map
temp=img;

for i= 1:3
    bg=EvaluationIllumination(temp,2);
    temp=bg;
end





bg_gray=rgb2gray(bg); %converting to gray bg for making it suitable for otsu's


bg_gray=medfilt2(bg_gray); % median filter using 3x3 kernel for smoothing



T=graythresh(bg_gray); % calculating threshold using otsu's method
shadowMap=imbinarize(bg_gray,T);
shadowMap=~shadowMap;







S=FindReferenceBg(bg,imbinary,shadowMap);  % Calculating global bg reference color
local_bg_reference=EvaluationIllumination(img,1); %local bg reference background 



%removing shadows from original image by shadow scale
result=RemoveShadowByBgColorRatio(img,local_bg_reference,S); %till here





end