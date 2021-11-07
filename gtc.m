function [gray_out, A] = gtc(gray_im)
%GRAYSCALE_TO_COLOR Summary of this function goes here
%   Detailed explanation goes here
    gray_im = rgb2gray(gray_im);
    gray_out = zeros(size(gray_im, 1), size(gray_im, 2), 3);

    gray_out(:,:,1) = gray_im;
    gray_out(:,:,2) = gray_im;
    gray_out(:,:,3) = gray_im;
    
    numColors = input("How many colors are there?");
    
    
    
    f1 = figure;
    colorSpectrum = imread('colorSpectrum.png');
    imshow(colorSpectrum)
    [x, y] = ginput(1);
    x = floor(x);
    y = floor(y);
    close(f1);
    r = colorSpectrum(y,x, 1);
    g = colorSpectrum(y,x, 2);
    b = colorSpectrum(y,x, 3);
    currentColor = color(r,g,b,x,y);
    
    f2 = figure;
    imshow(gray_im)
    [x, y] = getpts();
    for numOfPoints = 1:size(x)
        currentColor = addPoint(currentColor, floor(x), floor(y));
    end
    close(f2);
    
    cdata = [currentColor];
    
    for numOfColors = 2:numColors
        f1 = figure;
        colorSpectrum = imread('colorSpectrum.png');
        imshow(colorSpectrum)
        [x, y] = ginput(1);
        close(f1);

        x = floor(x);
        y = floor(y);
        r = colorSpectrum(y,x, 1);
        g = colorSpectrum(y,x, 2);
        b = colorSpectrum(y,x, 3);
        currentColor = color(r,g,b,x,y);

        f2 = figure;
        imshow(gray_im)
        [x, y] = getpts();
        for numOfPoints = 1:size(x)
            currentColor = addPoint(currentColor, floor(x), floor(y));
        end
        close(f2); 
        
        cdata = [cdata currentColor];
    end
    
    c = size(cdata, 2);
    A = cell(c);
    
    for x = 1:c
        A{x} = uint8(zeros(size(gray_im, 1), size(gray_im, 2), 3));
        currentPoints = returnPoints(cdata(x));
        currentColor = returnColor(cdata(x));
        for y = 1:size(returnPoints(cdata(x)))

            A{x}(currentPoints(y, 2), currentPoints(y, 1), 1) = currentColor(1);
            A{x}(currentPoints(y, 2), currentPoints(y, 1), 2) = currentColor(2);
            A{x}(currentPoints(y, 2), currentPoints(y, 1), 3) = currentColor(3);
            
            
            %A{x}(cdata(x, 2), cdata(x, 1), 1) = cdata(x , 3);
            %A{x}(cdata(x, 2), cdata(x, 1), 2) = cdata(x , 4);
            %A{x}(cdata(x, 2), cdata(x, 1), 3) = cdata(x , 5);
        end
    end
    
    nr = size(gray_im,1);
    nc = size(gray_im, 2);
    
    [L1,N1] = superpixels(gray_im,floor(10*sqrt(nr*nc)));
    [L2,N2] = superpixels(gray_im,floor(9*sqrt(2*nr*nc)));
    [L3,N3] = superpixels(gray_im,floor(8*sqrt(nr*nc)));
    
    idx1 = label2idx(L1);
    idx2 = label2idx(L2);
    idx3 = label2idx(L3);
    for iterations = 1:3
        for labelVal = 1:N1
            for x = 1:c
                redIdx = idx1{labelVal};
                greenIdx = idx1{labelVal}+nr*nc;
                blueIdx = idx1{labelVal}+2*nc*nr;
                currentColor = returnColor(cdata(x));
                if (mean(A{x}(redIdx))+ mean(A{x}(greenIdx))+ mean(A{x}(blueIdx))) > 0
                    A{x}(redIdx)   = currentColor(1);
                    A{x}(greenIdx) = currentColor(2);
                    A{x}(blueIdx)  = currentColor(3);
                end
            end
        end
        for labelVal = 1:N2
            for x = 1:c
                redIdx = idx2{labelVal};
                greenIdx = idx2{labelVal}+nr*nc;
                blueIdx = idx2{labelVal}+2*nc*nr;
                currentColor = returnColor(cdata(x));
                if (mean(A{x}(redIdx))+ mean(A{x}(greenIdx))+ mean(A{x}(blueIdx))) > 0
                    A{x}(redIdx)   = currentColor(1);
                    A{x}(greenIdx) = currentColor(2);
                    A{x}(blueIdx)  = currentColor(3);
                end
            end
        end
        for labelVal = 1:N3
            for x = 1:c
                redIdx = idx3{labelVal};
                greenIdx = idx3{labelVal}+nr*nc;
                blueIdx = idx3{labelVal}+2*nc*nr;
                currentColor = returnColor(cdata(x));
                if (mean(A{x}(redIdx))+ mean(A{x}(greenIdx))+ mean(A{x}(blueIdx))) > 0
                    A{x}(redIdx)   = currentColor(1);
                    A{x}(greenIdx) = currentColor(2);
                    A{x}(blueIdx)  = currentColor(3);
                end
            end
        end
    end
    
    gray_out = uint8(gray_out);
    c1 = A{1};
    c2 = A{2};
    c3 = A{3};
    
end

