original_01 = load('Variables/01_original.mat');
original_01 = original_01.residuals_01_org;
org = reshape(original_01(1,:,:), [size(original_01, 2), size(original_01, 3)]);
subplot(2,1,1), imshow(org);

forged_01 = load('Variables/01_forged.mat');
forged_01 = forged_01.forged_01;
forg = reshape(forged_01(1,:,:), [size(forged_01, 2), size(forged_01, 3)]);
subplot(2,1,2),imshow(forg);
