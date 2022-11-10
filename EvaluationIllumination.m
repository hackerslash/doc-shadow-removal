function dst = EvaluationIllumination(src, sz)
[height, width, ~] = size(src);
dst = zeros(height, width, 3);
for i = 1:height
    for j = 1:width
        %making a neighbourhood window
        minH = max(i - sz, 1);
        maxH = min(i + sz, height);
        minW = max(j - sz, 1);
        maxW = min(j + sz, width);

        max_valueBGR = [0, 0, 0];
        min_valueBGR = [0, 0, 0];

        for ii = minH:maxH
            for jj = minW:maxW
                %getting max and min in neighbourhood
                max_valueBGR(1) = max(max_valueBGR(1), src(ii, jj, 1));
                min_valueBGR(1) = min(min_valueBGR(1), src(ii, jj, 1));
               
                max_valueBGR(2) = max(max_valueBGR(2), src(ii, jj, 2));
                min_valueBGR(2) = min(min_valueBGR(2), src(ii, jj, 2));
               
                max_valueBGR(3) = max(max_valueBGR(3), src(ii, jj, 3));
                min_valueBGR(3) = min(min_valueBGR(3), src(ii, jj, 3));
            end
        end

        %fusing according to fusionfactor
        for k = 1:3
            if max_valueBGR(k) > 0
                fusionFactor = (max_valueBGR(k) - min_valueBGR(k)) / max_valueBGR(k);
                value = max_valueBGR(k) * fusionFactor + min_valueBGR(k) * (1 - fusionFactor);
                dst(i, j, k) = value;
            else
                dst(i, j, k) = src(i, j, k);
            end
        end

    end
end
dst=uint8(dst);
end