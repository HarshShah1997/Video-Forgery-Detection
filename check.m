srno = 122;
temp = [];
for srno=122:128
    org = rgb2gray(imread('Videos/10_original/frame122.jpg'));
subplot(2, 4, 1), imshow(org1);

org2 = rgb2gray(imread('10_original/frame123.jpg'));
subplot(2, 4, 2), imshow(org2);

org3 = rgb2gray(imread('10_original/frame124.jpg'));
subplot(2, 4, 3), imshow(org3);

forg1 = rgb2gray(imread('10_forged/frame122.jpg'));
subplot(2, 4, 5), imshow(forg1);

forg2 = rgb2gray(imread('10_forged/frame123.jpg'));
subplot(2, 4, 6), imshow(forg2);

forg3 = rgb2gray(imread('10_forged/frame124.jpg'));
subplot(2, 4, 7), imshow(forg3);

%suborg = org2 - org1;
%subforg = forg2 - forg1;

temp(1, :, :) = org1;
temp(2, :, :) = org2;
temp(3, :, :) = org3;
temp = uint8(temp);
res_org = imsubtract(org2, collusion_min(temp));

figure, subplot(1, 2, 1), imshow(imadjust(res_org));

temp = [];
temp(1, :, :) = forg1;
temp(2, :, :) = forg2;
temp(3, :, :) = forg3;
temp = uint8(temp);
res_forg = imsubtract(forg2, collusion_min(temp));

subplot(1, 2, 2), imshow(imadjust(res_forg));


%suborg = ((suborg));
%subforg = ((subforg));

%subplot(2, 3, 3), imshow(suborg);
%subplot(2, 3, 6), imshow(subforg);

%figure, subplot(1, 2, 1), imhist(suborg);
%subplot(1, 2, 2), imhist(subforg);