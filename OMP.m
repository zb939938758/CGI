function [A]=OMP(D, X, L) 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       L - the max. number of coefficients for each signal.
% output arguments: 
%       A - sparse coefficient matrix.
%=============================================

% A - 稀疏矩阵
% D - 字典/测量矩阵（已知）
% X - 测量值矩阵（已知）
% K - 稀疏度
% L - the maximal number of coefficient for representation

% X = X'; D = D';
[~, P] = size(X);
[~, K] = size(D);
for k = 1:P
    a = [];
    x = X(:, k);
    residual = x;% 残差
    indx = zeros(L, 1);% 索引集
    for j = 1:L
        proj = D' * residual;       % D转置与residual相乘，得到与residual与D每一列的内积值
        [~, pos] = max(abs(proj));  % 找到内积最大值的位置
        pos = pos(1);               % 若最大值不止一个，取第一个
        indx(j) = pos;              % 将这个位置存入索引集的第j个值
        a = pinv(D(:, indx(1:j))) * x;  % indx(1:j)表示第一列前j个元素		% pinv伪逆矩阵
        residual = x - D(:, indx(1:j)) * a;
        if sum(residual.^2) < 1e-6
            break;
        end
    end;
    temp = zeros(K, 1);
    temp(indx(1:j)) = a;
    A(:, k) = sparse(temp);%只显示非零值及其位置
    A = full(A);
end;
return;
