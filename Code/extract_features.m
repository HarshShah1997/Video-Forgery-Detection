cover_features = [];
stego_features = [];

for i = 5:10
    filename_org = strcat('Variables/0', int2str(i), '_original.mat');
    feature = extract_features_file(filename_org);  
    cover_features = [cover_features ; feature];
    
    filename_forg = strcat('Variables/0', int2str(i), '_forged.mat');
    feature = extract_features_file(filename_forg);
    stego_features = [stego_features ; feature];
end





