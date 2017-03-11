function F = ccpev548(FILE,QF)
% -------------------------------------------------------------------------
% Copyright (c) 2011 DDE Lab, Binghamton University, NY.
% All Rights Reserved.
% -------------------------------------------------------------------------
% Permission to use, copy, modify, and distribute this software for
% educational, research and non-profit purposes, without fee, and without a
% written agreement is hereby granted, provided that this copyright notice
% appears in all copies. The program is supplied "as is," without any
% accompanying services from DDE Lab. DDE Lab does not warrant the
% operation of the program will be uninterrupted or error-free. The
% end-user understands that the program was developed for research purposes
% and is advised not to rely exclusively on the program for any reason. In
% no event shall Binghamton University or DDE Lab be liable to any party
% for direct, indirect, special, incidental, or consequential damages,
% including lost profits, arising out of the use of this software. DDE Lab
% disclaims any warranties, and has no obligations to provide maintenance,
% support, updates, enhancements or modifications.
% -------------------------------------------------------------------------
% Contact: jan@kodovsky.com | fridrich@binghamton.edu | November 2011
%          http://dde.binghamton.edu/download/feature_extractors
% -------------------------------------------------------------------------
% This function extracts CC-PEV features from the JPEG image specified with
% its path 'FILE'. CC-PEV features are 274 DCT domain features introduced
% in [1] extended by Cartesian calibration [2]. Cartesian calibration
% additionally extracts those 274 features from the so-called reference
% image, which is the decompressed, cropped (by 4x4) and recompressed
% version of the original image. The JPEG quality factor of the
% recompression needs to be specified by QF. Total dimensionality of the
% features is 2 x 274 = 548.
% -------------------------------------------------------------------------
% Input:  FILE ... path to the JPEG image
%         QF ..... JPEG quality factor of the reference image (we
%                   recommend to keep it the same as the original image QF)
% Output: F ...... extracted CC-PEV features
% -------------------------------------------------------------------------
% IMPORTANT: For accessing DCT coefficients of JPEG images, we use Phil
% Sallee's Matlab JPEG toolbox (function jpeg_read) available at
% http://philsallee.com/jpegtbx/
% -------------------------------------------------------------------------
% [1] T. Pevny and J. Fridrich.  Merging Markov and DCT features for multi-
%     class JPEG steganalysis. In E. J. Delp and P. W. Wong,  editors, Pro-
%     ceedings  SPIE,  Electronic  Imaging,  Security,  Steganography,  and
%     Watermarking of Multimedia Contents IX,  volume 6505, pages 3 1–3 14,
%     San Jose, CA, January 29–February 1, 2007.
% [2] J. Kodovsky and J. Fridrich.  Calibration revisited.  In J. Dittmann,
%     S. Craver, and J. Fridrich, editors, Proceedings of the 11th ACM Mul-
%     timedia & Security Workshop, Princeton, NJ, September 7–8, 2009.
% -------------------------------------------------------------------------

% non-calibrated part
[D,X] = deal(DCTPlane(FILE),double(imread(FILE)));

[DctPart]=ExtractExtendedDCTFeatures_noCalibration_new(D,X);
[MarkovPart] = ExtractMarkovPart_new(abs(D));
F=[DctPart reshape(MarkovPart,1,[])];

% reference image for calibration
[FILE_REF] = create_reference_image(X,QF);
[D,X] = deal(DCTPlane(FILE_REF),double(imread(FILE_REF)));
delete(FILE_REF);
[DctPart]=ExtractExtendedDCTFeatures_noCalibration_new(D,X);
[MarkovPart] = ExtractMarkovPart_new(abs(D));
F=[F DctPart reshape(MarkovPart,1,[])]; % append second half (reference version)

% ORDER OF THE FEATURES:
% F(1:11) - global histogram
% F(12:66) - local histograms
% F(67:165) - dual histograms
% F(166) - variation
% F(167:168) - blockiness features
% F(169:193) - cooccurrence
% F(194:274) - Markov features


function [MarkovPart] = ExtractMarkovPart_new(absDctPlane)
Fh=absDctPlane(:,1:end-1) - absDctPlane(:,2:end);
Fv=absDctPlane(1:end-1,:) - absDctPlane(2:end,:);
Fd=absDctPlane(1:end-1,1:end-1) - absDctPlane(2:end,2:end);
Fm=absDctPlane(2:end,1:end-1) - absDctPlane(1:end-1,2:end);
OrMh=calculateMarkovField2(Fh(:,1:end-1),Fh(:,2:end),4);
OrMv=calculateMarkovField2(Fv(1:end-1,:),Fv(2:end,:),4);
OrMd=calculateMarkovField2(Fd(1:end-1,1:end-1),Fd(2:end,2:end),4);
OrMm=calculateMarkovField2(Fm(2:end,1:end-1),Fm(1:end-1,2:end),4);
MarkovPart=0.25*(OrMh+OrMv+OrMd+OrMm);
function field=calculateMarkovField2(reference,shifted,T)
field=zeros(2*T+1,2*T+1);
R=reference(:);
S=shifted(:);
R(R>T)=T; R(R<-T)=-T;
S(S>T)=T; S(S<-T)=-T;
for i=-T:T
    S2 = S(R==i);
    h=hist(S2,-T:T);
    h=h/max(length(S2),1);
    field(i+T+1,:)=h;
end
function [F]=ExtractExtendedDCTFeatures_noCalibration_new(OriginalDct,SpatialImage)
% [F]=ExtractFeatures(image_name);

%----------------GLOBAL HISTOGRAM---------------------
H = hist(OriginalDct(:),-6:6);
F = H(2:end-1)/sum(H);
%--------------LOCAL HISTOGRAMs-----------------------
modes=[2 1;3 1;1 2;2 2;1 3];
for i=1:5
    Original = OriginalDct(modes(i,1):8:end,modes(i,2):8:end);
    H = hist(Original(:),-6:6);
    F = [F H(2:end-1)/sum(H)];
end
%---------------DUAL HISTOGRAM------------------------
%Dual histograms in range -5 to 5
modes=[2 1;1 2;3 1;2 2;1 3;4 1;3 2;2 3;1 4];
for value=-5:5
  T = zeros(1,9);
  for i=1:9
      T(i)=sum(sum(OriginalDct(modes(i,1):8:end,modes(i,2):8:end)==value));
  end
  F = [F T/max(sum(OriginalDct(:)==value),1)];
end
%----------------VARIATION FEATUREs--------------------
A = sum(sum(abs(OriginalDct(:,1:end-8)-OriginalDct(:,9:end))))/numel(OriginalDct(:,1:end-8));
B = sum(sum(abs(OriginalDct(1:end-8,:)-OriginalDct(9:end,:))))/numel(OriginalDct(1:end-8,:));
F = [F (A+B)/2];
%----------------BLOCKINESS FEATURE--------------------
[N M]=size(SpatialImage); C=N*floor((M-1)/8)+M*floor((N-1)/8);
Dw_H=reshape(abs(SpatialImage(8:8:N-1,:)-SpatialImage(9:8:N,:)),1,[]);
Dw_V=reshape(abs(SpatialImage(:,8:8:M-1)-SpatialImage(:,9:8:M)),1,[]);
F = [F (sum(Dw_H)+sum(Dw_V))/C]; %L1 blockiness
F = [F (sum(Dw_H.^2)+sum(Dw_V.^2))/C]; %L2 blockiness
%-------------COOCCURENCE MATRIX-----------------------
OriginalDct = min(max(OriginalDct,-3),3);
OriginalDct(1:8:end,1:8:end) = -1e8;
% vertical part
x = reshape(OriginalDct(1:end-8,:),1,[]);
y = reshape(OriginalDct(9:end,:),1,[]);
toRemove = x==-1e8|y==-1e8; x(toRemove)=[]; y(toRemove)=[];
Mv = reshape(ind2sub([7 7],hist(sub2ind([7 7],x+4,y+4),1:7*7))/length(x),7,7);

% horizontal part
x = reshape(OriginalDct(:,1:end-8),1,[]);
y = reshape(OriginalDct(:,9:end),1,[]);
toRemove = x==-1e8|y==-1e8; x(toRemove)=[]; y(toRemove)=[];
Mh = reshape(ind2sub([7 7],hist(sub2ind([7 7],x+4,y+4),1:7*7))/length(x),7,7);
F = [F reshape((Mv(2:6,2:6)+Mh(2:6,2:6))/2,1,[])];
function Plane = DCTPlane(path)
jobj=jpeg_read(path);
Plane=jobj.coef_arrays{1};
function [FILE_REF] = create_reference_image(X,QF)
X = uint8(X(5:end-4,5:end-4));
FILE_REF = ['img_' num2str(round(rand()*1e7)) num2str(round(rand()*1e7)) '.jpg']; % temporary reference image
while exist(FILE_REF,'file'), FILE_REF = ['img_' num2str(round(rand()*1e7)) num2str(round(rand()*1e7)) '.jpg']; end
imwrite(X,FILE_REF,'Quality',QF);
