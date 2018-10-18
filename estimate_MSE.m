function MSE = estimate_MSE( A, B )
%calculateMSE : calculate the MSE between original and decoded image.
%   MSE - mean square error.
%   MSE = sum(sum((A - B).^2))/(M * N)
%   original - original image
%   decode - decoded image

    [row, col, layer] = size(A);
    [r, c, l] = size(B);
    if(row ~= r || col ~= c || layer ~= l), error('size is wrong'); end
    
    switch layer
        case 1
            original = int32(abs(A));
            decode = int32(abs(B));
            MSE = sum(sum((original - decode).^2))/(row * col);
        case 3
            A = int32(abs(A));
            B = int32(abs(B));
            MSE_1 = sum(sum((A(:, :, 1) - B(:, :, 1)).^2))/(row * col);
            MSE_2 = sum(sum((A(:, :, 2) - B(:, :, 2)).^2))/(row * col);
            MSE_3 = sum(sum((A(:, :, 3) - B(:, :, 3)).^2))/(row * col);
            MSE = (MSE_1 + MSE_2 + MSE_3)/3;
        otherwise
            MSE = 0;
            disp('cannot support the size');
    end

end

