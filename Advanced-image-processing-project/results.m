image = cell(1,3);
image{1} = ['1.jpg'];
image{2} = ['4.jpg'];
image{3} = ['5.jpg'];
for i = 1:3
im = readIm(image{i});
J = deHaze(im);
figure;
subplot(1,2,1);
imagesc(im)
title 'Original'
axis image off;
subplot(1,2,2);
imagesc(J)
title 'De-hazed'
axis image off;
end


