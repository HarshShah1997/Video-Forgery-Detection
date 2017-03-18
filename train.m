cover = load('Variables/cover_1-5.mat');
cover = cover.cover_features;

stego = load('Variables/stego_1-5.mat');
stego = stego.stego_features;

%[trained_ensemble,results] = ensemble_training(cover,stego);

