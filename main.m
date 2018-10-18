clear all,
close all,
clc

pic = imread('Lena64.bmp');
[m, n] = size(pic);
T = dct2(pic);

N = m*n;
M = 2000;

Phi = zeros(M, N);

for i = 1:M
    I_i = randn(m, n);
    Phi(i, :) = reshape(I_i, 1, N);
end

X = reshape(T, N, 1);
B = Phi * X;


K = 512;
X_re = OMP(Phi, B, K);
%sigma_min = 0.004;
%X_re = SL0(Phi, B, sigma_min);

T_re = reshape(X_re, m, n);
pic_re = idct2(T_re);
figure, imshow(pic_re, [])

estimate_MSE(pic, pic_re)