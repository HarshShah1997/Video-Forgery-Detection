srno = [1:6];
res_org = create_residual('Videos/01_original_enc10/', srno);
subplot(1, 2, 1), imshow(res_org);

res_forg = create_residual('Videos/01_forged_enc10/', srno);
subplot(1, 2, 2), imshow(res_forg);
