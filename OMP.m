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

% A - ϡ�����
% D - �ֵ�/����������֪��
% X - ����ֵ������֪��
% K - ϡ���
% L - the maximal number of coefficient for representation

% X = X'; D = D';
[~, P] = size(X);
[~, K] = size(D);
for k = 1:P
    a = [];
    x = X(:, k);
    residual = x;% �в�
    indx = zeros(L, 1);% ������
    for j = 1:L
        proj = D' * residual;       % Dת����residual��ˣ��õ���residual��Dÿһ�е��ڻ�ֵ
        [~, pos] = max(abs(proj));  % �ҵ��ڻ����ֵ��λ��
        pos = pos(1);               % �����ֵ��ֹһ����ȡ��һ��
        indx(j) = pos;              % �����λ�ô����������ĵ�j��ֵ
        a = pinv(D(:, indx(1:j))) * x;  % indx(1:j)��ʾ��һ��ǰj��Ԫ��		% pinvα�����
        residual = x - D(:, indx(1:j)) * a;
        if sum(residual.^2) < 1e-6
            break;
        end
    end;
    temp = zeros(K, 1);
    temp(indx(1:j)) = a;
    A(:, k) = sparse(temp);%ֻ��ʾ����ֵ����λ��
    A = full(A);
end;
return;
