function [result] = RemoveShadowByBgColorRatio(img, localBgColorImg, iRefBg)
[height, width, ~] = size(img);
result = zeros(height, width, 3);
for i = 1:height
    for j = 1:width
        for k = 1:3
              ratio = 1.0 *double(iRefBg(k))/double(localBgColorImg(i, j, k)); %shadow scale
              result(i, j, k) = double(img(i, j, k)) * ratio; %multiplying with scale
        end
    end

end

result=uint8(result);
end