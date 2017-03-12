function [out] = collusion_min(inp)
if size(inp) == 0
    return
end
height = size(inp, 2);
width = size(inp, 3);
out = [];
count = 0;
for i = 1:height
    for j = 1:width
        min_value = 256;
        for k = 1:size(inp, 1)           
            min_value = min(min_value, inp(k, i, j));
            count = count + 1;
            %disp = sprintf('i %d j %d value %d', i, j, inp(k, i, j));            
            %display(disp);                        
        end
        %display(min_value);
        out(i, j) = min_value;
    end
end
%figure, imshow(mat2gray(out));
%display(count);
out = uint8(out);
end