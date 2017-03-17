trained_ensemble = load('Variables/trained_1-5.mat');
trained_ensemble = trained_ensemble.trained_ensemble;

cover = load('Variables/cover_5-9.mat');
cover = cover.cover_features;

stego = load('Variables/stego_5-9.mat');
stego = stego.stego_features;

test_results_cover = ensemble_testing(cover,trained_ensemble);