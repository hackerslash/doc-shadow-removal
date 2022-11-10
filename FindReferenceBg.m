function [iRefBg] = FindReferenceBg(bgImg, binary, shadowMap)


[height, width, ~] = size(bgImg);
BGR = [0,0,0];
countNum = 0;
for i = 1:height
    for j = 1:width %getting the average mean bg in unshadowed regions
        if shadowMap(i,j)>0 && binary(i,j)>0 
            BGR(1) = BGR(1) + bgImg(i,j,1);
            BGR(2) = BGR(2) + bgImg(i,j,2);
            BGR(3) = BGR(3) + bgImg(i,j,3);
            countNum = countNum + 1;
        end
    end
end

avg_bgr = BGR / countNum;

curMin = 255 * 255 * 3;

%finding the closest value to the average
for i = 1:height
    for j = 1:width
        if shadowMap(i,j)>0 && binary(i,j)>0
            curMag = 0;
            for k = 1:3
                diff = bgImg(i,j,k) - avg_bgr(k);
                curMag = curMag + diff * diff;
            end
            if curMag < curMin
                curMin = curMag;
                iRefBg(1) = bgImg(i,j,1);
                iRefBg(2) = bgImg(i,j,2);
                iRefBg(3) = bgImg(i,j,3);
            end
        end
    end
end

end