function [res] = create_residual(path, srno)
org = [];
count = 1;
for i=1:size(srno, 2)
    framename = strcat('frame', int2str(srno(i)), '.jpg');
    temp = rgb2gray(imread(strcat(path, framename)));
    org(count, :, :) = temp;
    count = count + 1;    
end
org = uint8(org);

original = reshape(org(idivide(count, int32(2)), :, :), [size(org, 2), size(org, 3)]);
res = imsubtract(original, collusion_min(org));
