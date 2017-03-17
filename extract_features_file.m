function [features] = extract_features_file(filename)
struct_image = load(filename);
field = fieldnames(struct_image);
all_images = getfield(struct_image,field{1});
features = [];

for i=1:size(all_images,1)
    img = reshape(all_images(i,:,:), [size(all_images,2), size(all_images,3)]);
    imwrite(img, 'temp.jpg');
    features(i, :) = ccpev548('temp.jpg', 75);
    delete 'temp.jpg';
end
end
