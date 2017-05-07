trained_ensemble = load('Variables/trained_1-5.mat');
trained_ensemble = trained_ensemble.trained_ensemble;

cover = load('Variables/cover_5-9.mat');
cover = cover.cover_features;

stego = load('Variables/stego_5-9.mat');
stego = stego.stego_features;

% -1 stands for cover, 1 for stego
%test_results_cover = ensemble_testing(cover,trained_ensemble);
%test_results_stego = ensemble_testing(stego,trained_ensemble);

test_results_cover = load('Variables/test_results_cover.mat');
test_results_cover = test_results_cover.test_results_cover;

test_results_stego = load('Variables/test_results_stego.mat');
test_results_stego = test_results_stego.test_results_stego;

predictions_cover = test_results_cover.predictions;
predictions_stego = test_results_stego.predictions;

cover_true = 0;
cover_false = 0;

for i=1:size(predictions_cover,1)
    if predictions_cover(i) == -1
        cover_true = cover_true + 1;
    else
        cover_false = cover_false + 1;
    end
end

stego_true = 0;
stego_false = 0;
for i=1:size(predictions_stego,1)
    if predictions_stego(i) == 1
        stego_true = stego_true + 1;
    else
        stego_false = stego_false + 1;
    end
end

total = stego_true + stego_false + cover_true + cover_false;

accuracy = (cover_true + stego_true) / total

tp_rate = stego_true / (stego_true + stego_false)

fp_rate = cover_false / (cover_true + cover_false)

specificity = cover_true / (cover_true + cover_false)

precision = stego_true / (stego_true + cover_false)

prevalence = (stego_true + stego_false) / total

recall = tp_rate

fscore = (2 * precision * recall) / (precision + recall)




