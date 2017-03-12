srno = [1:6];
org = [];
count = 1;
for i=1:size(srno, 2)
    framename = strcat('frame', int2str(srno(i)), '.jpg');
    temp = rgb2gray(imread(strcat('Videos/01_original_enc10/', framename)));
    org(count, :, :) = temp;
    count = count + 1;    
end
org = uint8(org);

forg = [];
count = 1;
for i=1:size(srno, 2)
    framename = strcat('frame', int2str(srno(i)), '.jpg');
    temp = rgb2gray(imread(strcat('Videos/01_forged_enc10/', framename)));
    forg(count, :, :) = temp;
    count = count + 1;    
end
forg = uint8(forg);

%forg1 = rgb2gray(imread('10_forged/frame122.jpg'));
%subplot(2, 4, 5), imshow(forg1);

%forg2 = rgb2gray(imread('10_forged/frame123.jpg'));
%subplot(2, 4, 6), imshow(forg2);

%forg3 = rgb2gray(imread('10_forged/frame124.jpg'));
%subplot(2, 4, 7), imshow(forg3);

%suborg = org2 - org1;
%subforg = forg2 - forg1;

original = reshape(org(1, :, :), [size(org, 2), size(org, 3)]);
res_org = imsubtract(original, collusion_min(org));
subplot(1, 2, 1), imshow(res_org);

forged = reshape(forg(1, :, :), [size(forg, 2), size(forg, 3)]);
res_forg = imsubtract(forged, collusion_min(forg));
subplot(1, 2, 2), imshow(res_forg);

%temp = [];
%temp(1, :, :) = forg1;
%temp(2, :, :) = forg2;
%temp(3, :, :) = forg3;
%temp = uint8(temp);
%res_forg = imsubtract(forg2, collusion_min(temp));

%subplot(1, 2, 2), imshow(imadjust(res_forg));


%suborg = ((suborg));
%subforg = ((subforg));

%subplot(2, 3, 3), imshow(suborg);
%subplot(2, 3, 6), imshow(subforg);

%figure, subplot(1, 2, 1), imhist(suborg);
%subplot(1, 2, 2), imhist(subforg);