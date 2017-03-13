function [residuals] = create_residuals_video(path, maximum)
residuals = [];
count = 1;
for i=1:25:(maximum - 10)
    srno = i:(i+8);
    residuals(count, :, :) = create_residual(path, srno);
    count = count + 1;    
end
residuals = uint8(residuals);

