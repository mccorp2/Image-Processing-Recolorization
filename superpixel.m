function [outputImage] = superpixel(im_name)

A = im_name;

[L1,N1] = superpixels(A,floor(2*sqrt(size(A,1)*size(A,2))));
BW = boundarymask(L);
im = imoverlay(A,BW,'cyan');


[L2,N2] = superpixels(A,floor(sqrt(2*size(A,1)*size(A,2))/1.5));
BW = boundarymask(L);
im = imoverlay(im, BW, 'magenta');


[L3,N3] = superpixels(A,floor(sqrt(size(A,1)*size(A,2))/2));
figure
BW = boundarymask(L);
outputImage = imshow(imoverlay(im,BW,'yellow'));
end