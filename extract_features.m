cover_features = [];
stego_features = [];

feature = extract_features_file('Variables/01_original.mat');  
cover_features = [cover_features feature];

feature = extract_features_file('Variables/01_forged.mat');
stego_features = [stego_features feature];

feature = extract_features_file('Variables/02_original.mat');
cover_features = [cover_features ; feature];

feature = extract_features_file('Variables/02_forged.mat');
stego_features = [stego_features ; feature];

feature = extract_features_file('Variables/03_original.mat');
cover_features = [cover_features ; feature];

feature = extract_features_file('Variables/03_forged.mat');
stego_features = [stego_features ; feature];







