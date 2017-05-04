# Video Forgery Detection

Detection of Object-Based Forgery in Advanced Video

## Dependencies ##
1. ffmpeg
2. MATLAB
3. Video dataset for training and testing (Available [here](https://sites.google.com/site/rewindpolimi/downloads/datasets/video-copy-move-forgeries-dataset))
4. JPEG toolbox (Included)
5. CC-PEV 548 (Included)
6. Ensemble Classifier (Included)

## Steps ##
1. Extract frames from a video using extract_frames.sh
2. Use main_residuals.m to extract motion residuals from frames
3. Use extract_features.m to extract CC-PEV features from motion residuals
4. Use train.m to train ensemble classifier with given features
5. Use test.m to test the classifier on new datasets
