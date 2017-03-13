function [out] = collusion_median(inp)
if size(inp) == 0
    return
end
height = size(inp, 2);
width = size(inp, 3);
out = [];
count = 0;
for i = 1:height
    for j = 1:width
        arr = zeros(size(inp, 1));
        for k = 1:size(inp, 1)           
            arr(k) = inp(k, i, j);
            count = count + 1;
            %disp = sprintf('i %d j %d value %d', i, j, inp(k, i, j));            
            %display(disp);                        
        end
        %display(min_value);
        arr = sort(arr);
        num1 = arr(idivide(size(inp, 1), int32(2), 'floor'));
        num2 = arr(idivide(size(inp, 1), int32(2), 'ceil'));
        out(i, j) = idivide(num1 + num2, int32(2));
    end
end
%figure, imshow(mat2gray(out));
%display(count);
out = uint8(out);
end