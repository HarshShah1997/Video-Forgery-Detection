function [ans] = extract_features_file(filename)
struct_image = load(filename);
field = fieldnames(struct_image);
ans = getfield(struct_image,field{1});

for i=1:size(ans,1)
    img = reshape(ans(i,:,:), [size(ans,2), size(ans,3)]);
    subplot(4, 2, i), imshow(img);
end
end
