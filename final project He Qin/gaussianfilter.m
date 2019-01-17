function f = gaussianfilter(image, cutoff)
    
[rows,cols] = size(image);
[u,v] = meshgrid(1:1:cols,1:1:rows);
D = sqrt( (u-cols/2).^2 + (v-rows/2).^2 );
f =exp(-0.5*(cutoff./D)^2);